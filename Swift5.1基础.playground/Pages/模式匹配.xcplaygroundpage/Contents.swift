import Foundation
//: 模式（Pattern）
/// 什么是模式?
/// 模式是用于匹配的规则，比如switch的case、捕捉错误的catch、if\guard\while\for语句的条件等
/// Swift中的模式有
/// 通配符模式(Wildcard Pattern)
/// 标识符模式(Identifier Pattern)
/// 值绑定模式(Value-Binding Pattern)
/// 元组模式(Tuple Pattern)
/// 枚举Case模式(Enumeration Case Pattern)
/// 可选模式(Optional Pattern)
/// 类型转换模式(Type-Casting Pattern)
/// 表达式模式(Expression Pattern)
//: 通配符模式(Wildcard Pattern)
/// _ 匹配任何值
/// _? 匹配非nil值
enum Life {
    case human(name: String, age: Int?)
    case animal(name: String, age: Int?)
}
func check(_ life: Life) {
    switch life {
    case .human(let name, _):
        print("human", name)
    case .animal(let name, _?):
        print("animal", name)
    default:
        print("other")
    }
}
check(.human(name: "Rose", age: 20)) // human Rose
check(.human(name: "Jack", age: nil)) // human Jack
check(.animal(name: "Dog", age: 5)) // animal Dog
check(.animal(name: "Cat", age: nil)) // other

//: 标识符模式(Identifier Pattern)
/// 给对应的变量、常量名赋值
var age = 10
let name = "jack"

//: 值绑定模式(Value-Binding Pattern)
let point = (3, 2)
switch point {
    case let (x, y):
        print("The point is at (\(x), \(y)).")
}
//:  元组模式(Tuple Pattern)
let points = [(0, 0), (1, 0), (2, 0)]
for (x, _) in points {
    print(x)
}

let name1: String? = "jack"
let age1 = 18
let info: Any = [1, 2]
switch (name1, age1, info) {
    case (_?, _ , _ as String):
        print("case")
    default:
        print("default")
} // default
var scores = ["jack" : 98, "rose" : 100, "kate" : 86]
for (name, score) in scores {
    print(name, score)
}
//:  枚举Case模式(Enumeration Case Pattern)
/// if case语句等价于只有1个case的switch语句
let age2 = 2
// 原来的写法
if age2 >= 0 && age <= 9 {
    print("[0, 9]")
}
// 枚举Case模式
if case 0...9 = age2 {
    print("[0, 9]")
}
func testA() {
    guard case 0...9 = age2 else {
        return
    }
}
testA()
print("[0, 9]")
switch age2 {
    case 0...9: print("[0, 9]")
    default: break
}

let ages: [Int?] = [2, 3, nil, 5]
for case nil in ages {
    print("有nil值")
    break
} // 有nil值

let points1 = [(1, 0), (2, 1), (3, 0)]
for case let (x, 0) in points1 {
    print(x)
} // 1 3
//:  可选模式(Optional Pattern)
let age3: Int? = 42
if case .some(let x) = age3 {
    print(x)
}
if case let x? = age3 { print(x) }
func check(_ num: Int?) {
    switch num {
        case 2?: print("2")
        case 4?: print("4")
        case 6?: print("6")
        case _?: print("other")
        case _: print("nil")
    }
}
check(4) // 4
check(8) // other
check(nil) // nil

let ages2: [Int?] = [nil, 2, 3, nil, 5]
for case let age? in ages2 {
    print(age)
} // 2 3 5

let ages3: [Int?] = [nil, 2, 3, nil, 5]
for item in ages3 {
    if let age = item {
        print(age)
}
} // 跟上面的for，效果是等价的
//:  类型转换模式(Type-Casting Pattern)
let num: Any = 6
switch num {
    case is Int:
    // 编译器依然认为num是Any类型
    print("is Int", num)
//case let n as Int:
//    print("as Int", n + 1)
    default:
    break
}

