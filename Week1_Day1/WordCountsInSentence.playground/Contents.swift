import UIKit

func WordCountInSentences(sentence: String) -> [String:Int]{
    let newString = sentence.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "").components(separatedBy: " ")
    let letterList: [String] = newString.sorted()
    var letterCountList: [String: Int] = [:]

    for letter in letterList{
        if letterCountList.isEmpty{
            letterCountList[letter] = 1
        }else{
            let keyCount = (letterCountList[letter] ?? 0) + 1
            letterCountList[letter] = keyCount
        }
    }
    return letterCountList
}

let result = WordCountInSentences(sentence: "merhaba nasılsınız. iyiyim siz nasılsınız. bende iyiyim.")
print(result)
