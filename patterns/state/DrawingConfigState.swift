import ReSwift

class DrawingConfigState{
	var bg:UIColor = UIColor(red: 8.0/255.0, green: 20.0/255.0, blue: 62.0/255.0, alpha: 1)
	var fg:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
	var width:CGFloat = 10.0
	init(bg:UIColor, fg:UIColor, width:CGFloat) {
		self.bg = bg
		self.fg = fg
		self.width = width
	}
}

extension DrawingConfigState: Equatable {}

func == (lhs: DrawingConfigState, rhs: DrawingConfigState) -> Bool {
	return (lhs.bg == rhs.bg && lhs.fg == rhs.fg && lhs.width == rhs.width)
}






