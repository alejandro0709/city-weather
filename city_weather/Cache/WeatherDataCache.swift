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
    func location(by woeid: Int) -> Location?
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
    
    func location(by woeid: Int) -> Location?{
        guard let locationEntity = getlocationEntity(by: woeid) else { return nil }
        return Location.init(from: locationEntity)
    }
    
    func saveLocation(location: Location){
        guard let managedContext = persistentContainer?.viewContext else { return }
        let locationEntity = getLocationEntityToAddOrUpdate(location.woeid ?? 0, managedContext)
        
        locationEntity.title = location.title
        locationEntity.woeid = Int32(location.woeid ?? 0)
        locationEntity.timezone = location.timezone
        locationEntity.latt_long = location.latt_long
        locationEntity.timezone_name = location.timezone_name
        locationEntity.location_type = location.location_type
        locationEntity.sun_set = location.sun_set
        locationEntity.sun_rise = location.sun_rise
        locationEntity.time = location.time
        
        location.consolidated_weather?.forEach({ item in
            if let cw = initializeConsolidatedWeather(item, managedContext){
                locationEntity.addToConsolidated_weather(cw)
            }
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
}


extension WeatherDataCache{
    
    fileprivate func getlocationEntity(by woeid: Int) -> LocationEntity?{
        guard let managedContext = persistentContainer?.viewContext else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "LocationEntity")
        fetchRequest.predicate = NSPredicate(format: "woeid = %ld", woeid)
        
        guard let result = try? managedContext.fetch(fetchRequest),
        let locationEntity = result[0] as? LocationEntity else { return nil }
        
        return locationEntity
    }
    
    fileprivate func getConsolidatedWeather(by id: Int) -> ConsolidatedWeatherEntity?{
        guard let managedContext = persistentContainer?.viewContext else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "ConsolidatedWeatherEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %ld", id)
        
        guard let result = try? managedContext.fetch(fetchRequest),
              !result.isEmpty,
              let entity = result.first as? ConsolidatedWeatherEntity else { return nil }
        
        return entity
    }
    
    fileprivate func initializeConsolidatedWeather(_ item: ConsolidatedWeather, _ managedContext: NSManagedObjectContext) -> ConsolidatedWeatherEntity? {
        let cwEntity: ConsolidatedWeatherEntity
        var newObject = true
        
        if let entitySaved = getConsolidatedWeather(by: item.id ?? 0){
            cwEntity = entitySaved
            newObject = false
        } else {
            cwEntity = ConsolidatedWeatherEntity.init(context: managedContext)
            cwEntity.id = Int64(item.id ?? 0)
        }
        
        cwEntity.air_pressure = item.air_pressure ?? 0
        cwEntity.applicable_date = item.applicable_date
        cwEntity.created = item.created
        cwEntity.humidity = Int32(item.humidity ?? 0)
        cwEntity.max_temp = Int32(item.max_temp ?? 0)
        cwEntity.min_temp = Int32(item.min_temp ?? 0)
        cwEntity.the_temp = Int32(item.the_temp ?? 0)
        cwEntity.predictability = Int32(item.predictability ?? 0)
        cwEntity.weather_state_abbr = item.weather_state_abbr
        cwEntity.weather_state_name = item.weather_state_name
        cwEntity.wind_speed = item.wind_speed ?? 0
        cwEntity.wind_direction = item.wind_direction ?? 0
        cwEntity.wind_direction_compass = item.wind_direction_compass
        cwEntity.visibility = item.visibility ?? 0
        
        return newObject ? cwEntity : nil
    }
    
    fileprivate func getLocationEntityToAddOrUpdate(_ woeid: Int, _ managedContext: NSManagedObjectContext) -> LocationEntity {
        guard let locationToUpdate = getlocationEntity(by: woeid) else {
            return LocationEntity.init(context: managedContext)
        }
        
        return locationToUpdate
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
