import ReSwift

class DrawingConfigState{
	var bg:UIColor = .red
	var fg:UIColor = .green
	init(bg:UIColor, fg:UIColor) {
		self.bg = bg
		self.fg = fg
	}
}

extension DrawingConfigState: Equatable {}

func == (lhs: DrawingConfigState, rhs: DrawingConfigState) -> Bool {
	return (lhs.bg == rhs.bg && lhs.fg == rhs.fg)
}






