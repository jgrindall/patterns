
import UIKit
import ReSwift

class TabContentController: UIViewController, StoreSubscriber {
	
	private var content:[ConnectedController] = []
	
	required init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .orange
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.items
			}
			.skipRepeats({ (lhs:DragItemsState, rhs:DragItemsState) -> Bool in
				return false
			})
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func updateContent(_ state:DragItemsState){
		var c:ConnectedController
		for i in 0..<content.count{
			c = self.content[i]
			hideContentController(container: self, content: c)
		}
		for (key, _) in state {
			c = ConnectedController(frame:CGRect(), key:key)
			displayContentController(container: self, content: c, frame: self.view.frame)
		}
	}
	
	func newState(state: DragItemsState) {
		print("content", state)
		self.updateContent(state)
	}

}

