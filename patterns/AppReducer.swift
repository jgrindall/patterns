import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
	return AppState(
		dragState: dragReducer(action: action, state: state?.dragState),
		codeState: statusReducer(action: action, codeState: state?.codeState),
		navigationState: navReducer(action: action, state: state?.navigationState),
		text: textReducer(action: action, state: state?.text),
		items: itemsReducer(action: action, items: state?.items)
	)
}

func navReducer(action: Action, state: NavState?) -> NavState {
	return state!
}

func textReducer(action: Action, state: String?) -> String {
	switch action {
		case let action as EditTextAction:
			return action.payload
		default:
			return ""
	}
}

func itemsReducer(action: Action, items: DragItems?) -> DragItems {
	switch action {
		case let action as InsertItemAction:
			let index:Int = action.payload
			let newItem = DragItemModel(type: "fd", label: "fd", imageSrc: "img1.png")
			return MathUtils.getInsertedAt(a: items!, index: index, element: newItem)
		default:
			return items!
	}
}

func statusReducer(action: Action, codeState: CodeState?) -> CodeState {
	switch action {
		case _ as StatusActionStart:
			return CodeState.started
		case _ as StatusActionStopping:
			return CodeState.stopping
		case _ as StatusActionStopped:
			return CodeState.stopped
		default:
			return CodeState.stopped
	}
}

func dragReducer(action: Action, state: DragState?) -> DragState {
	var state = state ?? DragState()
	switch action {
		case let action as SetDragStateAction:
			state.state = action.payload
		case let action as SetPlaceholderAction:
			state.placeholderIndex = action.payload
		default:
			break
	}
	return state
}

