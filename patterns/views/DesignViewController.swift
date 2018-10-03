
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	private var drawingController:DrawingViewController
	private var textEntryController:TextEntryController
	private var connectedController0:ConnectedController
	private var connectedController1:ConnectedController
	
	//private var tabbedController:TabbedController()
	
	required init(){
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		self.connectedController0 = ConnectedController(frame:CGRect(), key:"0")
		self.connectedController1 = ConnectedController(frame:CGRect(), key:"1")
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let h:CGFloat = self.view.frame.height/2.0;
		displayContentController(container: self, content: drawingController, frame: self.view.frame)
		displayContentController(container: self, content: textEntryController, frame: CGRect(x: 0, y: 0, width: 600, height: 400))
		displayContentController(container: self, content: connectedController0, frame: CGRect(x: 0, y: self.view.frame.height/2.0, width: self.view.frame.width, height: self.view.frame.height/2.0))
		displayContentController(container: self, content: connectedController1, frame: CGRect(x: 400, y: self.view.frame.height/2.0, width: self.view.frame.width, height: self.view.frame.height/2.0))
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

