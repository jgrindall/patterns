import ReSwift

struct AppState: StateType {
	var counter: Int = 0
	var codeStatus:String = "stopped"
	var navigationState = "draw"
	var text:String = "fd 250 rt 150 fd 380 lt 135 fd 250 lt 200 fd 500"
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.counter == rhs.counter
			&& lhs.codeStatus == rhs.codeStatus
			&& lhs.navigationState == rhs.navigationState
			&& lhs.text == rhs.text
	}
}
