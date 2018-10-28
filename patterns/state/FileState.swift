import ReSwift

struct FileState{
	var selected:FileModel? = nil
	var files:[FileModel] = []
}

struct ActiveFileState{
	var active:FileModel? = nil
}

extension ActiveFileState: Equatable {}

func ==(lhs: ActiveFileState, rhs: ActiveFileState) -> Bool {
	if (lhs.active == nil && rhs.active != nil){
		return false
	}
	else if (lhs.active != nil && rhs.active == nil){
		return false
	}
	else if (lhs.active == nil && rhs.active == nil){
		return true
	}
	else {
		return lhs.active! == rhs.active!
	}
}






