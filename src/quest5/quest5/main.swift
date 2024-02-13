//
//  main.swift
//  quest5
//
//  Created by Knapptan on 11.01.2024.
//

import Foundation

//Входные данные
//0.0
//1.0
//1.0
//2.0
//1.0
//1.0

//Выходные данные
//The circles intersect
//[ [1.0, 1.0] ]

// Функция для чтения вещественных чисел с командной строки с обработкой ошибок
func readDouble() -> Double? {
    guard let input = readLine(), let value = Double(input) else {
        print("Couldn't parse a number. Please, try again")
        return nil
    }
    return value
}

// Функция для определения пересечения окружностей
func circlesIntersect(x1: Double, y1: Double, r1: Double, x2: Double, y2: Double, r2: Double) -> String {
    let distanceBetweenCenters = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
    
    // Проверка на пересечение
    if distanceBetweenCenters <= r1 + r2 {
        // Проверка на вложенность
        if distanceBetweenCenters + min(r1, r2) >= max(r1, r2) {
            return "The circles intersect"
        } else {
            return "One circle is inside another"
        }
    } else {
        return "The circles do not intersect"
    }
}

// Функция для вычисления координат точек пересечения или точки касания
func calculateIntersectionOrTouchPoint(x1: Double, y1: Double, r1: Double, x2: Double, y2: Double, r2: Double) -> [[Double]] {
    let d = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))
    
    // Проверка на касание
    if d == r1 + r2 {
        let touchX = x1 + (r1 * (x2 - x1)) / d
        let touchY = y1 + (r1 * (y2 - y1)) / d
        return [[touchX, touchY]]
    }
    
    // Проверка на пересечение
    let a = (pow(r1, 2) - pow(r2, 2) + pow(d, 2)) / (2 * d)
    let h = sqrt(pow(r1, 2) - pow(a, 2))
    
    let x3 = x1 + a * (x2 - x1) / d
    let y3 = y1 + a * (y2 - y1) / d
    
    let x4_1 = x3 + h * (y2 - y1) / d
    let y4_1 = y3 - h * (x2 - x1) / d
    
    let x4_2 = x3 - h * (y2 - y1) / d
    let y4_2 = y3 + h * (x2 - x1) / d
    
    return [[x4_1, y4_1], [x4_2, y4_2]]
}


// Ввод координат и радиусов первой окружности
print("Enter the x-coordinate of the first circle:")
guard let x1 = readDouble() else { exit(0) }

print("Enter the y-coordinate of the first circle:")
guard let y1 = readDouble() else { exit(0) }

print("Enter the radius of the first circle:")
guard let r1 = readDouble() else { exit(0) }

// Ввод координат и радиусов второй окружности
print("Enter the x-coordinate of the second circle:")
guard let x2 = readDouble() else { exit(0) }

print("Enter the y-coordinate of the second circle:")
guard let y2 = readDouble() else { exit(0) }

print("Enter the radius of the second circle:")
guard let r2 = readDouble() else { exit(0) }

// Вызов функции и вывод результата
let result = circlesIntersect(x1: x1, y1: y1, r1: r1, x2: x2, y2: y2, r2: r2)
print(result)
if result == "The circles intersect"{
    // Вывод координат точек пересечения
    let intersectionPoints = calculateIntersectionOrTouchPoint(x1: x1, y1: y1, r1: r1, x2: x2, y2: y2, r2: r2)
    print(intersectionPoints)
}
