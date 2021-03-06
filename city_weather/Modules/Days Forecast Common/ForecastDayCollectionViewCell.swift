//
//  ForecastDayCollectionViewCell.swift
//  city_weather
//
//  Created by Alejandro Guerra on 2/4/22.
//

import Foundation
import UIKit

class ForecastDayCollectionViewCell : UICollectionViewCell {
    static let reuseIdentifier = "ForecastDayCollectionViewCell"
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let tempLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min"
        label.textAlignment = .center
        return label
    }()
    
    let minTempValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max"
        label.textAlignment = .center
        return label
    }()
    
    let maxTempValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let visibilityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let predictabilityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airPressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let windDirectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var headerContainer = UIView()
    var bottomContainer = UIView()
    
    var dateConstraints = [NSLayoutConstraint]()
    
    var tempConstraintsForLocationDetail = [NSLayoutConstraint]()
    var tempConstraintsForLocationDay = [NSLayoutConstraint]()
    
    let minMaxTemptGuide: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.90)
        layer.cornerRadius = 4
        
        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(headerContainer)
        let headerBottomLine = UIView()
        headerBottomLine.translatesAutoresizingMaskIntoConstraints = false
        headerBottomLine.backgroundColor = .white
        contentView.addSubview(headerBottomLine)
        headerBottomLine.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor).isActive = true
        headerBottomLine.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor).isActive = true
        headerBottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        headerContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        setupDateView()
        setupWeatherImage()
        setupPrincipalTempetureViewConstraint()
        setupTempeturesViewsConstraints(headerBottomLine)
        setupBottomContainerConstraint(headerBottomLine)
        setupTemperatureViewsConstraintsVariant(headerBottomLine: headerBottomLine)
    }
    
    fileprivate func setupDateView() {
        headerContainer.addSubview(dateLabel)
        dateConstraints = [dateLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
                          dateLabel.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor)
        ]
    }
    
    fileprivate func setupWeatherImage() {
        headerContainer.addSubview(weatherImageView)
        weatherImageView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor).isActive = true
        weatherImageView.topAnchor.constraint(equalTo: headerContainer.topAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        weatherImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    fileprivate func setupPrincipalTempetureViewConstraint() {
        contentView.addSubview(tempLabel)
        tempConstraintsForLocationDetail.append(contentsOf: [
            tempLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerContainer.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            headerContainer.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor)
        ])
    }
    
    fileprivate func setupMinMaxTempeturesViewsConstraints(textLabel: UILabel, valueLabel: UILabel,
                                         minMaxTemptGuide: UIView, isMin: Bool = true){
        let tempContainer = UIView()
        tempContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempContainer)
        tempContainer.addSubview(textLabel)
        tempContainer.addSubview(valueLabel)
        
        tempConstraintsForLocationDetail.append(contentsOf: [
            tempContainer.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            tempContainer.widthAnchor.constraint(greaterThanOrEqualTo: textLabel.widthAnchor),
            tempContainer.widthAnchor.constraint(equalTo: valueLabel.widthAnchor, constant: 11),
            isMin ? tempContainer.trailingAnchor.constraint(equalTo: minMaxTemptGuide.leadingAnchor, constant: -2) : tempContainer.leadingAnchor.constraint(equalTo: minMaxTemptGuide.trailingAnchor, constant: 2),
            tempContainer.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            textLabel.topAnchor.constraint(equalTo: tempContainer.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            valueLabel.centerXAnchor.constraint(equalTo: tempContainer.centerXAnchor),
            valueLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor)
        ])
    }
    
    fileprivate func setupTempeturesViewsConstraints(_ headerBottomLine: UIView) {
        contentView.addSubview(minMaxTemptGuide)
        
        setupMinMaxTempeturesViewsConstraints(textLabel: minTempLabel, valueLabel: minTempValueLabel, minMaxTemptGuide: minMaxTemptGuide)
        setupMinMaxTempeturesViewsConstraints(textLabel: maxTempLabel, valueLabel: maxTempValueLabel, minMaxTemptGuide: minMaxTemptGuide, isMin: false)
                
        tempConstraintsForLocationDetail.append(contentsOf: [
            minMaxTemptGuide.centerXAnchor.constraint(equalTo: tempLabel.centerXAnchor),
            minMaxTemptGuide.widthAnchor.constraint(equalToConstant: 1),
            minMaxTemptGuide.topAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            minMaxTemptGuide.bottomAnchor.constraint(equalTo: maxTempValueLabel.bottomAnchor),
            headerBottomLine.topAnchor.constraint(equalTo: minMaxTemptGuide.bottomAnchor, constant: 8)
        ])
    }
    
    fileprivate func setupBottomContainerConstraint(_ headerBottomLine: UIView) {
        let centerView = UIView()
        contentView.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        contentView.addSubview(humidityLabel)
        humidityLabel.leadingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        humidityLabel.topAnchor.constraint(equalTo: headerBottomLine.bottomAnchor,constant: 8).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        contentView.addSubview(visibilityLabel)
        visibilityLabel.leadingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        visibilityLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor,constant: 4).isActive = true
        visibilityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        contentView.addSubview(predictabilityLabel)
        predictabilityLabel.leadingAnchor.constraint(equalTo: centerView.trailingAnchor).isActive = true
        predictabilityLabel.topAnchor.constraint(equalTo: visibilityLabel.bottomAnchor,constant: 4).isActive = true
        predictabilityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        
        contentView.addSubview(airPressureLabel)
        airPressureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        airPressureLabel.topAnchor.constraint(equalTo: headerBottomLine.bottomAnchor, constant: 8).isActive = true
        airPressureLabel.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -2).isActive = true
        
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(windDirectionLabel)
        
        windSpeedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        windSpeedLabel.topAnchor.constraint(equalTo: airPressureLabel.bottomAnchor,constant: 4).isActive = true
        windSpeedLabel.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -2).isActive = true
        
        windDirectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        windDirectionLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor,constant: 4).isActive = true
        windDirectionLabel.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -8).isActive = true
    }
    
    fileprivate func setupTemperatureViewsConstraintsVariant(headerBottomLine: UIView){
        tempConstraintsForLocationDay.append(contentsOf: [
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tempLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            headerBottomLine.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            minMaxTemptGuide.topAnchor.constraint(equalTo: tempLabel.topAnchor),
            minMaxTemptGuide.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor),
            minMaxTemptGuide.leadingAnchor.constraint(equalTo: tempLabel.trailingAnchor, constant: 8),
            minMaxTemptGuide.widthAnchor.constraint(equalToConstant: 1),
            minTempLabel.leadingAnchor.constraint(equalTo: minMaxTemptGuide.trailingAnchor, constant: 8),
            minTempLabel.topAnchor.constraint(equalTo: minMaxTemptGuide.topAnchor, constant: 2),
            minTempValueLabel.leadingAnchor.constraint(equalTo: minTempLabel.trailingAnchor, constant: 4),
            minTempValueLabel.centerYAnchor.constraint(equalTo: minTempLabel.centerYAnchor),
            maxTempLabel.leadingAnchor.constraint(equalTo: minMaxTemptGuide.trailingAnchor, constant: 8),
            maxTempLabel.bottomAnchor.constraint(equalTo: minMaxTemptGuide.bottomAnchor, constant: -2),
            maxTempValueLabel.leadingAnchor.constraint(equalTo: maxTempLabel.trailingAnchor, constant: 4),
            maxTempValueLabel.centerYAnchor.constraint(equalTo: maxTempLabel.centerYAnchor)
        ])
    }
    
    func setup(model: ForecastDayCollectionViewCellViewModel){
        dateLabel.text = model.applicableDate.prettyDate()
        
        dateLabel.isHidden = model.dayDetails
        
        tempLabel.font = UIFont.boldSystemFont(ofSize: !model.dayDetails ? 28 : 38)
        
        maxTempLabel.text = model.dayDetails ? "Max:" : "Max"
        minTempLabel.text = model.dayDetails ? "Min:" : "Min"
        
        if !model.dayDetails{
            NSLayoutConstraint.activate(dateConstraints)
            NSLayoutConstraint.activate(tempConstraintsForLocationDetail)
            
            NSLayoutConstraint.deactivate(tempConstraintsForLocationDay)
        } else {
            NSLayoutConstraint.activate(tempConstraintsForLocationDay)
            
            NSLayoutConstraint.deactivate(dateConstraints)
            NSLayoutConstraint.deactivate(tempConstraintsForLocationDetail)
        }
        
        setupTemperatureText(label: tempLabel, tempValue: Double(model.temp))
        setupTemperatureText(label: minTempValueLabel, tempValue: Double(model.minTemp))
        setupTemperatureText(label: maxTempValueLabel, tempValue: Double(model.maxTemp))
        
        setDesignToTextInLabel(completeText: "Humidity: \(model.humidity)%", textToEdit: "\(model.humidity)%", label: humidityLabel)
        
        let visibilityText = getValueFormatted(value: model.visibility, unit: UnitLength.miles)
        setDesignToTextInLabel(completeText: "Visibility: \(visibilityText)", textToEdit: visibilityText, label: visibilityLabel)
        setDesignToTextInLabel(completeText: "Predictability: \(model.predictability)%", textToEdit: "\(model.predictability)%", label: predictabilityLabel)
        setDesignToTextInLabel(completeText: "Air pressure: \(model.airPressure) mbar", textToEdit: "\(model.airPressure) mbar", label: airPressureLabel)
        
        let speedText = getValueFormatted(value: model.windSpeed, unit: UnitSpeed.milesPerHour)
        setDesignToTextInLabel(completeText: "Wind speed: \(speedText)", textToEdit: speedText, label: windSpeedLabel)
        
        let directionDegrees = getValueFormatted(value: model.windDirection, unit: UnitAngle.degrees)
        setDesignToTextInLabel(completeText: "Wind direction: \(model.windDirectionCompass), \(directionDegrees)", textToEdit: "\(model.windDirectionCompass), \(directionDegrees)", label: windDirectionLabel)
        
        weatherImageView.weatherImageByAbbr(abbr: model.weatherStateAbbr)
        setNeedsLayout()
    }
    
    fileprivate func getValueFormatted(value: Double, unit: Unit) -> String{
        let measurement = Measurement.init(value: value, unit: unit)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 2
        measurementFormatter.unitOptions = .providedUnit
        return measurementFormatter.string(from: measurement)
    }
    
    fileprivate func setupTemperatureText(label: UILabel, tempValue: Double){
        let measurement = Measurement(value:tempValue, unit: UnitTemperature.celsius)

        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit

        label.text = measurementFormatter.string(from: measurement)
    }
    
    fileprivate func setDesignToTextInLabel(completeText: String, textToEdit: String, label: UILabel){
        let attributedString = NSMutableAttributedString.init(string: completeText, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 13, weight: .regular)])
        let range = NSString.init(string: completeText).range(of: textToEdit)
        attributedString.setAttributes([.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 13, weight: .semibold)], range: range)
        label.attributedText = attributedString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct ForecastDayCollectionViewCellViewModel{
    let id : Int
    let weatherStateAbbr : String
    let windDirectionCompass : String
    let applicableDate : Date
    let minTemp : Int
    let maxTemp : Int
    let temp : Int
    let windSpeed : Double
    let windDirection : Double
    let airPressure : Double
    let humidity : Int
    let visibility : Double
    let predictability : Int
    let created: Date
    let dayDetails: Bool
    
    init(weather: ConsolidatedWeather, dayDetails: Bool = false){
        id = weather.id ?? 0
        weatherStateAbbr = weather.weather_state_abbr ?? ""
        windDirectionCompass = weather.wind_direction_compass ?? ""
        applicableDate = weather.applicable_date ?? Date()
        minTemp = weather.min_temp ?? 0
        maxTemp = weather.max_temp ?? 0
        temp = weather.the_temp ?? 0
        windSpeed = weather.wind_speed ?? 0
        windDirection = weather.wind_direction ?? 0
        airPressure = weather.air_pressure ?? 0
        humidity = weather.humidity ?? 0
        visibility = weather.visibility ?? 0
        predictability = weather.predictability ?? 0
        created = weather.created ?? Date()
        self.dayDetails = dayDetails
    }
}
        
