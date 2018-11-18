
import UIKit
import ReSwift

class Manager: StoreSubscriber {
	
	required init(){
		store.subscribe(self) {
			$0
				.select {
					$0.activeFileState
			}
			.skipRepeats()
		}
	}
	
	func newState(state: ActiveFileState) {
		print("manager newstate", state)
		if(state.active != nil){
			let fileModel = state.active!
			store.dispatch(SetTabsAction(payload: fileModel.tabNames))
			store.dispatch(EditTextAction(payload: fileModel.title + " TITLE"))
			store.dispatch(SetItemsAction(payload: FileMaker.mapFileDataToItems(fileModel.data)))
			store.dispatch(SetSelectedTabAction(payload: 0))
		}
	}
	
}

