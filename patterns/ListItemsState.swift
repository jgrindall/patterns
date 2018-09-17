import ReSwift

struct ListItemsState: StateType {
	var items:[ListItemModel] = []
	func contains(_ item:ListItemModel) -> Bool{
		for i in 0..<items.count{
			if(items[i] == item){
				return true
			}
		}
		return false
	}
	func isSubsetOf(_ other:ListItemsState) -> Bool{
		for item:ListItemModel in items{
			if(!other.contains(item)){
				return false
			}
		}
		return true
	}
}

extension ListItemsState: Equatable {}

func ==(lhs: ListItemsState, rhs: ListItemsState) -> Bool {
	if(lhs.items.count != rhs.items.count){
		return false
	}
	return lhs.isSubsetOf(rhs) && rhs.isSubsetOf(lhs)
}

