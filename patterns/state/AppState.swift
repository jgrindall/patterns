import ReSwift

typealias DragItems = [DragItemModel]

enum CodeState: String {
	case stopped = "stopped"
	case started = "started"
	case stopping = "stopping"
}

enum NavState: String {
	case draw = "draw"
}

struct AppState: StateType {
	var dragState: DragState = DragState()
	var codeState:CodeState = .stopped
	var navigationState:NavState = .draw
	var text:String = "fd 250 rt 150 fd 380 lt 135 fd 250 lt 200 fd 500"
	var items:DragItems = {
		var items = [] as [DragItemModel]
		for index in 0...5 {
			items.append(DragItemModel(type: "fd", label: "fd", imageSrc: "img.png"))
		}
		return items
	}()
	var listItems = ListItemsState(items: {
		var items = [] as [ListItemModel]
		for index in 0...5 {
			items.append(ListItemModel(type: "fd", clr:UIColor.red, label: "fd", imageSrc: "img.png"))
		}
		return items
	}())
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.codeState == rhs.codeState
		&& lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.items.elementsEqual(rhs.items)
		&& lhs.listItems == rhs.listItems
		&& lhs.dragState == rhs.dragState
	}
}

