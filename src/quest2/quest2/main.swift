//
//  main.swift
//  quest2
//
//  Created by Knapptan on 10.01.2024.
//

// Сборник ошибок
enum MyCustomError: Error {
    case invalidInput
    case invalidInputNumber
    case networkError
}

// Функция для чтения целых чисел с командной строки с обработкой ошибок
func readInt() throws -> Int {
    guard let input = readLine(), let value = Int(input) else {
        throw MyCustomError.invalidInputNumber
    }
    return value
}

// Функция для составления чисел в соответствии с порядком рассмотрения
func composeNumbers (number: Int, order: String) throws -> [Int]{
    var minus = 1;
    var numberMod = number;
    if number < 0 {
        numberMod *= -1
        minus *= -1
    }
    
    let numberString = String(numberMod)
    let digits = Array(numberString)
    var composedNumbers: [Int] = []
    
    if order.lowercased() == "lower" {
        // Рассмотрение от низшего порядка к высшему
        var currentNumber = 0
        for digit in digits {
            currentNumber = currentNumber * 10 + Int(String(digit))!
            composedNumbers.append(currentNumber * minus)
        }
    } else if order.lowercased() == "higher" {
        // Рассмотрение от высшего порядка к низшему
        var currentNumber = 0
        for digit in digits.reversed() {
            currentNumber = currentNumber * 10 + Int(String(digit))!
            composedNumbers.insert(currentNumber * minus, at: 0)
        }
        composedNumbers = composedNumbers.reversed()
    } else {
        throw MyCustomError.networkError
    }
    return composedNumbers
}

do {
    // Ввод порядка рассмотрения чисел
    print("Enter the order ('lower' or 'higher'):")
    guard let order = readLine() else {
        throw MyCustomError.invalidInput
    }

    // Ввод числа
    print("Enter the number int:")
    let inputNumber = try readInt()
    
    if order == "lower" || order == "higher" {
        print("Order: \(order), Number: \(inputNumber)")
        let result = try composeNumbers(number:inputNumber, order: order)
        for element in result {
            print(element)
        }
    } else {
        throw MyCustomError.invalidInput
    }
} catch MyCustomError.invalidInput {
    print("Invalid input error use 'lower' or 'higher'")
} catch MyCustomError.invalidInputNumber {
    print("Invalid input number error use int")
} catch {
    print("An unexpected error occurred")
}
