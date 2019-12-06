import UIKit
//: 函数的定义
func sum(v1: Int, v2: Int) -> Int {
    return v1 + v2
}
sum(v1: 10, v2: 20)

/// 无返回值
func sayHello1() -> Void {}
func sayHello2() -> () {}
func sayHello3() {}

//: 隐式返回 如果函数体是个单一表达式，则可以省略return
func add(v1: Int, v2: Int) -> Int {
    v1 + v2
}
add(v1: 10, v2: 20)

//: 返回元组，实现多返回值
func calculate(v1: Int, v2: Int) -> (sum: Int, difference: Int, average: Int) {
    let sum = v1 + v2
    return (sum, v1-v2, sum>>1)
}
let result = calculate(v1: 20, v2: 10)
result.sum
result.difference
result.average

//: 参数标签
func goToWork(at time: String) {
    print("this time is \(time)")
}
goToWork(at: "08:00")
/// 可以使用下划线 _ 省略标签
func sumTwoValue(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2
}
sumTwoValue(10, 20)

//: 默认参数值
func check(name: String = "nobody", age: Int, job: String = "none") {
    print("name \(name), age = \(age), job = \(job)")
}
check(name: "Jack", age: 20, job: "Doctor")
check(name: "Rose", age: 18)
check(age: 10, job: "Batman")
check(age: 15)

//: 可变参数
func sum(_ numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}
sum(10, 20, 30, 40) // 100
// 一个函数最多只能有1个可变参数
// 紧跟在可变参数后面的参数不能省略参数标签
func test(_ numbers: Int..., string: String, _ other: String) {}
test(10, 20, 30, string: "Jack", "Rose")

//: 输入输出参数
//可以用inout定义一个输入输出参数：可以在函数内部修改外部实参的值
func swapValues(_ v1: inout Int, _ v2: inout Int) {
//    let tmp = v1
//    v1 = v2
//    v2 = tmp
    (v1, v2) = (v2, v1)
}
var num1 = 10
var num2 = 20
swapValues(&num1, &num2)

/*
 1.不可变参数不能标记为inout
 2.inout参数不能有默认值
 3.inout参数只能穿入可以被多次赋值的
 */
//: 函数重载
/*
 规则：
 函数名相同
 参数个数不同 || 参数类型不同 || 参数标签不同
 */

func testSum(v1: Int, v2: Int) -> Int {
    v1 + v2
}
func testSum(v1: Int, v2: Int, v3: Int) -> Int {
    v1 + v2 + v3
}/// 参数个数不同
func testSum(v1: Int, v2: Double) -> Double {
    Double(v1) + v2
}/// 参数类型不同
func testSum(_ v1: Int, _ v2: Int) -> Int {
    v1 + v2 + 1
}/// 参数标签不同

print(testSum(v1: 10, v2: 20))
print(testSum(v1: 10, v2: 20, v3: 30))
print(testSum(v1: 10, v2: 20.0))
print(testSum(10, 20))

//:重载注意点
/// 1、返回值类型与函数重载无关
func testSum1(v1: Int, v2: Int) -> Int { v1 + v2 }
func testSum1(v1: Int, v2: Int) {}
//testSum1(v1: 10, v2: 20)

/// 2、默认参数值和函数重载一起使用禅僧呢二义性时，编译器不会报错
func testSum2(v1: Int, v2: Int) -> Int { v1 + v2 }
func testSum2(v1: Int, v2: Int, v3: Int = 10) -> Int { v1 + v2 + v3 }
/// 会调用上面的
testSum2(v1: 10, v2: 20)

/// 3、可变参数、省略参数标签，函数重载一起使用产生二义性时，编译器有可能会报错
func testSum3(_ v1: Int, _ v2: Int) -> Int {
    print("+")
    return v1 + v2
}
func testSum3(_ numbers: Int...) -> Int {
    print("numbers")
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

//testSum3(1,2,3,4)
//testSum3(1, 2)

//:函数类型
//每个函数都有类型的，由形式参数类型、返回值类型组成
//返回值是函数类型的函数，叫做高阶函数

func next(_ input: Int) -> Int { input + 1}
func previous(_ input: Int) -> Int { input - 1 }
func forward(_ forward: Bool) -> (Int) -> Int {
    forward ? next : previous
}
forward(true)(3)
forward(false)(3)

//:typealias 给类型起别名
typealias IntFn = (Int, Int) -> Int

func difference(v1: Int, v2: Int) -> Int { v1 - v2 }
let fn: IntFn = difference
fn(20, 10)

//: 嵌套函数 将函数定义在函数内部
func forward1(_ result: Bool) -> (Int) -> Int {
    func next(_ input: Int) -> Int {
        input + 1
    }
    func previous(_ input: Int) -> Int {
        input - 1
    }
    return result ? next : previous
}

forward1(true)(3)
forward1(false)(3)

//: [枚举](@next)
