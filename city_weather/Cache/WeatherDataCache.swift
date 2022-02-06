//
//  WeatherDataCache.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/5/22.
//

import Foundation
import CoreData

protocol WeatherDataCacheProtocol{
    func allLocations() -> [Location]
    func createDefaultLocations()
    func saveLocation(location: Location)
    func getlocation(by woeid: Int) -> LocationEntity?
}

class WeatherDataCache: WeatherDataCacheProtocol{
    private let persistentContainer: NSPersistentContainer?

    init(persistentContainer: NSPersistentContainer?){
        self.persistentContainer = persistentContainer
    }
    
    func allLocations() -> [Location]{
        guard let managedContext = persistentContainer?.viewContext else { return [] }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "LocationEntity")
        
        guard let result = try? managedContext.fetch(fetchRequest),
        let resultData = result as? [NSManagedObject] else { return [] }
        
        return resultData.map { object in
            Location.init(from: object)
        }
    }
    
    func getlocation(by woeid: Int) -> LocationEntity?{
        guard let managedContext = persistentContainer?.viewContext else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "LocationEntity")
        fetchRequest.predicate = NSPredicate(format: "woeid = %ld", woeid)
        
        guard let result = try? managedContext.fetch(fetchRequest),
        let locationEntity = result[0] as? LocationEntity else { return nil }
        
        return locationEntity
    }
    
    fileprivate func setLocationParent(_ location: Location, _ managedContext: NSManagedObjectContext, _ locationEntity: LocationEntity) {
        if let parent = location.parent{
            let parentEntity = ParentEntity.init(context: managedContext)
            parentEntity.woeid = Int32(parent.woeid ?? 0)
            parentEntity.location_type = parent.location_type
            parentEntity.latt_long = parent.latt_long
            parentEntity.title = parent.title
            parentEntity.location = locationEntity
            locationEntity.setValue(parentEntity, forKey: "parent")
        }
    }
    
    fileprivate func initializeConsolidatedWeather(_ cw: ConsolidatedWeatherEntity, _ item: ConsolidatedWeather) {
        cw.air_pressure = item.air_pressure ?? 0
        cw.applicable_date = item.applicable_date
        cw.created = item.created
        cw.humidity = Int32(item.humidity ?? 0)
        cw.id = Int64(item.id ?? 0)
        cw.max_temp = Int32(item.max_temp ?? 0)
        cw.min_temp = Int32(item.min_temp ?? 0)
        cw.the_temp = Int32(item.the_temp ?? 0)
        cw.predictability = Int32(item.predictability ?? 0)
        cw.weather_state_abbr = item.weather_state_abbr
        cw.weather_state_name = item.weather_state_name
        cw.wind_speed = item.wind_speed ?? 0
        cw.wind_direction = item.wind_direction ?? 0
        cw.wind_direction_compass = item.wind_direction_compass
        cw.visibility = item.visibility ?? 0
    }
    
    func saveLocation(location: Location){
        guard let managedContext = persistentContainer?.viewContext else { return }
        var locationEntity: LocationEntity
        
        if let locationToUpdate = getlocation(by: location.woeid ?? 0){
            locationEntity = locationToUpdate
        } else{
            locationEntity = LocationEntity.init(context: managedContext)
        }
        
        locationEntity.title = location.title
        locationEntity.woeid = Int32(location.woeid ?? 0)
        locationEntity.timezone = location.timezone
        locationEntity.latt_long = location.latt_long
        locationEntity.timezone_name = location.timezone_name
        locationEntity.location_type = location.location_type
        locationEntity.sun_set = location.sun_set
        locationEntity.sun_rise = location.sun_rise
        locationEntity.time = location.time
        
        setLocationParent(location, managedContext, locationEntity)
        
        location.sources?.forEach({ item in
            let sourceEntity = SourcesEntity.init(context: managedContext)
            sourceEntity.title = item.title
            sourceEntity.crawl_rate = Int32(item.crawl_rate ?? 0)
            sourceEntity.slug = item.slug
            sourceEntity.url = item.url
            sourceEntity.location = locationEntity
            locationEntity.addToSource(sourceEntity)
        })
        
        location.consolidated_weather?.forEach({ item in
            let cw = ConsolidatedWeatherEntity.init(context: managedContext)
            initializeConsolidatedWeather(cw, item)
            locationEntity.addToConsolidated_weather(cw)
        })
        
        do{
            try locationEntity.managedObjectContext?.save()
        }catch{
            print(error)
        }
        
        saveContext()
    }
    
    func createDefaultLocations(){
        guard let managedContext = persistentContainer?.viewContext else { return }
        let defaultLocations = [(name: "Sofia", woeid: 839722),(name: "NY", woeid: 2459115),(name: "Tokyo", woeid: 1118370)]
        defaultLocations.forEach { name, woeid in
            let newLocation = LocationEntity.init(context: managedContext)
            newLocation.title = name
            newLocation.woeid = Int32(woeid)
            saveContext()
        }
    }
    
    fileprivate func saveContext () {
        guard let persistentContainer = persistentContainer else {
            return
        }

        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
