import ReSwift

struct DrawingConfigState{
	var bg:UIColor = .red
	var fg:UIColor = .green
}

extension DrawingConfigState: Equatable {}

func == (lhs: DrawingConfigState, rhs: DrawingConfigState) -> Bool {
	return (lhs.bg == rhs.bg && lhs.fg == rhs.fg)
}






