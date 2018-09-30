
import UIKit
import ReSwift

class DetailViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	private var imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.loadFile(f:FileModel(userId: 1, id: 1, title: "T", body: "body body"))
		self.view.backgroundColor = UIColor.red
	}
	
	func newState(state: AppState) {
		
	}
	
	func loadFile(f:FileModel){
		self.imgView.image = UIImage(named: "pat.jpg")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.view.addSubview(imgView)
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

