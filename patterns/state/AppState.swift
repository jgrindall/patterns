import ReSwift

/*


public class BlockSubscriber<S>: StoreSubscriber {
public typealias StoreSubscriberStateType = S
private let block: (S) -> Void

public init(block: @escaping (S) -> Void) {
self.block = block
}

public func newState(state: S) {
self.block(state)
}
}
Then in your class, you can:

class Sample {
private lazy var state1Subscriber: BlockSubscriber<State1> = BlockSubscriber(block: { [unowned self], state1 in
self.something = state1
})
private lazy var state2Subscriber: BlockSubscriber<State2> = BlockSubscriber(block: { [unowned self], state2 in
self.something2 = state2
})
init() {
// MARK: Subscriber
appStore.subscribe(self.state1Subscriber) { state in
state.select { state in state.state1 }
}

appStore.subscribe(self.state2Subscriber) { state in
state.select { state in state.state2 }
}
}
}

*/

//https://github.com/ReSwift/ReSwift/issues/318

struct AppState: StateType {
	var activeFileState:ActiveFileState = ActiveFileState()
	var navigationState:NavState = .files
	var text:String = ""
	var tabs:TabsState = TabsState()
	var items:DragItemsState = [:]
	var fileState = FileState()
	var selectedTabState:Int = -1
	var codeState:CodeState = .stopped
	var uiState:UIState = .up
	var drawingConfigState = DrawingConfigState(bg: .red, fg: .green)
}

extension AppState: Equatable {
	static func == (lhs: AppState, rhs: AppState) -> Bool {
		return lhs.navigationState == rhs.navigationState
		&& lhs.text == rhs.text
		&& lhs.tabs == rhs.tabs
		&& lhs.items.keys == rhs.items.keys
		&& lhs.activeFileState == rhs.activeFileState
		&& lhs.selectedTabState == rhs.selectedTabState
		&& lhs.codeState == rhs.codeState
	}
}

