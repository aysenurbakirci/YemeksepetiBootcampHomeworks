import UIKit

func CreateFibonacciArray(maxResult: Int) -> [Int]{
    var fibonacciArray = [1,2]
    var result = 0
    while result < maxResult{
        result = fibonacciArray[fibonacciArray.count - 1] + fibonacciArray[fibonacciArray.count - 2]
        fibonacciArray.append(result)
    }
    return fibonacciArray
}

func ProblemTwo() -> Int{
    var sum = 0
    let fibonacciArray = CreateFibonacciArray(maxResult: 3000000)
    for number in fibonacciArray{
        if number % 2 == 0{
            sum += number
        }
    }
    return sum
}

print("Problem 2 Result: \(ProblemTwo())")
