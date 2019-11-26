import Foundation
//: 结构体
///所有的结构体都有一个编译器自动生成的初始化器，编译器会根据情况，会为结构体生成多个初始化器，宗旨是：保证所有的成员都有初始值
struct Point {
    var x: Int = 1
    var y: Int = 2
    
//    var x: Int?
//    var y: Int?
}
var p1 = Point(x: 10, y: 10)
var p2 = Point(x: 10)
var p3 = Point(y: 10)
var p4 = Point()
//:自定义初始化器
///一旦在定义结构体时自定义了初始化器，编译器就不会再帮它自动生成其他初始化器
struct TestPoint {
    var x: Int = 0
    var y: Int = 0
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var testP1 = TestPoint(x: 10, y: 10)
//var p2 = TestPoint(y: 10)
//var p3 = TestPoint(x: 10)
//var p4 = TestPoint()

//: 结构体内部结构
print(MemoryLayout<TestPoint>.size)
print(MemoryLayout<TestPoint>.stride)
print(MemoryLayout<TestPoint>.alignment)

//:类
///类的定义和结构体类似，但编译器并没有为类自动生成可以传入成员的初始化器
class PointClass {
    var x: Int = 0
    var y: Int = 0
}

//let pc1 = PointClass()
//let pc1 = PointClass(x: 10, y: 20)
//let pc1 = PointClass(x: 10)
//let pc1 = PointClass(y: 20)
//:类的初始化器
///如果类的所有成员都在定义的时候指定了初始值，编译器会为类生成无参的初始化器
///成员的初始化是在这个初始化器中完成的

//:结构体与类的本质区别
/// 结构体是值类型（枚举也是值类型），类是引用类型（指针类型）

//:值类型
/// 值类型赋值给var、let或者给函数传参，是直接将所有的内容拷贝一份
/// 类似于对文件进行copy、paste操作，产生了全新的文件副本，属于深拷贝(deep copy)
var s1 = "Jack"
var s2 = s1
print(String(format: "%p", s1))
print(String(format: "%p", s2))
s2.append("_Rose")
print(s1)
print(s2)
print(String(format: "%p", s1))
print(String(format: "%p", s2))

//:在Swift标准库中，为了提升性能，String，Array，Dictionary，Set采取了Copy On Write的技术
/// 比如仅当有"写"操作时，才会真正进行拷贝操作
/// 对于标准库值类型的赋值操作，Swift能够确保最佳性能，所以没必要为了保证最佳性能来避免赋值
/// 建议：不需要修改的，尽量定义为let

//: 引用类型
/// 引用赋值给var、let或者给函数传参，是将内存地址拷贝一份
/// 类似于制作一个文件的替身（快捷方式、链接），指向的是同一个文件。属于浅拷贝（shallow copy）
class Size {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

func test() {
    let s1 = Size(width: 10, height: 20)
    let s2 = s1
    s2.width = 11
    s2.height = 22
    /// 请问s1.width和s1的height是多少？
}

//: 值类型、引用类型的let
struct TestPoint1 {
    var x: Int
    var y: Int
}

class TestSize1 {
    var width: Int
    var height: Int
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

//let tp1 = TestPoint1(x: 10, y: 20)
//tp1 = Point(x: 11, y: 22)
//tp1.x = 33
//tp2.y = 44

//let ts1 = TestSize1(width: 10, height: 20)
//ts1 = TestSize1(width: 11, height: 22)
//ts1.width = 33
//ts1.height = 44

//:嵌套类型
struct Poker {
    enum Suit: Int {
        case spades, hearts, diamonds, clubs
    }
}
print(Poker.Suit.hearts.rawValue)

//: 枚举、结构体、类都可以定义方法
/// 一般把定义在枚举、结构体、类内部的函数，叫做方法
/// 方法不占用对象的内存空间
/// 方法的本质就是函数
/// 方法、函数都存放在代码段

//: [闭包](@next)
