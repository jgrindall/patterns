
import UIKit
import ReSwift

class DrawingViewController: UIViewController, StoreSubscriber {
	
	private var panGesture = UIPanGestureRecognizer()
	private var tapGesture = UITapGestureRecognizer()
	private var geom:Geom = Geom()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		self.view = DrawingView(frame: self.view.frame)
		panGesture = UIPanGestureRecognizer(target: self, action: #selector(DrawingViewController.draggedView(_:)))
		self.view.isUserInteractionEnabled = true
		self.view.addGestureRecognizer(panGesture)
		tapGesture = UITapGestureRecognizer(target: self, action:  #selector (DrawingViewController.someAction (_:)))
		self.view.addGestureRecognizer(tapGesture)
	}
	
	@objc func someAction(_ sender:UITapGestureRecognizer){
		print("TAP")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.codeState
			}
			.skipRepeats({ (lhs:CodeState, rhs:CodeState) -> Bool in
				return lhs == rhs
			})
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: CodeState) {
		print("state", state, "--------")
		print(store.state.items)
	}
	
	@objc func draggedView(_ sender:UIPanGestureRecognizer){
		self.view.setNeedsDisplay()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
