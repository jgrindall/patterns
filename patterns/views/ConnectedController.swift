
import UIKit
import RSClipperWrapper
import ReSwift

protocol PDragDelegate{
	func onDragEnd(index:IndexPath, pos:CGPoint)
}

class YViewC:UIViewController{
	
	required init(){
		super.init(nibName: nil, bundle: nil)
		self.view.backgroundColor = UIColor.yellow
		self.view.layer.borderWidth = 6
		self.view.layer.borderColor = UIColor.yellow.cgColor		
		let b:UIButton = UIButton(frame: CGRect(x: 10, y: 10, width: 150, height: 50))
		b.setTitle("222222", for: .normal)
		self.view.addSubview(b)
		self.view.clipsToBounds = true
		print(1,self.view.frame)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class ConnectedController: UIViewController, PDragDelegate {
	
	//private var dragController:DragDropViewController
	private var y:YViewC
	//private var listController:ListController
	private var delButton:UIImageView = UIImageView(frame: CGRect(x: 700, y: 100, width: 60, height: 60))
	private var _key:String = ""
	
	required init(key:String){
		_key = key
		//self.listController = ListController(key: _key)
		//self.listController.view.backgroundColor = UIColor.purple
		//let flowLayout = UICollectionViewFlowLayout()
		//flowLayout.itemSize = CGSize(width: 60, height: 60)
		//flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		//flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		//flowLayout.minimumInteritemSpacing = 0.0
		//self.dragController = DragDropViewController(collectionViewLayout: flowLayout, key:key, frame:CGRect(x: 0, y: 0, width: 1000, height: 200))
		self.y = YViewC()
		super.init(nibName: nil, bundle: nil)
		//self.delButton.image = UIImage(named: "del.png")
		//self.view.addSubview(self.delButton)
		self.view.clipsToBounds = true
		print(8, self.y.view.frame)
		Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
	}
	
	@objc func runTimedCode(){
		print(self.y.view.frame)
		let f:CGRect = self.y.view.frame
		//self.y.view.frame = CGRect(x: f.minX, y: f.minY, width: f.width, height: 200)
	}
	
	func onDragEnd(index:IndexPath, pos:CGPoint) {
		//let delFrame:CGRect = self.delButton.frame
		//if(delFrame.contains(pos)){
			//store.dispatch(DeleteItemAction(payload: index.row))
		//}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		
		//let h:CGFloat = 180
		//let w:CGFloat = self.view.frame.width
		print(4, self.y.view.frame)
		displayContentController(container: self, content: self.y, frame: CGRect(x: 20, y: 20, width: 500, height: 200))
		//displayContentController(container:self, content: dragController, frame: CGRect(x: 10, y: 0, width: 800, height: 170))
		//displayContentController(container:self, content: listController, frame: CGRect(x: 10, y: 200, width: 800, height: 100))
		//self.listController.setTarget(target:self.dragController)
		//self.dragController.dragDelegate = self
		super.viewDidLoad()
		
		self.view.layer.borderWidth = 18
		self.view.layer.borderColor = UIColor.blue.cgColor
		self.view.clipsToBounds = true
		print(5, self.y.view.frame)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//print("appear", self._key)
		print(61, self.y.view.frame)
		super.viewWillAppear(animated)
		print(62, self.y.view.frame)
		//store.subscribe(self) {
			//$0
				//.select {
					//$0.items[self._key]!
			//}
		//}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		//store.unsubscribe(self)
	}
	
	public func setItems(state: DragItems){
		//self.dragController.setData(items: state)
	}
	
	//func newState(state: DragItems) {
		//self.setItems(state: state)
	//}
	
}
