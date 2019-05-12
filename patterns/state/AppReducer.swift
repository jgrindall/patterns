import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
	return AppState(
		activeFileState:activeFileReducer(action: action, state: state?.activeFileState),
		navigationState: navReducer(action: action, state: state?.navigationState),
		text: textReducer(action: action, state: state?.text),
		items: itemsReducer(action: action, items: state?.items),
		fileState:filesReducer(action: action, state: state?.fileState),
		codeState:codeReducer(action: action, state: state!.codeState),
		uiState:uiReducer(action: action, state: state!.uiState)
	)
}

func uiReducer(action: Action, state: UIState) -> UIState {
	let state = state
	switch action {
	case let action as SetUISymmStateAction:
		return UIState(tabs: action.payload == .show ? .hide : state.tabs, symm: action.payload)
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

func itemsReducer(action: Action, items: Polygons?) -> Polygons {
	switch action {
		case let action as SetItemsAction:
			return action.payload
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

