import Foundation

//:闭包表达式
/// 在Swift中，可以通过func定义一个函数，也可以通过闭包表达式定义一个函数
func sum(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
var testFn = { (v1: Int, v2: Int) -> Int in
    return v1 + v2
}
testFn(1,2)

_ = {
    (v1: Int, v2: Int) -> Int in
    return v1 + v2
}(10, 20)

/*
 {
    (参数列表) -> 返回值类型 in
    函数体代码
 }
 */

//:闭包表达式的简写
func exec(v1: Int, v2: Int, fn:(Int, Int) -> Int) {
    print(fn(v1, v2))
}

exec(v1: 10, v2: 20, fn: {
    (v1: Int, v2: Int) in return v1 + v2
})

exec(v1: 10, v2: 20, fn: {
    v1, v2 in return v1 + v2
})

exec(v1: 10, v2: 20, fn:{
    v1, v2 in v1 + v2
})

exec(v1: 10, v2: 20, fn: {$0 + $1})
exec(v1: 10, v2: 20, fn: +)

//: 尾随闭包
/// 如果将一个很长的闭包表达式作为函数的最后一个实参，使用尾随闭包可以增强函数的可读性
/// 尾随闭包是一个被书写在函数调用括号外面（后面）的闭包表达式
exec(v1: 10, v2: 20) {
    $0 + $1
}
///如果闭包表达式是函数的唯一实参，而且使用了尾随闭包的语法，那就不需要在函数名后面写小括号
func exec(fn: (Int, Int) -> Int) {
    print(fn(1, 2))
}
exec(fn: { $0 + $1})
exec() {$0 + $1}
exec {$0 + $1}

//: 示例 - 数组的排序
/// func sort(by areInIncreasingOrder: (Element, Element) -> Bool)

func cmp(i1: Int, i2: Int) -> Bool {
    return i1 > i2
}
var nums = [11, 2, 18, 6, 5, 68, 45]
nums.sort(by: cmp)

nums.sort(by: {
    (i1: Int, i2: Int) -> Bool in
    return i1 < i2
})
nums.sort(by: { i1, i2 in return i1 < i2 })
nums.sort(by: { i1, i2 in i1 < i2 })
nums.sort(by: { $0 < $1 })
nums.sort(by: <)
nums.sort() { $0 < $1 }
nums.sort { $0 < $1}

//: 闭包
/// 网上有各种关于闭包的定义，个人感觉比较严谨的定义是
/// 一个函数和它所捕获的变量、常量环境组合起来，称为闭包
/// 一般指定义在函数内部的函数
/// 一般它捕获的是外部函数的局部变量、常量

typealias Fn = (Int) -> Int

//func getFn() -> Fn {
//    var num = 0
//    func plus(_ i: Int) -> Int {
//        num += i
//        return num
//    }
//    return plus
//}/// 返回的plus和num形成了闭包

func getFn() -> Fn {
    var num = 0
    return {
        num += $0
        return num
    }
}

var fn1 = getFn()
var fn2 = getFn()
fn1(1)
fn2(2)
fn1(3)
fn2(4)
fn1(5)
fn2(6)

/// 思考： 如果num是全局变量呢？

/// 可以把闭包想象成一个类的实例对象
/// 内存在堆空间
/// 捕获的局部变量、常量就是对象的成员（存储属性）
/// 组成闭包的函数就是类内部定义的方法

class Closure {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
}
var cs1 = Closure()
var cs2 = Closure()
cs1.plus(1)
cs2.plus(2)
cs1.plus(3)
cs2.plus(4)
cs1.plus(5)
cs2.plus(6)

//: 自动闭包
func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
    return v1 > 0 ? v1 : v2
}

_ = getFirstPositive(10, 20)
_ = getFirstPositive(-2, 20)
_ = getFirstPositive(0, -4)

/// 改成函数类型的参数，可以让v2延迟加载
func getFirstPositive(_ v1: Int, v2: () -> Int) -> Int? {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive(-4) { 20 }

func getFirstPositive(_ v1: Int, v2: @autoclosure () -> Int) -> Int? {
    return v1 > 0 ? v1 : v2()
}
getFirstPositive(-4) { 20 }

/// @autoclosure 会自动将20 封装成闭包{ 20 }
/// @autoclosure 只支持 （）-> T 格式的参数
/// @autoclosure 并非只支持最后一个参数
/// 空合并运算符?? 使用了autoclosure技术
/// 有@auto closure、 无@autoclosure，构成了函数重载

///为了避免与期望冲突，使用了@autoclosure的地方最好明确注视清楚：这个值会被推迟执行

//: [属性](@next)
