import ReSwift

struct TabsState {
	var names:[String] = []
}

extension TabsState: Equatable {}

func ==(lhs: TabsState, rhs: TabsState) -> Bool {
	return (lhs.names == rhs.names)
}





