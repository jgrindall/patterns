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

struct SetDragStateAction:Action{
	let payload: DragStates
}

struct Edit{
	let index:Int
	let model:DragItemModel
}

struct UpdateItemAction:Action{
	let payload:Edit
}

struct DeleteItemAction:Action{
	let payload:Int
}

