
import UIKit
import RSClipperWrapper
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	private var drawingController:DrawingViewController
	private var textEntryController:TextEntryController
	
	required init?(frame: CGRect) {
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.displayContentController(content: drawingController)
		self.displayContentController(content: textEntryController)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: AppState) {
		print("newstate")
	}
	
	func displayContentController(content: UIViewController){
		addChildViewController(content)
		self.view.addSubview(content.view)
		content.didMove(toParentViewController: self)
	}
	
	func hideContentController(content: UIViewController) {
		content.willMove(toParentViewController: nil)
		content.view.removeFromSuperview()
		content.removeFromParentViewController()
	}


}

