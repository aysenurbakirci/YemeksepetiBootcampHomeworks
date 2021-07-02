import UIKit

func sumNumber<T: Numeric, U: StringProtocol>(numberOne: T, numberTwo: T, selectedAction: U) -> T? {
    
    if selectedAction == "Çarpma"{
        return numberOne * numberTwo
    }else if selectedAction == "Toplama"{
        return numberOne + numberTwo
    }else if selectedAction == "Çıkarma"{
        return numberOne - numberTwo
    }else{
        return nil
    }
}

sumNumber(numberOne: 5, numberTwo: 7, selectedAction: "Çıkarma")
