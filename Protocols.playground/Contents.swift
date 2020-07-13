import UIKit

// Protocol syntax

//protocol SomeProtocol {
//    // Protocol definition goes here
//}
//
//struct SomeStructure: FirstProtocol, AnotherProtocol {
//    // Structure definition goes here
//}

//class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
//    // class definition goes here
//}

//-----------------------------------------------------------------------------------//
// Property requirement

/*
 
 protocol SomeProtocol {
 var mustBeSettable: Int { get set }
 var doesNoeNeedToBeSettable: Int { get }
 }
 */

// Type property

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

//struct Person: FullyNamed {
//    var fullName: String
//}
//
//let himanshu = Person(fullName: "Himanshu Rajput")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " ": "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//-----------------------------------------------------------------------------------//

// Method requirements

//protocol SomeProtocol {
//    static func someTypeMethod()
//}
//
//protocol RandomNumberGenerator {
//    func random() -> Double
//}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom/m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")
print("And another one: \(generator.random())")

//-----------------------------------------------------------------------------------//

// Mutating Method Requirements

protocol Toggleable {
    mutating func toggle()
}

enum OnOffSwitch: Toggleable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .off
            
        case .on:
            self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

//-----------------------------------------------------------------------------------//

// Initializer Requirements

/*
 protocol SomeProtocol {
 init(someParameter: Int)
 }
 
 class SomeClass: SomeProtocol {
 required init(someParameter: Int) {
 // initialization implementation goes here
 }
 }
 */

protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

//-----------------------------------------------------------------------------------//

// Protocols as Types

// You can use a protocol in many places where other types are allowed, including:

// 1. As a parameter type or return type in a function, method or initializer
// 2. As the type of a constant, variable, or property
// 3. As the type of items in an array, dictionary, or other container

/*
 class Dice {
 let sides: Int
 let generator: RandomNumberGenerator
 init(sides: Int, generator: RandomNumberGenerator) {
 self.sides = sides
 self.generator = generator
 }
 func roll() -> Int {
 return Int(generator.random() * Double(sides)) + 1
 }
 }
 
 var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
 for _ in 1...5 {
 print("random dice roll is \(d6.roll())")
 }
 */


//-----------------------------------------------------------------------------------//

// Delegation - Read from documentation

// Adding protocol conformance with an Extension

protocol TextRepresentation {
    var textualDescription: String { get }
}

//extension Dice: TextRepresentation {
//    var textualDescription: String {
//        return "A \(sides)-sided dice"
//    }
//}

//-----------------------------------------------------------------------------------//

// Conditional conforming to a protocol

extension Array: TextRepresentation where Element: TextRepresentation {
    var textualDescription: String {
        let itemAsText = self.map { $0.textualDescription }
        return "[" + itemAsText.joined(separator: ", ") + "]"
    }
}

//let myDice = [d6, d12]
//print(mydice.textualDescription)

//-----------------------------------------------------------------------------------//

// Declaring Protocol Adobtion with an Extension

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentation { }

//-----------------------------------------------------------------------------------//

// Adopting a Protocol Using a Synthesized implementation

struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let TwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if TwoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent")
}

// comparable protocol
enum SkillLevel: Comparable {
    static func < (lhs: SkillLevel, rhs: SkillLevel) -> Bool {
        if lhs > rhs {
            return true
        }
        return false
    }
    
    case beginner
    case intermediate
    case expert(stars: Int)
}

var levels = [SkillLevel.intermediate, SkillLevel.beginner, SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]

//for level in levels.sorted() {
//    print(level)
//}

//-----------------------------------------------------------------------------------//
// Collection of protocol

//let things: [TextRepresentation] = [game, d12, simonTheHamster]

//for thing in things {
//    print(thing.textualDescription)
//}

//-----------------------------------------------------------------------------------//
// Protocol inheritance

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // Protocol definition goes here
}

protocol PrettyTextRepresentation: TextRepresentation {
    var prettyTextualDescription: String { get }
}

//class SnakeAndLadders: PrettyTextRepresentation {
//    var prettyTextualDescription: String {
//        var output = TextRepresentation
//        // do what ever
//    }
//}

//-----------------------------------------------------------------------------------//

// Class only protocols

//protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
//    // class-only protocol definition goes here
//}

//-----------------------------------------------------------------------------------//
// Protocol composition

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: String { get }
}

struct Person: Named, Aged {
    var name: String
    
    var age: String
    
    
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birtheday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Person(name: "Himanshu", age: "12")
wishHappyBirthday(to: birthdayPerson)

//

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello \(location.name)")
}

let seattle = City(name: "Seatle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)

//-----------------------------------------------------------------------------------//

// Checking for Protocol Conformance

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415
    var radius: Double
    var area: Double { return pi*radius*radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Somthing that doesn't have an area")
    }
}

//-----------------------------------------------------------------------------------//
// Optional protocol requirements

@objc protocol CounterDataSource {
    @objc optional func increament(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    
    func increment() {
        if let amount = dataSource?.increament?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

class TowardsZeroSource: NSObject, CounterDataSource {
    func increament(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//-----------------------------------------------------------------------------------//

// Protocol Extensions

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return true
    }
}

let generator1 = LinearCongruentialGenerator()
print(generator1.randomBool())


extension PrettyTextRepresentation {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]

print(equalNumbers.allEqual())
print(differentNumbers.allEqual())
