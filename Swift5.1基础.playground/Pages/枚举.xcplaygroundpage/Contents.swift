import Foundation

//: 枚举的基本用法
enum Direction {
    case north
    case south
    case east
    case west
    
    ///或者是
    /// case north, south, east, west
}

var dir = Direction.west
dir = .north

//: 关联值 将枚举的成员跟其他类型的值关联存储在一起
enum Score {
    case points(Int)
    case grade(Character)
}

var score = Score.points(96)
score = .grade("A")

switch score {
case let .points(i):
    print(i, "points")
case let .grade(i):
    print("grade", i)
}// grade A


//: 原始值
/// 枚举成员可以使用相同类型的默认值预先对应，这个默认值叫做：原始值
enum PockerSuit: Character {
    case spade = "♠️"
    case heart = "♥️"
    case diamond = "♦️"
    case club = "♣️"
}

let suit = PockerSuit.spade
print(suit)
print(suit.rawValue)
print(PockerSuit.club.rawValue)
//原始值不占用内存空间

//如果y枚举的原始值s类型是Int,String,Swift会自动分配原始值
enum Direction1: String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
    //等价于
//    case north, south, east, west
}

print(Direction1.north)
print(Direction1.north.rawValue)

enum Season: Int {
    case spring = 1, summer, autumn = 4, winter
}
print(Season.spring.rawValue)
print(Season.summer.rawValue)
print(Season.autumn.rawValue)
print(Season.winter.rawValue)

//:递归枚举
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}

enum ArithExpr1 {
    case number(Int)
    indirect case sum(ArithExpr1, ArithExpr1)
    indirect case difference(ArithExpr1, ArithExpr1)
}

let five = ArithExpr.number(5)
let four = ArithExpr.number(4)
let two = ArithExpr.number(2)
let sum = ArithExpr.sum(five, four)
let difference = ArithExpr.difference(sum, two)

func calculate(_ expr: ArithExpr) -> Int {
    switch expr {
    case let .number(value):
        return value
    case let .sum(left, right):
        return calculate(left) + calculate(right)
    case let .difference(left, right):
        return calculate(left) - calculate(right)
    }
}
 calculate(difference)

//: [可选项](@next)
