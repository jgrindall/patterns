
import UIKit
import ReSwift

class ListController: UIViewController, StoreSubscriber {

	var centres:[CGPoint] = []
	var listItems:[ListItemModel] = []
	var views:[UIView] = []
	var draggedView:UIView? = nil
	var draggedIndex:Int = -1
	var _target:DragDropViewController? // to be a protocol
	
	init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ListController.detectPan(_:)))
		self.view.addGestureRecognizer(panRecognizer)
		self.view.backgroundColor = UIColor.purple
	}
	
	func reset(){
		if draggedView != nil {
			draggedView?.removeFromSuperview()
		}
		draggedView = nil
		draggedIndex = -1
	}
	
	func setDragged(p:CGPoint){
		let d:UIView? = MathUtils.getViewContainingPoint(p: p, views: self.views)
		if d != nil {
			draggedIndex = self.views.index(of: d!)!
			draggedView = self.makeView(model: self.listItems[draggedIndex], center: centres[draggedIndex])
			self.view.addSubview(draggedView!)
		}
		else{
			draggedIndex = -1
			draggedView = nil
		}
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
			setDragged(p:p)
		}
		else if(sender.state == .changed){
			draggedView!.center = translation + centres[draggedIndex]
			_target?.movePlaceholder(index: getInsertIndex())
		}
		else if(sender.state == .ended){
			_target?.movePlaceholder(index: -1)
			print("InsertItemAction", draggedIndex)
			store.dispatch(InsertItemAction(payload: getInsertIndex()))
			reset()
		}
	}
	
	func setTarget(target:DragDropViewController){
		self._target = target
	}
	
	func makeView(model:ListItemModel, center:CGPoint) -> UIView{
		let v:UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 60, height: 60))
		v.layer.cornerRadius = 30
		v.backgroundColor = model.clr
		v.center = center
		return v
	}
	
	func addChildren(){
		self.view.subviews.forEach({ $0.removeFromSuperview() })
		self.centres = []
		self.views = []
		var v:UIView
		var p:CGPoint
		for i in 0..<listItems.count{
			p = CGPoint(x:50.0 + Double(i)*70.0, y:80.0)
			centres.append(p)
			v = self.makeView(model: listItems[i], center: p)
			self.view.addSubview(v)
			views.append(v)
		}
	}
	
	func newState(state: ListItemsState) {
		listItems = state.items
		addChildren()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
			.select {
				$0.listItems
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

