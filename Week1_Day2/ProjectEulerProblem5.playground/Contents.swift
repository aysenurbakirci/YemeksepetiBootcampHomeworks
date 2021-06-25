import UIKit

func gcd(numberOne: Int, numberTwo: Int) -> Int{
    if numberOne % numberTwo == 0{
        return numberTwo
    }else{
        return gcd(numberOne: numberTwo, numberTwo: (numberOne % numberTwo))
    }
}
func ProblemFive(number: Int) -> Int{
    var result = 1
    for i in 1...number{
        result = (result * i) / gcd(numberOne: result, numberTwo: i)
    }
    return result
}
print("Project Euler Problem 5 Result: \(ProblemFive(number: 20))")
