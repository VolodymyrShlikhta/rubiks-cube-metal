import Foundation

public struct RotationData: Hashable {
    let indexes: Set<Int>
    let side: Int
    let line: RotationLine
}

public enum RotationDirection {
    case clockwise
    case counterClockwise
}

public enum RotationLine: Hashable {
    case row
    case col
}

public enum LayoutType {
    case ordered
    case random
    case normal
}

public enum CubeSide: CaseIterable {
    case top
    case front
    case right
    case back
    case left
    case bot
    
    var index: Int {
        return CubeSide.allCases.firstIndex(of: self) ?? 0
    }
    
    var relatedRotationSides: [CubeSide] {
        switch self {
        case .top, .bot: return [.front, .right, .back, .left]
        case .right, .left: return [.top, .front, .back, .bot]
        case .front, .back: return [.top, .right, .left, .bot]
        }
    }
}
