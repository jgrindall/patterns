import ReSwift

enum UITabState:String{
	case show = "show"
	case hide = "hide"
}

struct UIState {
	var tabs:UITabState = .show
	var symm:UITabState = .hide
}

extension UIState: Equatable {}

func ==(lhs: UIState, rhs: UIState) -> Bool {
	return (lhs.tabs == rhs.tabs && lhs.symm == rhs.symm)
}
