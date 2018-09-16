import ReSwift

enum DragStates: String {
	case idle = "idle"
	case dragging = "dragging"
}

struct DragState: StateType {
	var placeholderIndex:Int = -1
	var state:DragStates = .idle
}

extension DragState: Equatable {}

func ==(lhs: DragState, rhs: DragState) -> Bool {
	return (lhs.placeholderIndex == rhs.placeholderIndex && lhs.state == rhs.state)
}

