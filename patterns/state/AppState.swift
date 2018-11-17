import ReSwift

//"0":FileMaker.getStuff(5), "1":FileMaker.getStuff(5), "2":FileMaker.getStuff(5)

struct AppState: StateType {
	var activeFileState:ActiveFileState = ActiveFileState()
	var navigationState:NavState = .files
	var text:String = ""
	var tabs:TabsState = TabsState()
	var items:DragItemsState = [:]
	var fileState = FileState()
	var selectedTabState:Int = 0
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.tabs == rhs.tabs
		&& lhs.items.keys == rhs.items.keys
		&& lhs.activeFileState == rhs.activeFileState
		&& lhs.selectedTabState == rhs.selectedTabState
	}
}

