import ReSwift

struct StatusActionStart: Action {}
struct StatusActionStopping: Action {}
struct StatusActionStopped: Action {}

struct EditTextAction: Action {
	let payload: String
}

struct InsertItemAction:Action {
	let payload: Insert
}

struct Edit{
	let index:Int
	let model:DragItemModel
	let key:String
}

struct Insert{
	let key:String
	let index:Int
}

struct UpdateItemAction:Action{
	let payload:Edit
}

struct DeleteItemAction:Action{
	let payload:Int
}

struct LoadFilesAction:Action{
	init() {
		let files:[FileModel] = Files.loadAll()
		store.dispatch(SetFilesAction(payload: files))
		if(files.count >= 1){
			store.dispatch(SetSelectedAction(payload: files[0]))
		}
	}
}

struct SetFilesAction:Action{
	let payload:[FileModel]
}

struct SetSelectedAction:Action{
	let payload:FileModel
}

struct NavigateAction:Action{
	let payload:NavState
}

