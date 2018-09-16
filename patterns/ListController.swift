
import UIKit
import ReSwift

class ListController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	var gDel:UIGestureRecognizerDelegate
	var centres:[CGPoint] = []
	var itemView0:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	var itemView1:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	var itemView2:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	var draggedView:UIView?
	var draggedIndex:Int = 0
	var _target:DragDropViewController?
	
	init(_gDel:UIGestureRecognizerDelegate){
		self.gDel = _gDel
		super.init(nibName: nil, bundle: nil)
		centres = [
			CGPoint(x:50.0, y:80.0),
			CGPoint(x:150.0, y:80.0),
			CGPoint(x:250.0, y:80.0)
		]
		itemView0.center = centres[0]
		itemView1.center = centres[1]
		itemView2.center = centres[2]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		itemView0.backgroundColor = .red
		itemView0.layer.cornerRadius = 30
		itemView1.backgroundColor = .green
		itemView1.layer.cornerRadius = 30
		itemView2.backgroundColor = .blue
		itemView2.layer.cornerRadius = 30
		self.view.addSubview(itemView0)
		self.view.addSubview(itemView1)
		self.view.addSubview(itemView2)
		let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ListController.detectPan(_:)))
		self.view.addGestureRecognizer(panRecognizer)
		self.view.backgroundColor = UIColor.purple
	}
	
	func reset(){
		draggedView!.center = centres[draggedIndex]
	}
	
	func setDragged(p:CGPoint){
		let d:UIView? = MathUtils.getViewContainingPoint(p: p, views: [itemView0, itemView1, itemView2])
		if d != nil {
			draggedView = d
		}
		else{
			draggedView = itemView0
		}
		draggedIndex = [itemView0, itemView1, itemView2].index(of: draggedView!)!
	}
	
	func getInsertIndex() -> Int{
		var px:Double = Double((draggedView?.center.x)!)
		var py:Double = Double((draggedView?.center.y)!)
		let f0:CGRect = self.view.frame
		let f1:CGRect = (_target?.view.frame)!
		px = px + (Double(f0.minX) - Double(f1.minX))
		py = py + (Double(f0.minY) - Double(f1.minY))
		return _target!.getIndexAt(x:px, y:py)
	}
	
	@objc func detectPan(_ sender:UIPanGestureRecognizer) {
		let translation:CGPoint  = sender.translation(in: self.view!)
		if(sender.state == .began){
			let p:CGPoint = sender.location(in: self.view)
			store.dispatch(SetDragStateAction(payload: .dragging))
			setDragged(p:p)
		}
		else if(sender.state == .changed){
			store.dispatch(SetPlaceholderAction(payload: getInsertIndex()))
			draggedView!.center = translation + centres[draggedIndex]
		}
		else if(sender.state == .ended){
			store.dispatch(SetDragStateAction(payload: .idle))
			store.dispatch(InsertItemAction(payload: getInsertIndex()))
			store.dispatch(SetPlaceholderAction(payload: -1))
			reset()
		}
	}
	
	func setTarget(target:DragDropViewController){
		self._target = target
	}
	
	func newState(state: AppState) {
		//print("new state", state)
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

