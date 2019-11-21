import Foundation

//：可选项（Optional） 可选项，也叫可选类型，它允许将值设置为nil
// 在类型名称后面加个问号?， 来定义一个可选项
var name: String? = "Jack"
name = nil
var array = [1, 15, 40, 29]
func get(_ index: Int) -> Int? {
    if index < 0 || index >= array.count {
        return nil
    }
    return array[index]
}
get(1)
get(-1)
get(4)

//: 强制解包
// 可选项是对其他类型的一层包装，可以将它理解为一个盒子
// 如果为nil，那么它是个空壳子。如果不为nil，那么盒子里装的是：被包装的数据
var age: Int?
age = 10
age = nil

// 如果要从可选项中取出被包装的数据（将盒子里包装的东西取出来），需要使用感叹号！进行强制解包
var age1: Int? = 10
var ageInt: Int = age1!
ageInt += 10

// 如果对值为nil的可选项（空盒子）进行强制解包，将会产生运行时错误
var age2: Int?
//age2!

//: 判断可选项是否包含值
let number = Int("123")
if number != nil {
    print(number!)
} else {
  print("转换失败")
}

//: 可选项绑定
///可以使用可选项绑定来判断可选项是否包含值
///如果包含就自动解包，把值赋值给一个临时的常量（let）或者变量（var）,并且返回true，否则返回false
if let number = Int("123") {
    print(number)
} else {
    print("字符串转换整数失败")
}

//: 等价写法
if let first = Int("4") {
    if let second = Int("42"){
        if first < second && second < 100 {
            print("\(first) < \(second) < 100")
        }
    }
}

if let first = Int("4"), let second = Int("42") {
    if first < second && second < 100 {
        print("\(first) < \(second) < 100")
    }
}
//: 空合并运算符 ??
/*
 a ?? b
 a是可选项
 b是可选项 或者不是可选项
 b 跟 a 的存储类型必须相同
 如果 a 不为nil，就返回a
 如果 a 为nil，就返回b
 如果 b 不是可选项， 返回 a 时会自动解包
 */

let a: Int? = 1
let b: Int? = 2
let c = a ?? b

let a1: Int? = nil
let b1: Int? = 2
let c1 = a1 ?? b1

let a2: Int? = nil
let b2: Int? = nil
let c2 = a2 ?? b2

let a3: Int? = 1
let b3: Int = 2
let c3 = a3 ?? b3

let a4: Int? = nil
let b4: Int = 2
let c4 = a4 ?? b4

let a5: Int? = nil
let b5: Int = 2
/// 如果不使用？？运算符
let c5: Int
if let tmp = a5 {
    c5 = tmp
} else {
  c5 = b5
}

//: 多个 ?? 一起使用
let aa: Int? = 1
let bb: Int? = 2
let cc = aa ?? bb ?? 3

let aa1: Int? = nil
let bb1: Int? = 2
let cc1 = aa1 ?? bb1 ?? 3

let aa2: Int? = nil
let bb2: Int? = nil
let cc2 = aa2 ?? bb2 ?? 3

//: ??跟 if let 配合使用
let A: Int? = nil
let B: Int? = 2
if let C = A ?? B {
    print(C)
}
/// 类似于if A != nil || B != nil

if let C = A, let D = B {
    print(C)
    print(D)
}
///类似于if A  != nil && B != nil

//: guard语句
/*
 guard 条件 else {
 // do something...
    退出当前作用域
 // return、break、continue、throw error
 }
 
 当guard语句的条件为false时，就会执行大括号里面的代码
 当guard语句的条件为true时，就会跳过guard语句
 guard语句特别适合用来 提前退出
 */

/// 当使用guard语句进行可选项绑定时，绑定的常量(let)、变量(var)也能在外层作用域中使用
func login(_ info: [String: String]) {
    guard let username = info["username"] else {
        print("请输入用户名")
        return
    }
    
    guard let password = info["password"] else {
        print("请输入密码")
        return
    }
    print("用户名：\(username)", "密码，\(password)", "登录ing")
}

//:隐式解包
///在某种情况下，可选项一旦被设定值后，就会一直拥有值
///在使用这种情况下，可以去掉检查，不必每次访问的时候进行解包，因为它能确定每次访问的时候都有值
///可以在类型后面加个！定义一个隐式解包的可选项
let num1: Int! = 10
let num2: Int = num1
if num1 != nil {
    print(num1 + 6)
}
if let num3 = num1 {
    print(num3)
}

//: 打印可选项时，编译器会发出警告
var selfAge: Int? = 10
print(selfAge)

/// 有四种方法消除警告
print(selfAge as Any)
print(String(describing: selfAge))
print(selfAge ?? 0)
print(selfAge!)
//: 多重可选项
var testNum1: Int? = 10
var testNum2: Int?? = testNum1
var testNum3: Int?? = 10
//print(testNum2 == testNum3)


var testNum11: Int? = nil
var testNum22: Int?? = testNum11
var testNum33: Int?? = nil

//print(testNum22 == testNum33)
/// 可以使用lldb指令 frame variable -R 或者 fr v -R查看区别
//: [结构体和类](@next)


