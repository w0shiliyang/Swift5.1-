import Foundation
//: 泛型（Generics）

/// 泛型可以将类型参数化，提高代码复用率，减少代码量
func swapValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}
var i1 = 10
var i2 = 20
swapValues(&i1, &i2)

var d1 = 10.0
var d2 = 20.0
swapValues(&d1, &d2)

struct Date {
    var year = 0, month = 0, day = 0
}
var dd1 = Date(year: 2011, month: 9, day: 10)
var dd2 = Date(year: 2012, month: 10, day: 11)
swapValues(&dd1, &dd2)

/// 泛型函数赋值给变量
func test<T1, T2>(_ t1: T1, _ t2: T2) {}
var fn: (Int, Double) -> () = test

class Statck<E> {
    var elements = [E]()
    func push(_ element: E) { elements.append(element)}
    func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int { elements.count }
}

class SubStack<E> : Statck<E> {}

struct Stack<E> {
    var elements = [E]()
    mutating func push(_ element: E) {elements.append(element) }
    mutating func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int {elements.count}
}

enum Score<T> {
    case point(T)
    case grade(String)
}
let score0 = Score<Int>.point(100)
let score1 = Score.point(99)
let score2 = Score.point(99.5)
let score3 = Score<Int>.grade("A")

//: 关联类型（Associated Type）
/// 关联类型的作用： 给协议中用到的类型定义一个占位名称
/// 协议中可以拥有多个关联类型

protocol Stackable {
    associatedtype Element //关联类型
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

class Statck1<E> : Stackable {
    // typealias Element = E
    var elements = [E]()
    func push(_ element: E) { elements.append(element)}
    func pop() -> E { elements.removeLast() }
    func top() -> E { elements.last! }
    func size() -> Int { elements.count }
}

class StringStack : Stackable {
    // 给关联类型设定真实类型
    // typealias Element = String
    var elements = [String]()
    func push(_ element: String) { elements.append(element)}
    func pop() -> String { elements.removeLast() }
    func top() -> String { elements.last! }
    func size() -> Int { elements.count }
}
var ss = StringStack()
ss.push("Jack")

//: 类型约束
protocol Runnable { }
class Person { }
func swapValues1<T : Person & Runnable>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}
protocol Stackable1 {
    associatedtype Element: Equatable
}
class Stack1<E : Equatable> : Stackable1 { typealias Element = E }

func equal<S1: Stackable1, S2: Stackable1>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element : Hashable {
    return false
}
var stack1 = Stack1<Int>()
var stack2 = Stack1<String>()
// error: requires the types 'Int' and 'String' be equivalent
//equal(stack1, stack2)

//: 协议类型的注意点
protocol Runnable1 {}
class Person1 : Runnable1 {}
class Car1 : Runnable1 {}

func get(_ type: Int) -> Runnable1 {
    if type == 0 {
        return Person1()
    }
    return Car1()
}
var r1 = get(0)
var r2 = get(0)

/// 如果协议中有associatedtype
protocol Runnable2 {
    associatedtype Speed
    var speed: Speed { get }
}

class Person2 : Runnable2 {
    var speed: Double { 0.0 }
}
class Car2 : Runnable2 {
    var speed: Int { 0 }
}

/// 下面写法会报错么？

//func get2(_ type: Int) -> Runnable2 {
//    if type == 0 {
//        return Person2()
//    }
//    return Car2()
//}
//var testR1 = get2(0)
//var testR2 = get2(0)
//: 泛型解决
/// 解决方案1: 使用泛型
func get<T: Runnable2>(_ type: Int) -> T {
    if type == 0 {
        return Person2() as! T
    }
    return Car2() as! T
}
var rr1: Person2 = get(0)
var rr2: Car2 = get(1)

//: 不透明类型（Opaque Type）
/// 解决方案2: 使用some关键字声明一个不透明类型
func getCar(_ type: Int) -> some Runnable2  { Car2() }
var rrr1 = getCar(0)
var rrr2 = getCar(1)

/// some限制只能返回一种类型
//func getRunValue(_ type: Int) -> some Runnable2 {
//    if type == 0 {
//        return Person2()
//    }
//    return Car2()
//}

//: some
/// some除了用在返回值类型上，一般还可以用在属性类型上
protocol Runnable3 { associatedtype Speed }
class Dog : Runnable3 { typealias Speed = Double }
class People {
    var pet: some Runnable3 {
        return Dog()
    }
}

//: 可选项的本质
/// 可选项的本质是enum类型
//public enum Optional<Wrapped> : ExpressibleByNilLiteral {
//    case none
//    case some(Wrapped)
//    public init(_ some: Wrapped)
//}

var age: Int? = 10
var age0: Optional<Int> = Optional<Int>.some(10)
var age1: Optional = .some(10)
var age2 = Optional.some(10)
var age3 = Optional(10)
age = nil
age3 = .none

/// nil
var age4: Int? = nil
var age5 = Optional<Int>.none
var age6: Optional<Int> = .none

var age7: Int? = .none
age7 = 10
age7 = .some(20)
age7 = nil

switch age {
case let v?:
    print("some", v)
case nil:
    print("none")
}

switch age {
case let .some(v):
    print("some", v)
case .none:
    print("none")
}

var age_: Int? = 10
var ageValue: Int?? = age_
ageValue = nil

var ageValue1 = Optional.some(Optional.some(10))
ageValue1 = .none
var ageValue2: Optional<Optional> = .some(.some(10))
ageValue2 = .none

var ageValue3: Int?? = 10
var ageValue4: Optional<Optional> = 10

//: [高级运算符](@next)
