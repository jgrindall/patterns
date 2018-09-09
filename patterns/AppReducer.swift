import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
	var state = state ?? AppState()
	switch action {
		case _ as StatusActionStart:
			state.codeStatus = "started"
		case _ as StatusActionStopping:
			state.codeStatus = "stopping"
		case _ as StatusActionStopped:
			state.codeStatus = "stopped"
		case let action as EditTextAction:
			state.text = action.payload
		case let action as InsertItemAction:
			let index:Int = action.payload
			let newItem = DragItemModel(type: "fd", label: "fd", imageSrc: "img1.png")
			state.dataItems = MathUtils.getInsertedAt(a: state.dataItems, index: index, element: newItem)
			state.placeholderIndex = -1
		case let action as SetDragStateAction:
			let s:String = action.payload
			state.dragState = s
		case let action as SetPlaceholderAction:
			let realDataItems:[DragItemModel] = state.dataItems
			var placeholderIndex:Int = action.payload
			if(placeholderIndex < 0){
				placeholderIndex = -1
			}
			if(placeholderIndex > realDataItems.count){
				placeholderIndex = -1
			}
			state.placeholderIndex = placeholderIndex
		default:
			break
	}
	return state
}

