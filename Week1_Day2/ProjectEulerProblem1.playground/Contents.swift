import UIKit

func ProblemOne(firstMultiple: Int, secondMultiple: Int, lastNumber: Int) -> Int{
    var sum = 0
    for number in 0...lastNumber{
        if number % 3 == 0 || number % 5 == 0{
            sum += number
        }
    }
    return sum
}

print("Problem 1 Result: \(ProblemOne(firstMultiple: 3, secondMultiple: 5, lastNumber: 999))")
