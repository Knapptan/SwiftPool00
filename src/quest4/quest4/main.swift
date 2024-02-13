//
//  main.swift
//  quest4
//
//  Created by Knapptan on 10.01.2024.
//

import Foundation

//Входные данные
//Celsius
//S
//17
//35

//Выходные данные
//The temperature is 17 ˚C
//The comfortable temperature is from 22 to 25 ˚C.
//Please, make it warmer by 5 degrees.
//The comfortable humidity is from 30% to 60%
//The humidity is comfortable

enum TemperatureScale: String {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

enum Season: String {
    case summer = "S"
    case winter = "W"
}

// Функция для чтения температуры с обработкой ошибок
func readTemperature() -> Int? {
    print("Enter the temperature:")
    guard let input = readLine(), let temperature = Int(input) else {
        print("Incorrect input. Enter a temperature ˚C:")
        return nil
    }
    return temperature
}

// Функция для чтения влажности с обработкой ошибок
func readHumidity() -> Int? {
    print("Enter the humidity:")
    guard let input = readLine(), let humidity = Int(input) else {
        print("Incorrect input. Enter a humidity:")
        return nil
    }
    return humidity
}


// Функция для конвертации температуры из градусов Цельсия
func convertFromCelsius(_ temperature: Int, to scale: TemperatureScale) -> Double {
    switch scale {
    case .celsius:
        return Double(temperature)
    case .fahrenheit:
        return Double(temperature) * 9/5 + 32
    case .kelvin:
        return Double(temperature) + 273.15
    }
}

// Функция для определения комфортной температуры и влажности
func determineComfortableTemperature(season: Season, temperature: Int, humidity: Int, scale: TemperatureScale) {
    var comfortableTemperatureRange: ClosedRange<Int>
    var comfortableHumidityRange: ClosedRange<Int>
    var unit: String
    
    switch season {
    case .summer:
        comfortableTemperatureRange = 22...25
        comfortableHumidityRange = 30...60
    case .winter:
        comfortableTemperatureRange = 20...22
        comfortableHumidityRange = 30...45
    }
    
    switch scale {
    case .celsius:
        unit = "˚C"
    case .fahrenheit:
        unit = "F"
    case .kelvin:
        unit = "K"
    }
    
    print("The temperature is \(convertFromCelsius(temperature, to: scale)) \(unit)")
    print("The humidity is \(humidity)%")
    
    print("The comfortable temperature is from \(convertFromCelsius(comfortableTemperatureRange.lowerBound, to: scale)) to \(convertFromCelsius(comfortableTemperatureRange.upperBound, to: scale)) \(unit).")

    if comfortableTemperatureRange.contains(temperature) && comfortableHumidityRange.contains(humidity) {
        print("The temperature is comfortable.")
    } else {
        let temperatureDifference = comfortableTemperatureRange.lowerBound - temperature
        if temperature < comfortableTemperatureRange.lowerBound {
            print("Please, make it warmer by \(convertFromCelsius(abs(temperatureDifference), to: scale)) degrees.")
        } else if temperature > comfortableTemperatureRange.upperBound {
            print("Please, make it colder by \(convertFromCelsius(abs(temperatureDifference), to: scale)) degrees.")
        } }
    print("The comfortable humidity is from \(comfortableHumidityRange.lowerBound)% to \(comfortableHumidityRange.upperBound)%.")
    if comfortableHumidityRange.contains(humidity) {
        print("The humidity is comfortable.")
    } else {
        let humidityDifference = comfortableHumidityRange.lowerBound - humidity
        if humidity < comfortableHumidityRange.lowerBound {
            print("Please, increase humidity by \(abs(humidityDifference))%.")
        } else if humidity < comfortableHumidityRange.upperBound{
            print("Please, decrease humidity by \(abs(humidityDifference))%.")
        }
    }
}

var temperature: Int?
var humidity: Int?

repeat {
    // Ввод шкалы измерения температуры
    print("Enter the temperature scale ('Celsius', 'Fahrenheit', 'Kelvin'):")
    guard let scaleInput = readLine(), let scale = TemperatureScale(rawValue: scaleInput) else {
        print("Incorrect input. Restart program.")
        continue
    }
    
    // Ввод времени года
    print("Enter the season ('S' for summer, 'W' for winter):")
    guard let seasonInput = readLine(), let season = Season(rawValue: seasonInput) else {
        print("Incorrect input. Restart program.")
        continue
    }
    
    // Ввод текущей температуры
    temperature = readTemperature()
    if temperature == nil {
        continue
    }
    
    // Ввод текущей влажности
    humidity = readHumidity()
    if humidity == nil {
        continue
    }

    // Определение и вывод комфортной температуры и влажности
    determineComfortableTemperature(season: season, temperature: temperature!, humidity: humidity!, scale: scale)
} while temperature == nil || humidity == nil
