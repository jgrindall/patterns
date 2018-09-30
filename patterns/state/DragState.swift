import ReSwift

enum DragStates: String {
	case idle = "idle"
	case dragging = "dragging"
}

struct DragState: StateType {
	var state:DragStates = .idle
}

extension DragState: Equatable {}

func ==(lhs: DragState, rhs: DragState) -> Bool {
	return (lhs.state == rhs.state)
}

struct FileState{
	var selected:FileModel? = nil
	var files:[FileModel] = []
}