class Animal { func eat() { print(type(of: self), "eat") } }
class Dog : Animal {
    func run() {
        print(type(of: self), "run")

    }
}
class Cat : Animal {
    func jump() {
        print(type(of: self), "jump")
    }
}
func check(_ animal: Animal) {
    switch animal {
        case let dog as Dog:
            dog.eat()
            dog.run()
        case is Cat:
            animal.eat()
        default:
        break
    }
}
// Dog eat
// Dog run
check(Dog())
// Cat eat
check(Cat())


//:  表达式模式(Expression Pattern)
/// 表达式模式用在case中
let point2 = (1, 2)
switch point2 {
case (0, 0):
    print("(0, 0) is at the origin.")
case (-2...2, -2...2):
    print("(\(point2.0), \(point2.1)) is near the origin.")
default:
    print("The point is at (\(point2.0), \(point2.1)).")
} // (1, 2) is near the origin.
//:  自定义表达式模式
/// 可以通过重载运算符，自定义表达式模式的匹配规则
struct Student {
    var score = 0, name = ""
    static func ~= (pattern: Int, value: Student) -> Bool {
        value.score >= pattern
    }
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
    static func ~= (pattern: Range<Int>, value: Student) -> Bool {
        pattern.contains(value.score)
    }
}
var stu = Student(score: 75, name: "Jack")
switch stu {
    case 100: print(">= 100")
    case 90: print(">= 90")
    case 80..<90: print("[80, 90)")
    case 60...79: print("[60, 79]")
    case 0: print(">= 0")
    default: break
} // [60, 79]

if case 60 = stu {
    print(">= 60")
} // >= 60

var info1 = (Student(score: 70, name: "Jack"), "及格")
switch info1 {
    case let (60, text):
        print(text)
    default: break
} // 及格

extension String {
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}
func hasPrefix(_ prefix: String) -> ((String) -> Bool) { { $0.hasPrefix(prefix) } }
func hasSuffix(_ suffix: String) -> ((String) -> Bool) { { $0.hasSuffix(suffix) } }
var str = "jack"
switch str {
    case hasPrefix("j"), hasSuffix("k"):
        print("以j开头，或以k结尾")
    default: break
} // 以j开头，以k结尾

func isEven(_ i: Int) -> Bool {
    i % 2 == 0
}
func isOdd(_ i: Int) -> Bool {
    i % 2 != 0
}
extension Int {
static func ~= (pattern: (Int) -> Bool, value: Int) -> Bool {
        pattern(value)
    }
}

var age6 = 9
switch age6 {
    case isEven:
        print("偶数")
    case isOdd:
        print("奇数")
    default:
        print("其他")
}
prefix operator ~>
prefix operator ~>=
prefix operator ~<
prefix operator ~<=
prefix func ~> (_ i: Int) -> ((Int) -> Bool) {
    { $0 > i }
}
prefix func ~>= (_ i: Int) -> ((Int) -> Bool) {
    { $0 >= i }
}
prefix func ~< (_ i: Int) -> ((Int) -> Bool) {
    { $0 < i }
}
prefix func ~<= (_ i: Int) -> ((Int) -> Bool) {
    { $0 <= i }
}

var age7 = 9
switch age7 {
    case ~>=0:
        print("1")
    case ~>10:
        print("2")
    default: break
} // [0, 10]
//: where
///可以使用where为模式匹配增加匹配条件
var data = (10, "Jack")
switch data {
    case let (age, _) where age > 10:
        print(data.1, "age>10")
    case let (age, _) where age > 0:
            print(data.1, "age>0")
    default: break
}
protocol Stackable {
    associatedtype Element
}
protocol Container {
    associatedtype Stack : Stackable where Stack.Element : Equatable
}
var ages4 = [10, 20, 44, 23, 55]
for age in ages4 where age > 30 {
    print(age)
} // 44 55

func equal<S1: Stackable, S2: Stackable>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element : Hashable {
    return false
}
extension Container where Self.Stack.Element : Hashable { }
