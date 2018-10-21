import ReSwift

class FileMaker{
	static func getStuff(_ n: Int) -> DragItems {
		var items = [] as [DragItemModel]
		for _ in 0...n {
			items.append(DragItemModel(type: "fd", label: "fd", imageSrc: "img.png"))
		}
		return items
	}
}

struct AppState: StateType {
	var dragState: DragState = DragState()
	var codeState:CodeState = .stopped
	var navigationState:NavState = .files
	var text:String = "fd 250 rt 150 fd 380 lt 135 fd 250 lt 200 fd 500"
	var items:DragItemsHash = ["0":FileMaker.getStuff(5), "1":FileMaker.getStuff(5), "2":FileMaker.getStuff(5)]
	var listItems = ListItemsState(items: {
		var items = [] as [ListItemModel]
		for index in 0...5 {
			items.append(ListItemModel(type: "fd", clr:UIColor.red, label: "fd", imageSrc: "img.png"))
		}
		return items
	}())
	var fileState = FileState()
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.codeState == rhs.codeState
		&& lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.items.keys == rhs.items.keys
		&& lhs.listItems == rhs.listItems
		&& lhs.dragState == rhs.dragState
	}
}

