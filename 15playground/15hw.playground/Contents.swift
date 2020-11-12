import UIKit

var str = "Hello, playground"

//3
print("Task 3")
var numsArray = [1, 4, 2, -1, -10, 60]
numsArray.sorted() //получим отсортированную последовательность
print(numsArray)
numsArray.sort() //получим отсортированную последовательность и вернем ее в numsArray
print(numsArray)
print("Task 3 completed")

//4
print("Task 4")
var numsArray2 = [1, 4, 2, -1, -10, 60]
let stringOfNumsArray = numsArray2.map { String($0) }
print(stringOfNumsArray)
print("Task 4 completed")


//5
	
print("Task 5")
let namesArray = ["Alya", "Pavel", "Sanya", "Misha", "Rick"]
var resultNamesString = namesArray.reduce("", { $0 + " " + $1 })
//variant 1 printing without using remove function
print(resultNamesString[resultNamesString.index(after: resultNamesString.startIndex)
    ... resultNamesString.index(before: resultNamesString.endIndex)])
//variant 2 printing after remove function
resultNamesString.remove(at: resultNamesString.startIndex)
print(resultNamesString)
print("Task 5 completed")

//6

func wait2sec(s: String, printing: (String) -> Void) {
    print("Task 6 \nSLEEPING 2 SEC")
    sleep(2)
    printing(s)
}

wait2sec(s: "Task 6 completed") { print($0) }

//7

print("Task 7")

typealias srtingReturn = (String) -> String

func z(str1: String, str2: String, left: srtingReturn, right: srtingReturn) -> (() -> ()) {
    let x = left(str1) + right(str2)
    return { print(x) }
}

z(str1: "Task", str2: "7", left: { $0 + " " }, right: { $0 + " completed" })()

//8

print("Task 8")

typealias m = (_ s1: Int, _ s2: Int) -> Bool

func sorting(a: [Int], _ by: m)	-> [Int] {
    return a.sorted(by: by)
}
		
var a = [1, 5, -134, 7436, -135]
let b = sorting(a: a, <)
print(b)

sorting(a: a) {
    return $0 < $1
}

print("Task 8 completed")
