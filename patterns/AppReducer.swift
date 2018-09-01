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
		default:
			break
	}
	return state
}

