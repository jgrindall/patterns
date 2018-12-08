
import UIKit
import RSClipperWrapper
import ReSwift

protocol PDragDelegate{
	func onDragEnd(index:IndexPath, pos:CGPoint)
}

class ConnectedController: UIViewController, PDragDelegate, StoreSubscriber {
	
	private var dragController:DragDropViewController
	private var dragConstraints:[NSLayoutConstraint] = []
	private var listController:ListController
	private var listConstraints:[NSLayoutConstraint] = []
	private var delButton:UIButton = UIButton(frame: CGRect())
	private var delConstraints:[NSLayoutConstraint] = []
	private var _key:String = ""
	private var label:UILabel = UILabel(frame: CGRect(x: 900, y: 50, width: 100, height: 40))
	private var labelConstraints:[NSLayoutConstraint] = []
	
	required init(key:String){
		_key = key
		self.listController = ListController(key: _key)
		self.listController.view.backgroundColor = UIColor.purple
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 60, height: 60)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.dragController = DragDropViewController(collectionViewLayout: flowLayout, key:key)
		super.init(nibName: nil, bundle: nil)
		self.delButton.setImage(UIImage(named: "del.png"), for: UIControlState.normal)
		delButton.addTarget(self, action: #selector(ConnectedController.delButtonClicked(_:)), for: .touchUpInside)
		self.view.clipsToBounds = true
		self.view.backgroundColor = UIColor(red: 0.8, green: 0.1, blue: 0.1, alpha: 0.2)
		label.text = "KEY " + key
	}
	
	private func removeTab(){
		if(store.state.tabs.names.count == 1){
			print("nope")
		}
		else{
			let newTabIndex = (store.state.selectedTabState == 0 ? 1 : 0)
			store.dispatch(SetSelectedTabAction(payload: newTabIndex))
			store.dispatch(DeleteTabAction(key:_key))
			store.dispatch(DeleteFlowAction(key:_key))
		}
	}
	
	@objc func delButtonClicked(_ sender: AnyObject?){
		print("del")
		let refreshAlert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
		refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
			self.removeTab()
		}))
		refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
			
		}))
		let titleFont = [NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter-Bold", size: 28.0)!]
		let messageFont = [NSAttributedStringKey.font: UIFont(name: "Avenir-Roman", size: 12.0)!]
		let titleAttrString = NSMutableAttributedString(string: "Title Here", attributes: titleFont)
		let messageAttrString = NSMutableAttributedString(string: "Message Here", attributes: messageFont)
		refreshAlert.setValue(titleAttrString, forKey: "attributedTitle")
		refreshAlert.setValue(messageAttrString, forKey: "attributedMessage")
		refreshAlert.view.tintColor = UIColor.red
		refreshAlert.view.backgroundColor = Constants.COLORS.BG_COLOR
		refreshAlert.view.layer.cornerRadius = 0
		let subview = (refreshAlert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
		subview.layer.cornerRadius = 0
		subview.backgroundColor = Constants.COLORS.BG_COLOR
		present(refreshAlert, animated: true, completion: nil)
	}
	
	func onDragEnd(index:IndexPath, pos:CGPoint) {
		let delFrame:CGRect = self.delButton.frame
		if(delFrame.contains(pos)){
			store.dispatch(DeleteItemAction(key:_key, index: index.row))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		displayContentController(container:self, content: dragController)
		displayContentController(container:self, content: listController)
		self.view.addSubview(self.delButton)
		self.view.addSubview(self.label)
		self.listController.setTarget(target:self.dragController)
		self.dragController.dragDelegate = self
		super.viewDidLoad()
		self.view.clipsToBounds = true
		self.initLayout()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		print("appear", self._key)
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.items[self._key]
			}
			.skipRepeats({ (lhs:DragItems?, rhs:DragItems?) -> Bool in
				if(lhs == nil || rhs == nil){
					return false
				}
				return lhs! == rhs!
			})
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func initLayout(){
		self.dragController.view.translatesAutoresizingMaskIntoConstraints = false
		self.dragConstraints = LayoutUtils.layoutToTop(v: dragController.view, parent: self.view, multiplier: 0.5)
		NSLayoutConstraint.activate(self.dragConstraints)
		
		self.listController.view.translatesAutoresizingMaskIntoConstraints = false
		self.listConstraints = LayoutUtils.layoutToBottom(v: listController.view, parent: self.view, multiplier: 0.5)
		NSLayoutConstraint.activate(self.listConstraints)
		
		self.delButton.translatesAutoresizingMaskIntoConstraints = false
		self.delConstraints = LayoutUtils.centreRight(v: delButton, parent: self.view, margin: 10, width: 50, height: 50)
		NSLayoutConstraint.activate(self.delConstraints)
		
		self.label.translatesAutoresizingMaskIntoConstraints = false
		self.labelConstraints = LayoutUtils.centreRight(v: label, parent: self.view, margin: 50, width: 150, height: 50)
		NSLayoutConstraint.activate(self.labelConstraints)
		
	}
	
	public func setItems(state: DragItems){
		self.dragController.setData(items: state)
	}
	
	func newState(state: DragItems?) {
		if let _state = state {
			self.setItems(state: _state)
		}
	}
	
}
