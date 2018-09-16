
import UIKit
import ReSwift

class DrawingViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	var panGesture  = UIPanGestureRecognizer()
	var geom:Geom = Geom()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		self.view = DrawingView(frame: self.view.frame)
		panGesture = UIPanGestureRecognizer(target: self, action: #selector(DrawingViewController.draggedView(_:)))
		self.view.isUserInteractionEnabled = true
		self.view.addGestureRecognizer(panGesture)
	}
	
	func newState(state: AppState) {
		if(state.codeState == .started){
			geom.setText(_text: state.text)
			(self.view as! DrawingView).setPolygons(ps: geom.getPolygons())
			(self.view as! DrawingView).update()
			store.dispatch(StatusActionStopped())
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	@objc func draggedView(_ sender:UIPanGestureRecognizer){
		self.view.setNeedsDisplay()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

