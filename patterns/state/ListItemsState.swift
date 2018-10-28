import ReSwift

class ListItemModel {
	public var type: String
	public var label:String
	public var clr:UIColor
	public var imageSrc: String
	init(type:String, clr:UIColor, label: String, imageSrc: String) {
		self.type = type
		self.clr = clr
		self.label = label
		self.imageSrc = imageSrc
	}
}

extension ListItemModel: Equatable {}

func ==(lhs: ListItemModel, rhs: ListItemModel) -> Bool {
	return (lhs.type == rhs.type && lhs.label == rhs.label && lhs.imageSrc == rhs.imageSrc && lhs.clr == rhs.clr)
}

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

