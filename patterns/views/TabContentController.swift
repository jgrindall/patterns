
import UIKit
import ReSwift

class TabContentController: UIViewController, StoreSubscriber {
	
	private var content:[ConnectedController] = []
	private var contentConstraints:[ [NSLayoutConstraint] ] = []
	required init(){
		super.init(nibName: nil, bundle: nil)
		self.view.layer.borderWidth = 2
		self.view.layer.borderColor = UIColor.green.cgColor
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor(red: 0.7, green: 0.3, blue: 0.3, alpha: 0.5)
		self.view.clipsToBounds = true
	}
	
	private func initLayout(){
		self.removeLayout()
		for i in 0..<self.content.count{
			let constraints:[NSLayoutConstraint] = LayoutUtils.layoutFull(v: self.content[i].view, parent: self.view)
			self.contentConstraints.append(constraints)
			NSLayoutConstraint.activate(constraints)
		}
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
	
	private func removeLayout(){
		for i in 0..<self.contentConstraints.count{
			NSLayoutConstraint.deactivate(self.contentConstraints[i])
		}
		self.contentConstraints = []
	}
	
	private func removeContent(){
		for i in 0..<self.content.count{
			hideContentController(container: self, content: self.content[i])
		}
		self.content = []
	}
	
	public func setSelected(_ index:Int){
		for i in 0..<self.content.count{
			self.content[i].view.isHidden = (i != index)
		}
	}
	
	private func updateContent(_ state:DragItemsState){
		self.content = []
		self.contentConstraints = []
		for (key, _) in state {
			let c:ConnectedController = ConnectedController(key: key)
			c.view.translatesAutoresizingMaskIntoConstraints = false
			displayContentController(container: self, content: c)
			self.content.append(c)
			self.contentConstraints.append([])
		}
		self.setSelected(0)
	}
	
	func newState(state: DragItemsState) {
		self.removeContent()
		self.updateContent(state)
		self.initLayout()
	}

}

