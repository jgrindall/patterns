import ReSwift

struct AppState: StateType {
	var counter: Int = 0
	var codeStatus:String = "stopped"
	var navigationState = "draw"
	var text:String = "fd 250 rt 150 fd 380 lt 135 fd 250 lt 200 fd 500"
	var dataItems:[DragItemModel] = {
		var photos = [] as [DragItemModel]
		for index in 0...5 {
			photos.append(DragItemModel(type: "fd", label: "fd", imageSrc: "img.png"))
		}
		return photos
	}()
	var placeholderIndex:Int = -1
	var dragState = "idle"
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.counter == rhs.counter
		&& lhs.codeStatus == rhs.codeStatus
		&& lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.dataItems.count == rhs.dataItems.count
		&& lhs.placeholderIndex == rhs.placeholderIndex
		&& lhs.dragState == rhs.dragState
	}
}

