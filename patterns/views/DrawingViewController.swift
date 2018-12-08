
import UIKit
import ReSwift

class DrawingViewController: UIViewController, StoreSubscriber {
	
	private var panGesture = UIPanGestureRecognizer()
	private var tapGesture = UITapGestureRecognizer()
	private var geom:Geom = Geom()
	private var drawingView:DrawingView = DrawingView(frame: CGRect())
	private var drawingConstraints:[NSLayoutConstraint] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = Constants.COLORS.DARK_COLOR
		self.drawingView.backgroundColor = Constants.COLORS.DARK_COLOR
		panGesture = UIPanGestureRecognizer(target: self, action: #selector(DrawingViewController.draggedView(_:)))
		self.view.addSubview(self.drawingView)
		self.view.isUserInteractionEnabled = true
		self.view.addGestureRecognizer(panGesture)
		tapGesture = UITapGestureRecognizer(target: self, action:  #selector (DrawingViewController.someAction (_:)))
		self.view.addGestureRecognizer(tapGesture)
		self.initLayout()
	}
	
	func initLayout(){
		self.drawingConstraints = LayoutUtils.layoutFull(v: self.drawingView, parent: self.view)
		self.drawingView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate(drawingConstraints)
	}
	
	@objc func someAction(_ sender:UITapGestureRecognizer){
		print("TAP")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.codeState
			}
			.skipRepeats({(lhs:CodeState, rhs:CodeState) -> Bool in
				return lhs == rhs
			})
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func play(_ itemsState:DragItemsState){
		var commands:[String] = []
		for (_, items) in itemsState {
			for item in items{
				commands.append(item.type + " " + item.content)
			}
		}
		geom.setText(commands.joined(separator: " ")).update()
		self.drawingView.setPolygons(ps: geom.getPolygons()).update()
	}
	
	func newState(state: CodeState) {
		if(state == .started){
			self.play(store.state.items)
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				store.dispatch(SetCodeStateAction(payload: CodeState.stopped))
			}
		}
	}
	
	@objc func draggedView(_ sender:UIPanGestureRecognizer){
		self.view.setNeedsDisplay()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}
