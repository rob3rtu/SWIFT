import UIKit

//let v: [Int] = []
//
////Handle nil valuea (similar to null)
//
////1- if let
//if let variable = v.last {
//    print("The last element is \(variable)")
//} else {
//    print("Got nil")
//}
//
////2- typescript alike <3
//let variable = v.last ?? 45
//
////3- guard statement
//func myFunction() {
//    guard let variable = v.last else { return }
//
//    print(variable)
//    //more code eventualy
//}

//OOP goes brrr


class Developer {
    var name: String?
    var jobTitle: String?
    var yearsExp: Int? //this one is optional
    
    init(name: String, jobTitle: String, yearsExp: Int) {
        self.name       = name
        self.jobTitle   = jobTitle
        self.yearsExp   = yearsExp
    }
    
    func speakName() {
        print(name!)
    }
}

class IOSDeveloper: Developer {
    var favouriteFramework: String?
    
    func speakFavouriteFramework() {
        if let fav = favouriteFramework {
            print(fav)
        } else {
            print("I dont have a favourite framework...")
        }
    }
    
    override func speakName() {
        print("\(name!) - \(jobTitle!)")
    }
}

//clasele sunt memorate prin referinta
var robert = IOSDeveloper(name: "Robert", jobTitle: "IOS DEV", yearsExp: 5)
var alex = robert

alex.name = "Alex"
robert.name


//struct e ca o clasa, nu mai scriu, doar ca sunt transmise prin VALOARE
//pe ex de mai sus, robert.name ar fi fost tot robert


extension String {
    func removeWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

var letters = "A B C D"
//print(letters.removeWhiteSpaces())


//FIZZBUZZ Problem

for i in 1...100 {
    if i % 3 + i % 5 == 0 {
        print("FIZZBUZZ!")
    } else if i % 3 == 0 {
        print("FIZZ")
    } else if i % 5 == 0 {
        print("BUZZ")
    } else {
        print(i)
    }
}
