
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
		let b:UIButton = UIButton(frame: CGRect(x: 10, y: 10, width: 150, height: 50));
		b.setTitle("Tab VC", for: .normal)
		self.view.addSubview(b)
		self.view.backgroundColor = .orange
		self.view.clipsToBounds = true
		self.view.layer.borderWidth = 2
		self.view.layer.borderColor = UIColor.black.cgColor
		self.updateContent(nil)
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
	
	private func remove(){
		var c:ConnectedController
		for i in 0..<self.content.count{
			c = self.content[i]
			hideContentController(container: self, content: c)
		}
		self.content = []
	}
	
	public func setSelected(_ index:Int){
		for i in 0..<self.content.count{
			//self.content[i].view.isHidden = (i != index)
		}
	}
	
	private func updateContent(_ state:DragItemsState?){
		//for (key, _) in state {
			let frame:CGRect = CGRect(x: 0, y: 0, width: 1000, height: 340)
			let c:ConnectedController = ConnectedController(key:"0")
			displayContentController(container: self, content: c, frame: frame)
			print("F", self.view.frame)
			self.content.append(c)
			//if(key != "0"){
				//c.view.isHidden = true
			//}
		//}
		//self.setSelected(0)
	}
	
	func newState(state: DragItemsState) {
		print("content", state)
		self.remove()
		self.updateContent(state)
	}

}

