import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
	return AppState(
		dragState: dragReducer(action: action, state: state?.dragState),
		codeState: statusReducer(action: action, codeState: state?.codeState),
		navigationState: navReducer(action: action, state: state?.navigationState),
		text: textReducer(action: action, state: state?.text),
		items: itemsReducer(action: action, items: state?.items),
		listItems: (state?.listItems)!,
		fileState:filesReducer(action: action, state: state?.fileState)
	)
}

func navReducer(action: Action, state: NavState?) -> NavState {
	let state = state ?? .files
	switch action {
	case let action as NavigateAction:
		return action.payload
	default:
		return state
	}
}

func textReducer(action: Action, state: String?) -> String {
	switch action {
		case let action as EditTextAction:
			return action.payload
		default:
			return ""
	}
}

func itemsReducer(action: Action, items: DragItemsHash?) -> DragItemsHash {
	var itemsCopy:DragItemsHash = items!
	switch action {
		case let action as InsertItemAction:
			let index:Int = action.payload.index
			let newItem = DragItemModel(type: "fd", label: "fd", imageSrc: "img1.png")
			itemsCopy[action.payload.key] = MathUtils.getInsertedAt(a: items![action.payload.key]!, index: index, element: newItem)
			return itemsCopy
		case let action as UpdateItemAction:
			let edit:Edit = action.payload
			itemsCopy[action.payload.key] = MathUtils.getReplacedAt(a: items![action.payload.key]!, index: edit.index, element: edit.model)
			return itemsCopy
		case let action as DeleteItemAction:
			itemsCopy["0"] = MathUtils.getDeletedAt(a: items!["0"]!, index: action.payload)
			return itemsCopy
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
	let state = state ?? DragState()
	return state
}

func filesReducer(action: Action, state: FileState?) -> FileState {
	switch action {
		case let action as OpenFileAction:
			var model:FileModel? = action.payload
			if(model == nil){
				model = Files.getBlank()
			}
			return FileState(selected: state?.selected, files: (state?.files)!, loaded:model)
		case let action as SetFilesAction:
			return FileState(selected: state?.selected, files: action.payload, loaded:state?.loaded)
		case let action as SetSelectedAction:
			return FileState(selected: action.payload, files: (state?.files)!, loaded:state?.loaded)
		default:
			return state ?? FileState()
	}
}

