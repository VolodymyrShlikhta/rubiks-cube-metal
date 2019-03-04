public class Cube: Validation, CubeDefinable {
    
    // MARK: - Properties
    
    public let size: Int
    // FIXME: - Simplify later, there is no need to give user rotation of 6 sides,
    // because there are only 3 possible rotation sides in 2 directions
    // all that is changed for them is rotation line
    public let sides: Int = 6
    private var data = [Matrix]()
    
    private var numberOfRotationCircles: Int {
        return size / 2
    }
    
    // MARK: - Init and deinit
    
    public init(size: Int, layout: LayoutType = .normal) {
        assert(size >= 2, "Please enter valid size(1<x<*), \(size) is not applicable")
        self.size = size
        constructData(with: layout)
    }
    
    private func constructData(with layout: LayoutType) {
        switch layout {
        case .normal:
            sides.asArray.forEach { data.append(Matrix(size: size, value: $0)) }
        case .random:
            sides.asArray.forEach { _ in data.append(Matrix(size: size)) }
        case .ordered:
            sides.asArray.forEach { _ in data.append(Matrix(orderedSize: size)) }
        }
    }
    
    // MARK: - Methods
    
    func show(side: Int) {
        data[side].show()
    }
    
    func show() {
        print("--------")
        data.forEach {
            $0.show()
        }
    }
    
    private var sizeAsIndex: Int {
        return size - 1
    }
    
    //    private func rotate2(side: CubeSide, )
    
    func rotate(side: Int, direction: RotationDirection, rotationData: RotationData) {
        // NOTE: - Probably remove validations, because it's additional operations
        // and due to the fact that rotations will be performed only for valid info
        // there may not be any need to do this
        guard isSideInRange(side), isLinesInRange(rotationData) else {
            print("Wrong side or line, skipping rotation")
            return
        }
        let targetSide = calculateTargetSide(for: side, in: direction)
        
        //        rotationData.lines.forEach { line in
        //            swap(line, from: side, to: targetSide)
        //        }
        //
        //        rotationData.lines
        //            .intersection([0, sizeAsIndex])
        //            .forEach { rotateAdditional(side: $0, in: direction) }
    }
    
    private func swap(_ line: Int, from side: Int, to swapSide: Int) {
        
    }
    
    private func calculateTargetSide(for startSide: Int, in direction: RotationDirection) -> Int {
        
        return 0
    }
    
    private func rotateAdditional(side: Int, in direction: RotationDirection) {
        // prob rewrite if to functional approach
        for circleIndex in numberOfRotationCircles {
            let lastCellIndex = (sizeAsIndex - (circleIndex * 2))
            for rotationCellIndex in lastCellIndex {
                print("Circle: \(circleIndex)\nRotation cell index: \(rotationCellIndex)")
                let lastCellIndex = sizeAsIndex - circleIndex - rotationCellIndex
                // (row,col)
                // goes from left to right on top
                let leftTopIndex = (circleIndex, circleIndex + rotationCellIndex)
                // goes on right from top to bot
                let rightTopIndex = (circleIndex + rotationCellIndex, sizeAsIndex - circleIndex)
                // goes on bot from right to left
                let leftBotIndex = (lastCellIndex, circleIndex)
                // bottom side
                let rightBotIndex = (sizeAsIndex - circleIndex, lastCellIndex)
                let indexes = [leftTopIndex, rightTopIndex, rightBotIndex, leftBotIndex]
                print(indexes)
                data[side].rotate(with: indexes, direction)
            }
        }
    }
}

extension Cube: CubeInterface {
    public func scramble() {
        
    }
}



let test = Cube(size: 3, layout: .ordered)
test.show()
//test.rotate(side: 0, direction: .clockwise, rotationLines: [0])
