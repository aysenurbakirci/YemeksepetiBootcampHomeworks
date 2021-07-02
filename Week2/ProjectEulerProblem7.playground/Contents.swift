import UIKit


// Gönderilen sayının asal sayı olup olmadığı kontrol edilir.
func isPrime(number: Int) -> Bool{
    var count = 3
    if number <= 1 {
        return false
    }
    if number == 2 {
        return true
    }
    if number % 2 == 0 {
            return false
    }
    while (count * count) <= number {
        if number % count == 0 {
            return false
        } else {
            count += 2
        }
    }
    return true
}
// Sayılar tek tek kontrol edilir. Her asal sayı bulunduğunda primeNumber değeri bir arttırılır. Bulunan asal sayı sayısı verilen sayıya ulaştığında sonuç yazdırılır.
func problemSeven(primeNumberCount: Int) -> Int{
    var primeNumbers = 1
    var number = 1
    
    while primeNumbers < primeNumberCount {
        
        number = number + 2
        
        if isPrime(number: number) {
            primeNumbers += 1
        }
    }
    return number
}

print("Project Euler Problem 7 Result: \(problemSeven(primeNumberCount: 10001))")
