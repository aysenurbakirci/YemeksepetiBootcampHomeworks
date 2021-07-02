import UIKit

func ProblemThree(number: Int) -> [Int] {
    if number < 4 {
        return [number]
    }
    let numberSqrt = Int(sqrt(Double(number)))
    for factor in 2...numberSqrt {
        if number % factor == 0 {
            var result = [factor]
            result.append(contentsOf: ProblemThree(number: number / factor))
            return result
        }
    }
    return [number]
}

func GetMax(list: [Int]) -> Int{
    return list.max() ?? 0
}
print("Problem 3 Result: \(String(describing: ProblemThree(number: 600851475143).max() ?? 0))")
