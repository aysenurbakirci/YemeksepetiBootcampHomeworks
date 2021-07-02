import UIKit

func Palidrome(number: Int) -> Int{
    var number = number
    var sayi = ""
    var basamak: [Int] = []
    while number > 0 {
        basamak.append(number % 10)
        number = number / 10
    }
    for i in basamak{
        sayi += String(i)
    }
    return Int(sayi) ?? 0
}
func ProblemFour() -> Int{
    for numberOne in stride(from: 999, to: 100, by: -1){
        for numberTwo in stride(from: 999, to: 100, by: -1){
            let result = numberOne * numberTwo
            if Palidrome(number: result) == result{
                return result
            }
        }
    }
    return 0
}

print("Problem 5 Result: \(ProblemFour())")
