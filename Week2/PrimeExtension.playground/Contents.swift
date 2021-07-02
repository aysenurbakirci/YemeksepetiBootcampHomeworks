import UIKit

extension Int {
    func isPrimeNumber() -> Bool {
        // aldığımız sayıyı bölecek ilk değer
        var number = 2
        if self < 3{
            return false
        }else{
            //döngü böleceğimiz sayı aldığımız sayının karesine gelene kadar devam eder
            while number <= Int(sqrt(Double(self))) {
                //kalan 0 ise sayı asal değildir
                if self % number == 0{
                    return false
                }
                //aldığımız sayıyı bölen değeri arttırır
                number += 1
            }
            return true
        }
    }
}
13.isPrimeNumber() //true
6.isPrimeNumber() //false
