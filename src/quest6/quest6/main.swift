//
//  main.swift
//  quest6
//
//  Created by Knapptan on 11.01.2024.
//

import Foundation

//The program is running. Enter a number or type "exit" to stop:
//yes
//Incorrect format, try again
//
//Enter a number:
//34
//thirty-four
//
//Enter a number:
//exit
//
//Bye!


// Функция для преобразования числа в слова
func numberToWords(_ number: Int) -> String {
    let units = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
    let teens = ["", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    let tens = ["", "ten", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]
    let thousands = ["", "thousand", "million"]
    
    var result = ""
    var num = abs(number)
    
    if num == 0 {
        return "zero"
    }
    
    var i = 0
    
    while num > 0 {
        let chunk = num % 1000
        if chunk != 0 {
            let chunkResult = convertChunk(chunk, units, teens, tens)
            if !result.isEmpty {
                result = chunkResult + "-" + thousands[i] + "-" + result
            } else if abs(number) >= 1000 {
                result = chunkResult + "-" + thousands[i]
            } else {
                result = chunkResult + thousands[i]
            }
        }
        
        num /= 1000
        i += 1
    }
    
    if number < 0 {
        result = "minus-" + result
    }
    
    return result.trimmingCharacters(in: .whitespaces)
}

// Вспомогательная функция для преобразования трехзначного блока чисел
func convertChunk(_ num: Int, _ units: [String], _ teens: [String], _ tens: [String]) -> String {
    var result = ""
    
    let hundredsDigit = num / 100
    let remainder = num % 100
    
    if hundredsDigit > 0 {
        result += units[hundredsDigit] + "-hundred"
    }
    
    if remainder > 0 {
        if hundredsDigit > 0 {
            result += "-and-"
        }
        
        if remainder <= 10 {
            result += units[remainder]
        } else if remainder < 20 {
            result += teens[remainder - 10]
        } else {
            let tensDigit = remainder / 10
            let unitsDigit = remainder % 10
            
            result += tens[tensDigit]
            
            if unitsDigit > 0 {
                result += "-" + units[unitsDigit]
            }
        }
    }
    
    return result
}


    print("The program is running. Enter a number or type \"exit\" to stop:")
    
    var count = 0
    
    repeat {
        var input: String?
        
        if count % 5 == 0 {
            print("Enter a number or type \"exit\" to stop:")
        } else {
            print("Enter a number:")
        }
        
        guard let userInput = readLine() else {
            print("Incorrect format, try again.")
            continue
        }
        
        input = userInput.lowercased()
        
        if input == "exit" {
            print("\nBye!")
            break
        }
        
        if let number = Int(input!) {
            if number >= -1_000_000 && number <= 1_000_000 {
                let words = numberToWords(number)
                print(words)
            } else {
                print("The number is out of bounds, try again.")
            }
        } else {
            print("Incorrect format, try again.")
        }
        
        count += 1
    } while true
