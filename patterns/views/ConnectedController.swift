
import UIKit
import RSClipperWrapper
import ReSwift

protocol PDragDelegate{
	func onDragEnd(index:IndexPath, pos:CGPoint)
}

class ConnectedController: UIViewController, PDragDelegate, StoreSubscriber {
	
	private var dragController:DragDropViewController
	private var listController:ListController
	private var delButton:UIImageView = UIImageView(frame: CGRect())
	private var _key:String = ""
	
	required init(key:String){
		_key = key
		self.listController = ListController(key: _key)
		self.listController.view.backgroundColor = UIColor.purple
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 60, height: 60)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.dragController = DragDropViewController(collectionViewLayout: flowLayout, key:key, frame:CGRect(x: 0, y: 0, width: 1000, height: 200))
		super.init(nibName: nil, bundle: nil)
		self.delButton.image = UIImage(named: "del.png")
		self.view.addSubview(self.delButton)
		self.view.clipsToBounds = true
	}
	
	func onDragEnd(index:IndexPath, pos:CGPoint) {
		let delFrame:CGRect = self.delButton.frame
		if(delFrame.contains(pos)){
			store.dispatch(DeleteItemAction(payload: index.row))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		displayContentController(container:self, content: dragController)
		displayContentController(container:self, content: listController)
		self.listController.setTarget(target:self.dragController)
		self.dragController.dragDelegate = self
		super.viewDidLoad()
		self.view.clipsToBounds = true
		self.initLayout()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		//print("appear", self._key)
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.items[self._key]!
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func initLayout(){
		//LayoutUtils.bottomRight(v: delButton, parent: self.view, margin: 10, width: 60, height: 60)
		LayoutUtils.layoutToTop(v: dragController.view, parent: self.view, multiplier: 0.5)
		LayoutUtils.layoutToBottom(v: listController.view, parent: self.view, multiplier: 0.5)
	}
	
	public func setItems(state: DragItems){
		self.dragController.setData(items: state)
	}
	
	func newState(state: DragItems) {
		self.setItems(state: state)
	}
	
}
