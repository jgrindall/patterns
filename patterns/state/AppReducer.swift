import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
	return AppState(
		activeFileState:activeFileReducer(action: action, state: state?.activeFileState),
		navigationState: navReducer(action: action, state: state?.navigationState),
		text: textReducer(action: action, state: state?.text),
		tabs:tabsReducer(action: action, state: (state?.tabs)!),
		items: itemsReducer(action: action, items: state?.items),
		fileState:filesReducer(action: action, state: state?.fileState),
		selectedTabState:selectedTabReducer(action: action, state: state!.selectedTabState),
		codeState:codeReducer(action: action, state: state!.codeState),
		uiState:uiReducer(action: action, state: state!.uiState),
		drawingConfigState:configReducer(action: action, state: state!.drawingConfigState)
	)
}

func configReducer(action: Action, state: DrawingConfigState) -> DrawingConfigState {
	let state = state
	switch action {
	case let action as SetBgStateAction:
		return DrawingConfigState(bg: action.payload, fg: state.fg, width:state.width)
	case let action as SetFgStateAction:
		return DrawingConfigState(bg: state.bg, fg:action.payload, width:state.width)
	case let action as SetLineWidthStateAction:
		return DrawingConfigState(bg: state.bg, fg:state.fg, width:action.payload)
	default:
		return state
	}
}

func uiReducer(action: Action, state: UIState) -> UIState {
	let state = state
	switch action {
	case let action as SetUIStateAction:
		return action.payload
	default:
		return state
	}
}

func codeReducer(action: Action, state: CodeState) -> CodeState {
	let state = state
	switch action {
	case let action as SetCodeStateAction:
		return action.payload
	default:
		return state
	}
}

func selectedTabReducer(action: Action, state: Int) -> Int {
	let state = state
	switch action {
	case let action as SetSelectedTabAction:
		return action.payload
	default:
		return state
	}
}

func tabsReducer(action: Action, state: TabsState) -> TabsState {
	let state = state
	switch action {
	case let action as SetTabsAction:
		return TabsState(names: action.payload)
	case let action as AddTabAction:
		return TabsState(names: state.names + [action.name])
	case let action as EditNameAction:
		let names = MathUtils.getReplacedAt(a: state.names, index: action.index, element: action.newName)
		return TabsState(names: names)
	case let action as DeleteTabAction:
		return TabsState(names: MathUtils.getDeleted(a: state.names, val: action.key))
	default:
		return state
	}
}

func activeFileReducer (action: Action, state: ActiveFileState?) -> ActiveFileState {
	let state = state ?? ActiveFileState()
	switch action {
	case let action as OpenFileAction:
		var model:FileModel? = action.payload
		if(model == nil){
			model = Files.getBlank()
		}
		return ActiveFileState(active: model)
	default:
		return state
	}
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
			return state!
	}
}

func itemsReducer(action: Action, items: DragItemsState?) -> DragItemsState {
	var itemsCopy:DragItemsState = items!
	switch action {
		case let action as SetItemsAction:
			return action.payload
		case let action as AddFlowAction:
			itemsCopy[action.name] = FileMaker.getStuff(4)
			return itemsCopy
		case let action as DeleteFlowAction:
			return MathUtils.getDeletedByKey(a: itemsCopy, key: action.key)
		case let action as InsertItemAction:
			let index:Int = action.payload.index
			let dragModel = action.payload.model
			let newItem = DragItemModel(type: dragModel.type, content:dragModel.content, clr: dragModel.clr, imageSrc: "book.png")
			itemsCopy[action.payload.key] = MathUtils.getInsertedAt(a: items![action.payload.key]!, index: index, element: newItem)
			return itemsCopy
		case let action as UpdateItemAction:
			let edit:Edit = action.payload
			itemsCopy[action.payload.key] = MathUtils.getReplacedAt(a: items![action.payload.key]!, index: edit.index, element: edit.model)
			return itemsCopy
		case let action as DeleteItemAction:
			itemsCopy[action.key] = MathUtils.getDeletedAt(a: items![action.key]!, index: action.index)
			return itemsCopy
		default:
			return items!
	}
}

func filesReducer(action: Action, state: FileState?) -> FileState {
	switch action {
		case let action as SetFilesAction:
			return FileState(selected: state?.selected, files: action.payload)
		case let action as SetSelectedAction:
			return FileState(selected: action.payload, files: (state?.files)!)
		default:
			return state ?? FileState()
	}
}

