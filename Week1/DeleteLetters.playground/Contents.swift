
import UIKit

let selectedcount = 2
var string = "aaba kouq bux"
let letters = ["a", "b", "c", "d", "e", "f", "g", "ğ", "h", "ı", "i", "j", "k", "l", "m", "n", "o", "ö", "p", "r", "s", "ş", "t", "u", "ü", "v", "y", "z", "w", "q"]
var selectedLetters: [String: Int] = [:]
var letterCount = 0

for letter in letters{
    letterCount = 0
    for str in string{
        if letter == String(str){
            letterCount += 1
        }
        selectedLetters[letter] = letterCount
    }
}
for (lett, co) in selectedLetters {
    if co >= selectedcount{
        string = string.replacingOccurrences(of: lett, with: "")
    }
}
print(string)
