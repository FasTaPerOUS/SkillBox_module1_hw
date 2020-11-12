import UIKit

var str = "Hello, playground"

//3
var numsArray = [1, 4, 2, -1, -10, 60]
numsArray.sorted() //получим отсортированную последовательность
print(numsArray)
numsArray.sort() //получим отсортированную последовательность и вернем ее в numsArray
print(numsArray)

//4
var numsArray2 = [1, 4, 2, -1, -10, 60]
let stringOfNumsArray = numsArray2.map { String($0) }
print(stringOfNumsArray)


//5
let namesArray = ["Alya", "Pavel", "Sanya", "Misha", "Rick"]
var resultNamesString = namesArray.reduce("", { $0 + " " + $1 })
resultNamesString.remove(at: resultNamesString.startIndex)
print(resultNamesString)

//6

func wait2sec(s: String, printing: (String) -> Void) {
    print("Task 6 \nSLEEPING 2 SEC")
    sleep(2)
    printing(s)
}

wait2sec(s: "Task 6 completed", printing: { s in print(s) })

//7
typealias srtingReturn = (String) -> String

func z(str1: String, str2: String, left: srtingReturn, right: srtingReturn) -> (() -> ()) {
    let x = left(str1) + right(str2)
    return { print(x) }
}


z(str1: "Task", str2: "7", left: { a in return a + " " }, right: {b in return b + "."}


//8

typealias m = (_ s1: Int, _ s2: Int) throws -> Bool

func sorting(a: [Int], _ by: m) throws 	-> [Int] {
    return try a.sorted(by: by)
}
		
var a = [1, 5, -134, 7436, -135]
let b = try? sorting(a: a, <)
print(a)

try? sorting(a: a) {
    return $0 < $1
}
