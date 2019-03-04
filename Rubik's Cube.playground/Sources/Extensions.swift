import Foundation

extension Int: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<self).makeIterator()
    }
}

public extension Array {
    func toSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }
}

public extension Int {
    var asArray: [Int] {
        var result = [Int]()
        for index in 0..<self {
            result.append(index)
        }
        return result
    }
}

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
