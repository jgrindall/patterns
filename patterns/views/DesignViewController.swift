
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	private var drawingController:DrawingViewController
	private var textEntryController:TextEntryController
	private var connectedController:ConnectedController
	
	required init(){
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		self.connectedController = ConnectedController(frame:CGRect())
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayContentController(container: self, content: drawingController, frame: self.view.frame)
		displayContentController(container: self, content: textEntryController, frame: CGRect(x: 0, y: 0, width: 600, height: 400))
		displayContentController(container: self, content: connectedController, frame: CGRect(x: 0, y: self.view.frame.height/2.0, width: self.view.frame.width, height: self.view.frame.height/2.0))
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
		//print("newstate")
	}

}

