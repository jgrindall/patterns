
import UIKit
import ReSwift

class ListController: UIViewController {

	private var centres:[CGPoint] = []
	private var listItems:[ListItemModel] = ListMaker.getStuff()
	private var views:[UIView] = []
	private var draggedView:UIView? = nil
	private var draggedIndex:Int = -1
	private var _target:DragDropViewController? // to be a protocol
	private var _key:String = ""
	
	init(key:String){
		_key = key
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ListController.detectPan(_:)))
		self.view.addGestureRecognizer(panRecognizer)
		self.view.backgroundColor = UIColor.clear
		self.addChildren()
		self.view.clipsToBounds = false
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
			setDragged(p:sender.location(in: self.view))
		}
		else if(sender.state == .changed){
			draggedView!.center = translation + centres[draggedIndex]
			_target?.movePlaceholder(index: getInsertIndex())
		}
		else if(sender.state == .ended){
			let dragModel:ListItemModel = self.listItems[self.draggedIndex]
			_target?.movePlaceholder(index: -1)
			store.dispatch(InsertItemAction(payload: Insert(key: _key, model:dragModel, index: getInsertIndex())))
			reset()
		}
	}
	
	func setTarget(target:DragDropViewController){
		self._target = target
	}
	
	func makeView(model:ListItemModel, center:CGPoint) -> UIView{
		let v:ListItemView = ListItemView(frame: CGRect(x: 0.0, y: 0.0, width: Constants.SIZE.DRAG_SIZE, height: Constants.SIZE.DRAG_SIZE), model:model)
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
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

}

