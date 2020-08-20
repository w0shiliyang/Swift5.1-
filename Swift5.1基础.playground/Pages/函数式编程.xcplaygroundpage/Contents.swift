import Foundation
//:Array的常见操作
do {
    let arr = [1, 2, 3, 4]
    let arr2 = arr.map { $0 * 2 }
    // [2, 4, 6, 8]
    print(arr2)
    // [2, 4]
    let arr3 = arr.filter { $0 % 2 == 0 }
    // 10
    print(arr3)
    let arr4 = arr.reduce(0) { $0 + $1 }
    // 10
    print(arr4)
    let arr5 = arr.reduce(0, +)
    print(arr5)
}

do {
    func double(_ i: Int) -> Int { i * 2 }
    let arr = [1, 2, 3, 4]
    // [2, 4, 6, 8]
    print(arr.map(double))
}

do {
    let arr = [1, 2, 3]
    let arr2 = arr.map { Array.init(repeating: $0, count: $0) }
    // [[1], [2, 2], [3, 3, 3]]
    print(arr2)
    let arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
    // [1, 2, 2, 3, 3, 3]
    print(arr3)
}

do {
    let arr = ["123", "test", "jack", "-30"]
    let arr2 = arr.map { Int($0) }
    // [Optional(123), nil, nil, Optional(-30)]
    print(arr2)
    let arr3 = arr.compactMap { Int($0) }
    // [123, -30]
    print(arr3)
}

do {
    // 使用reduce实现map、filter的功能
    let arr = [1, 2, 3, 4]
    // [2, 4, 6, 8]
    print(arr.map { $0 * 2 })
    print(arr.reduce([]) { $0 + [$1 * 2] })
    // [2, 4]
    print(arr.filter { $0 % 2 == 0 })
    print(arr.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 })
}
//:lazy的优化
do {
    let arr = [1, 2, 3]
    let result = arr.lazy.map { (i: Int) -> Int in
        print("mapping \(i)")
        return i * 2
    }
    print("begin-----")
    print("mapped", result[0])
    print("mapped", result[1])
    print("mapped", result[2])
    print("end----")
    /*
     begin-----
     mapping 1
     mapped 2
     mapping 2
     mapped 4
     mapping 3
     mapped 6
     end----
     */
}
//:Optional的map和flatMap
do {
    let num1: Int? = 10
    let num2 = num1.map { $0 * 2 }
    // Optional(20)
    print(num2 as Any)
    
    let num3: Int? = nil
    let num4 = num3.flatMap { $0 * 2 }
    // nil
    print(num4 as Any)
}

do {
    /// 字符串 转 日期
    let fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    let str: String? = "2011-09-10"
    // old
    let date1 = str != nil ? fmt.date(from: str!) : nil
    print(date1 as Any)
    // new
    let date2 = str.flatMap(fmt.date)
    print(date2 as Any)
}

do {
    let num1: Int? = 10
    let num2 = num1.map { Optional.some($0 * 2) }
    // Optional(Optional(20))
    print(num2 as Any)
    
    let num3 = num1.flatMap { Optional.some($0 * 2) }
    // Optional(20)
    print(num3 as Any)
}

do {
    let score: Int? = 98
    // old
    let str1 = score != nil ? "socre is \(score!)" : "No score"
    print(str1)
    // new
    let str2 = score.map { "score is \($0)" } ?? "No score"
    print(str2)
}

do {
    let num1: Int? = 10
    let num2 = (num1 != nil) ? (num1! + 10) : nil
    let num3 = num1.map { $0 + 10 }
    // num2、num3是等价的
    print(num2 as Any)
    print(num3 as Any)
}

do {
    struct Person {
        var name: String
        var age: Int
    }
    var items = [
        Person(name: "jack", age: 20),
        Person(name: "rose", age: 21),
        Person(name: "kate", age: 22)
    ]
    // old
    func getPerson1(_ name: String) -> Person? {
        let index = items.firstIndex { $0.name == name }
        return index != nil ? items[index!] : nil
    }
    // new
    func getPerson2(_ name: String) -> Person? {
        return items.firstIndex { $0.name == name }.map { items[$0] }
    }
}

