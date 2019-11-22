import Foundation
//: 继承（Inheritance）
/// 值类型（枚举、结构体）不支持继承，只有类支持继承
/// 没有父类的类，称为：基类
/// Swift并没有像OC、Java那样的规定： 任意类都最终都要继承自某个基类
/// 子类可以重写父类的下标、方法、属性，重写必须加上override关键字
//:重写实例方法、下标
class Animal {
    func speak() {
        print("Animal speek")
    }
    subscript(index: Int) -> Int {
        return index
    }
}

var anim: Animal
anim = Animal()
// Animal speak
anim.speak()
// 6
print(anim[6])

class Cat: Animal {
    override func speak() {
        super.speak()
        print("Cat speak")
    }
    override subscript(index: Int) -> Int {
        return super[index] + 1
    }
}

anim = Cat()
// Animal speak
// Cat speak
anim.speak()
// 7
print(anim[6])

/// 被class修饰的类型方法、下标，允许被子类重写
/// 被static修饰的类型方法、下标，不允许被子类重写

//: 重写属性
/// 子类可以将父类的属性（存储、计算）重写为计算属性
/// 子类不可以将父类属性重写为存储属性
/// 只能重写var属性，不能重写let属性
/// 重写时，属性名、类型要一致

/// 子类重写后的属性权限 不能小于 父类属性的权限
/// 如果父类属性是只读的，那么子类z重写后的属性可以是只读的、也可以是可读写的
/// 如果父类属性是可读写的，那么子类重写后的属性也可以是可读写的
//:重写实例属性
class Circle {
    var radius: Int = 0
    var diameter: Int {
        set {
            print("Circle setDiameter")
            radius = newValue / 2
        }
        get {
            print("Circle getDiameter")
            return radius * 2
        }
    }
}

var circle: Circle
circle = Circle()
circle.radius = 6
// Circle getDiamter
// 12
print(circle.diameter)
// Circle setDiameter
circle.diameter = 20
// 10
print(circle.radius)

class SubCircle : Circle {
    override var radius: Int {
        set {
            print("SubCircle setRadius")
            super.radius = newValue > 0 ? newValue : 0
        }
        get {
            print("SubCircle getRadius")
            return super.radius
        }
    }
    override var diameter: Int {
        set {
            print("SubCircle setDiameter")
            super.diameter = newValue > 0 ? newValue : 0
        }
        get {
            print("SubCircle getDiameter")
            return super.diameter
        }
    }
}

circle = SubCircle()

//SubCircle setRaius
circle.radius = 6

// SubCircle getDiameter
// Circle getDiameter
// SubCircle getRadius
// 12
print(circle.diameter)

// SubCircle setDiameter
// Circle setDiameter
// SubCircle setRaius
circle.diameter = 12

// SubCircle getRaius
// 10
print(circle.radius)

//: 重写类型属性
/// 被class修饰的计算类型属性，可以被子类重写
/// 被static修饰的类型属性（存储、计算），不可以被子类重写
class Circle1 {
    static var radius: Int = 0
    class var diameter: Int {
        set {
            print("Circle setDiameter")
        }
        get {
            print("Circle getDiameter")
            return radius * 2
        }
    }
}

class SubCircle1: Circle1 {
    override static var diameter: Int {
        set {
            print("SubCircle setDiameter")
            super.diameter = newValue > 0 ? newValue : 0
        }
        get {
            print("SubCircle getDiameter")
            return super.diameter
        }
    }
}
Circle1.radius = 6
// Circle getDiameter
// 12
print(Circle1.diameter)
// Circle setDiameter
Circle1.diameter = 20
// 10
print(Circle1.radius)

SubCircle1.radius = 6
// SubCircle getDiameter
// Circle getDiameter
// 12
print(SubCircle1.diameter)
// SubCircle setDiameter
// Circle setDiameter
SubCircle1.diameter = 20
// 10
print(SubCircle1.radius)
//: 属性观察器
///1、 可以在子类中为父类属性（除了只读计算属性、let属性）增加属性观察器
class TestCircle {
    var radius: Int = 1
}
class TestSubCircle: TestCircle {
    override var radius: Int {
        willSet {
            print("SubCircle willSetRadius", newValue)
        }
        didSet {
            print("SubCircle didSetRadius", oldValue, radius)
        }
    }
}
var testCircle = TestCircle()
// SubCircle willSetRadius 10
// SubCircle didSetRadius 1 10
testCircle.radius = 10

///2、
class TestCircle2 {
    var radius: Int = 1 {
        willSet {
            print("Cricle willSetRadius", newValue)
        }
        didSet {
            print("Circle didSetRaridus", oldValue, radius)
        }
    }
}
class TestSubCircle2: TestCircle2 {
    override var radius: Int {
        willSet {
            print("SubCircle willSetRadius", newValue)
        }
        didSet {
            print("SubCircle didSetRadius", oldValue, radius)
        }
    }
}

var testCircle2 = TestSubCircle2()
// SubCircle willSetRadius 10
// Circle willSetRadius 10
// Circle didSetRadius 1 10
// SubCircle didSetRadius 1 10
testCircle2.radius = 10

/// 3、
class Circle3 {
    var radius: Int {
        set {
            print("Circle setRadius", newValue)
        }
        get {
            print("Circle getRadius")
            return 20
        }
    }
}
class SubCircle3: Circle3 {
    override var radius: Int {
        willSet {
            print("SubCircle willSetRadius", newValue)
        }
        didSet {
            print("SubCircle didSetRadius", oldValue, radius)
        }
    }
}
var circle3 = SubCircle3()
// Circle getRadius
// SubCircle willSetRadius 10
// Circle setRadius 10
// Circle getRadius
// SubCircle didSetRadius 20 20
circle3.radius = 10

//4、
class Circle4 {
    class var radius: Int {
        set {
            print("Circle setRadius", newValue)
        }
        get {
            print("Circle getRadius")
            return 20
        }
    }
}
class SubCircle4: Circle4 {
    override static var radius: Int {
        willSet {
            print("SubCircle willSetRadius", newValue)
        }
        didSet {
            print("SubCircle didSetRadius", oldValue, radius)
        }
    }
}
// Circle getRadius
// SubCircle willSetRadius 10
// Circle setRadius 10
// Circle getRadius
// SubCircle didSetRadius 20 20
SubCircle4.radius = 10
//: final
/// 被final修饰的方法、下标、属性，禁止被重写
/// 被final修饰的类，禁止被继承

//: [初始化](@next)
