import ReSwift

struct AppState: StateType {
	var activeFileState:ActiveFileState = ActiveFileState()
	var navigationState:NavState = .files
	var text:String = ""
	var items:Polygons = []
	var fileState = FileState()
	var codeState:CodeState = .stopped
	var uiState:UIState = UIState(tabs: .show, symm: .hide)
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.items == rhs.items
		&& lhs.activeFileState == rhs.activeFileState
		&& lhs.codeState == rhs.codeState
	}
}