do {
    struct Person {
        var name: String
        var age: Int
        init?(_ json: [String : Any]) {
            guard let name = json["name"] as? String,
                let age = json["age"] as? Int else {
                return nil
            }
            self.name = name
            self.age = age
        }
    }
    let json: Dictionary? = ["name" : "Jack", "age" : 10] // old
    let p1 = json != nil ? Person(json!) : nil
    // new
    let p2 = json.flatMap(Person.init)
    
    print(p1 as Any)
    print(p2 as Any)
}
//:函数式编程(Funtional Programming)
//函数式编程(Funtional Programming，简称FP)是一种编程范式，也就是如何编写程序的方法论
//主要思想:把计算过程尽量分解成一系列可复用函数的调用
//主要特征:函数是“第一等公民”
//函数与其他数据类型一样的地位，可以赋值给其他变量，也可以作为函数参数、函数返回值
//函数式编程最早出现在LISP语言，绝大部分的现代编程语言也对函数式编程做了不同程度的支持，比如 p Haskell、JavaScript、Python、Swift、Kotlin、Scala等
//函数式编程中几个常用的概念 pHigher-Order Function、Function Currying pFunctor、Applicative Functor、Monad
//参考资料
//http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html p http://www.mokacoding.com/blog/functor-applicative-monads-in-pictures

//:FP实践 – 传统写法
// 假设要实现以下功能:[(num + 3) * 5 - 1] % 10 / 2
do {
    var num = 1
    func add(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    func sub(_ v1: Int, _ v2: Int) -> Int {
        v1 - v2
    }
    func multiple(_ v1: Int, _ v2: Int) -> Int {
        v1 * v2
    }
    func divide(_ v1: Int, _ v2: Int) -> Int {
        v1 / v2
    }
    func mod(_ v1: Int, _ v2: Int) -> Int {
        v1 % v2
    }
    divide(mod(sub(multiple(add(num, 3), 5), 1), 10), 2)
}

infix operator >>> : AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B,_ f2: @escaping (B) -> C) -> (A) -> C {
    { f2(f1($0)) }
}

// FP实践 – 函数式写法
do {
    var num = 1
    func add(_ v: Int) -> (Int) -> Int {
        { $0 + v }
    }
    func sub(_ v: Int) -> (Int) -> Int {
        { $0 - v }
    }
    func multiple(_ v: Int) -> (Int) -> Int {
        { $0 * v }
    }
    func divide(_ v: Int) -> (Int) -> Int {
        { $0 / v }
    }
    func mod(_ v: Int) -> (Int) -> Int {
        { $0 % v }
    }
    let fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
    fn(num)
}
//:高阶函数(Higher-Order Function)
//高阶函数是至少满足下列一个条件的函数:
//接受一个或多个函数作为输入(map、filter、reduce等)
//返回一个函数
//FP中到处都是高阶函数
do {
    func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
}
//:柯里化(Currying)
//什么是柯里化?
//将一个接受多参数的函数变换为一系列只接受单个参数的函数
//柯里化
do {
    func add1(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    add1(10, 20)
    
    func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
    add(10)(20)
    ///Array、Optional的map方法接收的参数就是一个柯里化函数
}

do {
    func add1(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    func add2(_ v1: Int, _ v2: Int, _ v3: Int) -> Int { v1 + v2 + v3 }
    func currying<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
        { b in { a in fn(a, b) } }
    }
    func currying1<A, B, C, D>(_ fn: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
        {   c in
            {   b in
                { a in
                    fn(a, b, c)
                }
            }
        }
    }
    let curriedAdd1 = currying(add1)
    print(curriedAdd1(10)(20))
    let curriedAdd2 = currying1(add2)
    print(curriedAdd2(10)(20)(30))
}

prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    { b in { a in fn(a, b) } }
}

do {
    func add(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }

    func sub(_ v1: Int, _ v2: Int) -> Int {
        v1 - v2
    }
    func multiple(_ v1: Int, _ v2: Int) -> Int {
        v1 * v2
    }
    func divide(_ v1: Int, _ v2: Int) -> Int {
        v1 / v2
    }
    func mod(_ v1: Int, _ v2: Int) -> Int {
        v1 % v2
    }
    
    let num = 1
    let fn = (~add)(3) >>> (~multiple)(5) >>> (~sub)(1) >>> (~mod)(10) >>> (~divide)(2)
    fn(num)
}
