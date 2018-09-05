
import UIKit
import ReSwift

class ListController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	var gDel:UIGestureRecognizerDelegate
	var itemView:UIView = UIView(frame: CGRect(x: 50, y: 220, width: 60, height: 60))
	
	init(_gDel:UIGestureRecognizerDelegate){
		self.gDel = _gDel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		itemView.backgroundColor = .red
		self.view.addSubview(itemView)
		let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ListController.detectPan(_:)))
		self.view.addGestureRecognizer(panRecognizer)
	}
	
	@objc func detectPan(_ sender:UIPanGestureRecognizer) {
		print(sender.state)
		var translation:CGPoint  = sender.translation(in: self.view!)
		//self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
		print(translation)
		if(sender.state == .ended){
			print("done")
		}
	}
	
	func newState(state: AppState) {
		print("new state", state)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

