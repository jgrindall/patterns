import ReSwift

struct SetUIStateAction:Action{
	let payload: UIState
}

struct SetBgStateAction: Action {
	let payload: UIColor
}

struct SetFgStateAction: Action {
	let payload: UIColor
}

struct SetCodeStateAction: Action {
	let payload: CodeState
}

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
	let model:ListItemModel
	let index:Int
}

struct UpdateItemAction:Action{
	let payload:Edit
}

struct DeleteItemAction:Action{
	let key:String
	let index:Int
}

struct LoadFilesAction:Action{
	init() {
		let files:[FileModel] = Files.loadAll()
		print("files", files)
		store.dispatch(SetFilesAction(payload: files))
		if(files.count >= 1){
			store.dispatch(SetSelectedAction(payload: files[0]))
		}
	}
}

struct SetTabsAction:Action{
	let payload:[String]
}

struct SetSelectedTabAction:Action{
	let payload:Int
}

struct AddTabAction:Action{
	let name:String
}

struct DeleteTabAction:Action{
	let key:String
}

struct SetItemsAction:Action{
	let payload:DragItemsState
}

struct AddFlowAction:Action{
	let name:String
}

struct DeleteFlowAction:Action{
	let key:String
}

struct SetFilesAction:Action{
	let payload:[FileModel]
}

struct OpenFileAction:Action{
	let payload:FileModel?
}

struct SetSelectedAction:Action{
	let payload:FileModel
}

struct NavigateAction:Action{
	let payload:NavState
}

