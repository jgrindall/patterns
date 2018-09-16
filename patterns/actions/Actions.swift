import ReSwift

struct StatusActionStart: Action {}
struct StatusActionStopping: Action {}
struct StatusActionStopped: Action {}

struct EditTextAction: Action {
	let payload: String
}

struct InsertItemAction:Action {
	let payload: Int
}

struct SetPlaceholderAction:Action {
	let payload: Int
}

struct SetDragStateAction:Action{
	let payload: DragStates
}

