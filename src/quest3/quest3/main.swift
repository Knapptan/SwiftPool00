//
//  main.swift
//  quest3
//
//  Created by Knapptan on 10.01.2024.
//

import Foundation

//Входные данные
//Celsius
//S
//17

//Выходные данные
//The temperature is 17 ˚C
//The comfortable temperature is from 22 to 25 ˚C.
//Please, make it warmer by 5 degrees.

//Входные данные
//Fahrenheit
//S
//22

//Входные данные
//The temperature is 71,6 F
//The comfortable temperature is from 71,6 F to 77 F.
//The temperature is comfortable.

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

// Функция для определения комфортной температуры
func determineComfortableTemperature(season: Season, temperature: Int, scale: TemperatureScale) {
    var comfortableRange: ClosedRange<Int>
    var unit: String

    switch season {
    case .summer:
        comfortableRange = 22...25
    case .winter:
        comfortableRange = 20...22
    }

    let temperatureInCelsius = temperature
//    convertFromCelsius(temperature, to: scale)

    switch scale {
    case .celsius:
        unit = "˚C"
    case .fahrenheit:
        unit = "F"
    case .kelvin:
        unit = "K"
    }

    print("The temperature is \(convertFromCelsius(temperature, to: scale)) \(unit)")
    print("The comfortable temperature is from \(convertFromCelsius(comfortableRange.lowerBound, to: scale)) to \(convertFromCelsius(comfortableRange.upperBound, to: scale)) \(unit).")

    if comfortableRange.contains(Int(temperatureInCelsius)) {
        print("The temperature is comfortable.")
    } else {
        let difference = Int(temperatureInCelsius) - comfortableRange.lowerBound
        if Int(temperatureInCelsius) < comfortableRange.lowerBound {
            print("Please, make it warmer by \(convertFromCelsius(abs(difference), to: scale)) degrees.")
        } else {
            print("Please, make it colder by \(convertFromCelsius(abs(difference), to: scale)) degrees.")
        }
    }
}

var temperature: Int?

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
    // Определение и вывод комфортной температуры
    determineComfortableTemperature(season: season, temperature: temperature!, scale: scale)
} while temperature == nil
