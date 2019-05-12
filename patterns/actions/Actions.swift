import ReSwift

struct SetUISymmStateAction:Action{
	let payload: UITabState
}

struct SetCodeStateAction: Action {
	let payload: CodeState
}

struct EditTextAction: Action {
	let payload: String
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

struct SetItemsAction:Action{
	let payload:Polygons
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

