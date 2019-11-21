import Foundation

//: **if-else**
//: if后面的条件只能是bool类型，省略小括号
let age = 4
if age >= 22 {
    print(">= 22")
}else if age >= 18 {
    print(">= 18")
}else if age >= 7{
    print(">= 7")
}else{
    print("other")
}
//: **while**
var num = 5
while num > 0 {
    print("num is \(num)")
    num -= 1
    //: swift3开始 去掉了++，--
}

num = -1
repeat {
    print("num is \(num)")
} while num > 0

//: **for**

let names = ["小明","小红","小张","小白"]
/// for in
for i in 0 ..< 3 {
    print(names[i])
}

for items in names {
    print(items)
}
/// for in enumerated
for (index, value) in names.enumerated() {
    print("index =", index, "value =", value)
}
print("----------")

/// forEach
names.forEach { (item) in
    print(item)
}

names.forEach {
    print($0)
}

print("===========")

/// stride to (不包含)
for index in stride(from: 1, to: 4, by: 1) {
    print(index)
}
print("**********")

/// stride through (包含)
for index in stride(from: 0, through: 4, by: 2) {
    print(index)
}
print("-------end--------")
//: i默认是let，需要也可以声明为var
for var i in 1...3 {
    i += 5
    print(i)
}/// 6 7 8

//: 半开区间运算符： a ..<b
for i in 1..<5 {
    print(i)
}/// 1 2 3 4
//: 单侧区间，让区间朝一个方向尽可能的远
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}

for name in names[..<2] {
    print(name)
}

//: **switch**
//: case、default 后面不能写大括号{}
//: 默认可以不写break，并不会贯穿到后面的条件

var number = 1
switch number {
case 1:
    print("number is 1")
case 2:
    print("numebr is 2")
default:
    print("number is other")
}

//: fallthrough 可以实现贯穿效果
switch number {
case 1:
    print("number is 1")
    fallthrough
case 2:
    print("number is 2")
default:
    print("number is other")
}
// num is 1
// num is 2

/*
 注意点
 1.switch必须要保证能处理所有情况
 2.case、defaut后面至少要有一条语句
 3.如果不做任何事，加个break即可
 4.如果能保证已处理所有情况，也可以不使用default
 */

//: 复合条件

let string = "Jack"
switch string {
case "Jack", "Rose":
    print("Right person")
default:
    break
} // Right person

let character: Character = "a"
switch character {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
} // The letter A


//: 区间匹配、元组匹配
let count = 62
switch count {
case 0:
    print("none")
case 1..<100:
    print("a few")
case 100..<1000:
    print("handreds of")
default:
    print("many")
}

var point = (1, 1)
switch point {
case (0, 0):
    print("the origin")
case (_, 0):
    print("on the x-axis")
case (0, _):
    print("on the y-axis")
case (-2...2, -2...2):
    print("inside the box")
default:
    print("outside of the box")
}// inside the box

//: 值绑定
point = (2, 0)
switch point {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with y value of \(y)")
case let(x, y):
    print("somewhere else at(\(x), \(y))")
}

//:where
point = (1, -1)
switch point {
case let(x, y) where x == y:
    print("on the line x == y")
case let(x, y) where x == -y:
    print("on the line x == -y")
case let (x, y):
    print("\(x), \(y) is just some arbitrary point")
}

//: 标签语句
outer: for i in 1...4 {
    for k in 1...4 {
        if k == 3 {
            continue outer
        }
        if i == 3 {
            break outer
        }
        print("i == \(i), k == \(k)")
    }
}

//: [函数](@next)
