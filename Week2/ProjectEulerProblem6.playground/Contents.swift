import UIKit

//MARK: If let durum gerçekleşirse yapılacakları, guard let ise durum gerçekleşmediği zaman ne yapılacakları gerçekleştirir. Bu durumda bir işlemden önce hata kontrolü yapmak istediğimizde guard let yapısını, bir durumun karşılanıp karşılanmadığı kontrollerini yapmak istediğimizde de  if let yapısını kullanabiliriz

//Verilen sayıya kadar sayıların karelerini alıp result değerine eklenir.
func theSumofSquares(numbers: Int) -> Int{
    var result = 0
    for i in 1...numbers{
        result += i * i
    }
    return result
}

//Verilen sayıya kadar tüm sayılar toplanıp, çıkan sonucun karesi döndürülür.
func theSquareofTheSum(numbers: Int) -> Int{
    var result = 0
    for i in 1...numbers{
        result += i
    }
    return result * result
}

//Bulunan iki sayı arasındaki fark alınır.
func problemSix(numbers: Int) -> Int{
    return theSquareofTheSum(numbers: numbers) - theSumofSquares(numbers: numbers)
}

print("Project Euler Problem 6 Result: \(problemSix(numbers: 100))")
