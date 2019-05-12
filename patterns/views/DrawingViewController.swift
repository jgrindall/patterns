
import UIKit
import ReSwift

class DrawingViewController: UIViewController {

	private var panGesture = UIPanGestureRecognizer()
	private var tapGesture = UITapGestureRecognizer()
	private var geom:Geom = Geom()
	private var drawingView:DrawingView = DrawingView(frame: CGRect())
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var blobViews:[BlobView] = []
	private var blobConstraints:[[NSLayoutConstraint]] = []
	private var draggedBlob:BlobView? = nil
	private var draggedIndex:Int = -1
	private var polygons:Polygons = []
	
	private lazy var state1Subscriber: BlockSubscriber<CodeState> = BlockSubscriber(block: {state in
		self.newState(state: state)
	})

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
		setupC(children: [drawingView], constraints: [drawingConstraints], parent: self.view)
	}
	
	@objc func someAction(_ sender:UITapGestureRecognizer){
		print("TAP")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.polygons = store.state.items
		self.play()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self.state1Subscriber) { state in
			state.select { state in state.codeState }
				.skipRepeats({(lhs:CodeState, rhs:CodeState) -> Bool in
					return lhs == rhs
				})
		}
	}
	
	func newState(state: CodeState) {
		if(state == .started){
			self.polygons = store.state.items
			self.play()
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				store.dispatch(SetCodeStateAction(payload: CodeState.stopped))
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self.state1Subscriber)
	}
	
	private func play(){
		geom.setPolygons(self.polygons).update()
		let allPolygons = geom.getPolygons()
		self.drawingView.setPolygons(allPolygons).update()
		self.updateBlobs(polygons)
	}
	
	private func removeBlobs(){
		for view in self.blobViews as [BlobView]{
			//let i = self.blobViews.index(of: view)
			view.removeFromSuperview()
			//self.view.removeConstraints(self.blobConstraints[i!])
		}
	}
	
	private func addBlob(_ p:CGPoint){
		let b = BlobView(frame: CGRect(x: p.x, y: p.y, width: 25.0, height: 25.0))
		self.view.addSubview(b)
		//let cs:[NSLayoutConstraint]  = LayoutUtils.absolute(v: b, parent: self.view, rect: CGRect(x: p.x, y: p.y, width: 25.0, height: 25.0))
		//self.blobConstraints.append(cs)
		//self.view.addConstraints(cs)
		self.blobViews.append(b)
	}
	
	private func updateBlobs(_ polygons:Polygons){
		self.removeBlobs()
		for p:Polygon in polygons{
			for pt:CGPoint in p{
				self.addBlob(pt)
			}
		}
	}
	
	private func updatePolygon(_ i:Int, _ j:Int, _ p:CGPoint){
		self.polygons[i][j] = p
	}
	
	@objc func draggedView(_ sender:UIPanGestureRecognizer){
		let pos:CGPoint = sender.location(in: self.view)
		if(sender.state == .began){
			self.draggedBlob = self.getBlob(pos)
			if(self.draggedBlob != nil){
				self.draggedIndex = self.blobViews.index(of: self.draggedBlob!)!
			}
			else{
				self.draggedIndex = -1
			}
		}
		else if(sender.state == .changed){
			if(self.draggedBlob != nil){
				self.draggedBlob?.frame = CGRect(x: pos.x, y: pos.y, width: 25.0, height: 25.0)
				self.updatePolygon(0, self.draggedIndex, pos)
				self.play()
			}
		}
		else if(sender.state == .ended){
			self.draggedBlob = nil
			// commit the change
		}
		self.view.setNeedsDisplay()
	}
	
	private func getBlob(_ p:CGPoint)->BlobView?{
		var dists = self.blobViews.map{
			return self.getDistBlobSqr(p, $0)
		}
		print(dists)
		let minIndex:Int = MathUtils.getMinIndex(dists)
		if(dists[minIndex] < 1000){
			return self.blobViews[minIndex]
		}
		return nil
	}
	
	private func getDistBlobSqr(_ p:CGPoint, _ b:UIView)->CGFloat{
		return (p.x - b.frame.minX)*(p.x - b.frame.minX) + (p.y - b.frame.minY)*(p.y - b.frame.minY)
	}

}
