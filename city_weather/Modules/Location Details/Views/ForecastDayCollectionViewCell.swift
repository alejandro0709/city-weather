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
        view.backgroundColor = .black
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
    
    fileprivate func setupDateView() {
        headerContainer.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor).isActive = true
    }
    
    fileprivate func setupWeatherImage() {
        headerContainer.addSubview(weatherImageView)
        weatherImageView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor).isActive = true
        weatherImageView.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func setupTempeture() {
        contentView.addSubview(tempLabel)
        tempLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor).isActive = true
        tempLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        headerContainer.topAnchor.constraint(equalTo: tempLabel.topAnchor).isActive = true
        headerContainer.bottomAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
    }
    
    fileprivate func setupMinMaxTempetures(textLabel: UILabel, valueLabel: UILabel,
                                         minMaxTemptGuide: UIView, isMin: Bool = true){
        let tempContainer = UIView()
        tempContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tempContainer)
        tempContainer.addSubview(textLabel)
        tempContainer.addSubview(valueLabel)
        tempContainer.topAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
        tempContainer.widthAnchor.constraint(greaterThanOrEqualTo: textLabel.widthAnchor).isActive = true
        tempContainer.widthAnchor.constraint(equalTo: valueLabel.widthAnchor, constant: 11).isActive = true
        
        if isMin{
            tempContainer.trailingAnchor.constraint(equalTo: minMaxTemptGuide.leadingAnchor, constant: -2).isActive = true
        } else{
            tempContainer.leadingAnchor.constraint(equalTo: minMaxTemptGuide.trailingAnchor, constant: 2).isActive = true
        }
        
        tempContainer.bottomAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: tempContainer.topAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor).isActive = true
        
        valueLabel.centerXAnchor.constraint(equalTo: tempContainer.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
    }
    
    fileprivate func setupTempetureMinMax(_ headerBottomLine: UIView) {
        let minMaxTemptGuide = UIView()
        minMaxTemptGuide.backgroundColor = .white
        minMaxTemptGuide.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(minMaxTemptGuide)
        minMaxTemptGuide.centerXAnchor.constraint(equalTo: tempLabel.centerXAnchor).isActive = true
        minMaxTemptGuide.widthAnchor.constraint(equalToConstant: 1).isActive = true
        minMaxTemptGuide.topAnchor.constraint(equalTo: tempLabel.bottomAnchor).isActive = true
        
        setupMinMaxTempetures(textLabel: minTempLabel, valueLabel: minTempValueLabel, minMaxTemptGuide: minMaxTemptGuide)
        setupMinMaxTempetures(textLabel: maxTempLabel, valueLabel: maxTempValueLabel, minMaxTemptGuide: minMaxTemptGuide, isMin: false)
        
        minMaxTemptGuide.bottomAnchor.constraint(equalTo: maxTempValueLabel.bottomAnchor).isActive = true
        headerBottomLine.topAnchor.constraint(equalTo: minMaxTemptGuide.bottomAnchor, constant: 8).isActive = true
    }
    
    fileprivate func setupBottomContainer(_ headerBottomLine: UIView) {
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
        windDirectionLabel.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -2).isActive = true
    }
    
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
        setupTempeture()
        setupTempetureMinMax(headerBottomLine)
        
        setupBottomContainer(headerBottomLine)
    }
    
    func setup(model: ForecastDayCollectionViewCellViewModel){
        let format = DateFormatter()
        format.dateFormat = "d/MM/yyyy"
        dateLabel.text = format.string(from: model.applicableDate)
        
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
        
        setNeedsLayout()
    }
    
    func getValueFormatted(value: Double, unit: Unit) -> String{
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
    
    init(weather: ConsolidatedWeather){
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
    }
}
        
