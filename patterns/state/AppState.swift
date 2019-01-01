import ReSwift

struct AppState: StateType {
	var activeFileState:ActiveFileState = ActiveFileState()
	var navigationState:NavState = .files
	var text:String = ""
	var tabs:TabsState = TabsState()
	var items:DragItemsState = [:]
	var fileState = FileState()
	var selectedTabState:Int = -1
	var codeState:CodeState = .stopped
	var uiState:UIState = UIState(tabs: .show, symm: .hide)
	var drawingConfigState = DrawingConfigState(bg: Constants.COLORS.DARK_COLOR, fg: .white, width:10.0)
	func getCurrentTab() -> String{
		let names:[String] = self.tabs.names
		return names[self.selectedTabState]
	}
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.tabs == rhs.tabs
		&& lhs.items.keys == rhs.items.keys
		&& lhs.activeFileState == rhs.activeFileState
		&& lhs.selectedTabState == rhs.selectedTabState
		&& lhs.codeState == rhs.codeState
	}
}

