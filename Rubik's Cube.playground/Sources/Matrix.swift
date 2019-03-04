import Foundation

public class Matrix {
    private let rows: Int
    private let columns: Int
    private var grid: [Int]
    
    public init(size: Int, value: Int) {
        self.rows = size
        self.columns = size
        grid = Array(repeating: value, count: size * size)
    }
    
    public init(size: Int) {
        self.rows = size
        self.columns = size
        var data = [Int]()
        for _ in size * size {
            data.append(Int.random(in: 0..<6))
        }
        grid = data
    }
    
    public init(orderedSize size: Int) {
        self.rows = size
        self.columns = size
        grid = (size * size).asArray
    }
    
    private func indexIsValid(row: Int, col: Int) -> Bool {
        return row >= 0 && row < rows && col >= 0 && col < columns
    }
    
    private func indexIsValid(_ indexPath: (row: Int, col: Int)) -> Bool {
        return indexIsValid(row: indexPath.row, col: indexPath.col)
    }
    
    public subscript(row: Int, col: Int) -> Int {
        get {
            assert(indexIsValid((row, col)), "Index out of range")
            return grid[(row * columns) + col]
        }
        set {
            assert(indexIsValid((row, col)), "Index out of range")
            grid[(row * columns) + col] = newValue
        }
    }
    
    public subscript(_ indexPath: (row: Int, col: Int)) -> Int {
        get {
            assert(indexIsValid(indexPath), "Index out of range")
            return grid[(indexPath.row * columns) + indexPath.col]
        }
        set {
            assert(indexIsValid(indexPath), "Index out of range")
            grid[(indexPath.row * columns) + indexPath.col] = newValue
        }
    }
    
    public func getCols() -> [[Int]] {
        return grid
            .reduce(into: [[Int]](repeating: [Int](), count: columns)) {
                (arr, row) in
                row.enumerated().forEach { (i,x) in
                    arr[i].append(x)
                }
        }
    }
    
    public func getRows() -> [[Int]] {
        return grid.chunked(into: rows)
    }
    
    public func rotate(with indexes: [(Int, Int)], _ direction: RotationDirection) {
        // no additional swap logic added to simplify code and make it faster
        assert(indexes.count == 4, "rotate with indexes method can only swap 4 items")
        
        switch direction {
        case .clockwise:
            rotateClockwise(with: indexes)
        case .counterClockwise:
            rotateCounterClockwise(with: indexes)
        }
    }
    
    private func rotateClockwise(with indexes: [(Int, Int)]) {
        swap(&self[indexes[0]], &self[indexes[3]])
        swap(&self[indexes[1]], &self[indexes[2]])
        swap(&self[indexes[1]], &self[indexes[3]])
    }
    
    private func rotateCounterClockwise(with indexes: [(Int, Int)]) {
        swap(&self[indexes[0]], &self[indexes[3]])
        swap(&self[indexes[0]], &self[indexes[2]])
        swap(&self[indexes[1]], &self[indexes[2]])
    }
    
    public func show() {
        getRows().forEach { print($0) }
    }
}
