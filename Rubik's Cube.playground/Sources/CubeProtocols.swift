import Foundation

public protocol CubeInterface {
    func scramble()
}

public protocol CubeDefinable: class {
    var size: Int { get }
    var sides: Int { get }
}

public protocol Validation: class {
    func isLinesInRange(_ data: RotationData) -> Bool
    func isSideInRange(_ side: Int) -> Bool
}

public extension Validation where Self: CubeDefinable {
    func isLinesInRange(_ data: RotationData) -> Bool {
        // $0 >= size because we are operation on indexes
        return data
            .indexes
            .first { $0 < 0 || $0 >= size } == nil
    }
    
    func isSideInRange(_ side: Int) -> Bool {
        return (side >= 0 && side < sides)
    }
}
