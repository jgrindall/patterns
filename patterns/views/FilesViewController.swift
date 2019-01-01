
import UIKit
import ReSwift
import Disk

class FilesViewController: UIViewController, StoreSubscriber, PPageViewController {
	
	private var listController:FileListController
	private var listConstraints:[NSLayoutConstraint] = []
	private var detailController:DetailViewController
	private var detailConstraints:[NSLayoutConstraint] = []
	private var openButton:UIButton = UIButton(frame:CGRect())
	private var openConstraints:[NSLayoutConstraint] = []
	private var newButton:UIButton = UIButton(frame:CGRect())
	private var newConstraints:[NSLayoutConstraint] = []
	
	private var newButtonImg:UIImageView = UIImageView(image: UIImage(named: "add.png"))
	private var newButtonImgConstraints:[NSLayoutConstraint] = []
	private var openButtonImg:UIImageView = UIImageView(image: UIImage(named: "tick2.png"))
	private var openButtonImgConstraints:[NSLayoutConstraint] = []
	
	required init(){
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: Constants.SIZE.FILE_CELL_WIDTH, height: Constants.SIZE.FILE_CELL_HEIGHT)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.listController = FileListController(collectionViewLayout: flowLayout)
		self.detailController = DetailViewController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Choose a file"
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	public func getName() -> String {
		return "files"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func loadFiles(){
		store.dispatch(LoadFilesAction())
	}
	
	override func viewDidLoad() {
		displayContentController(container: self, content: detailController)
		displayContentController(container: self, content: listController)
		openButton.addTarget(self, action: #selector(FilesViewController.openButtonClicked(_:)), for: .touchUpInside)
		newButton.addTarget(self, action: #selector(FilesViewController.newButtonClicked(_:)), for: .touchUpInside)
		
		newButton.layer.masksToBounds = true
		newButton.backgroundColor = .white
		newButton.layer.cornerRadius = Constants.SIZE.BUTTON_HEIGHT/2
		newButton.layer.borderWidth = 3
		newButton.layer.borderColor = UIColor.gray.cgColor
		newButtonImg.isUserInteractionEnabled = false
		newButton.addSubview(newButtonImg)
		
		openButton.layer.masksToBounds = true
		openButton.backgroundColor = .white
		openButton.layer.cornerRadius = Constants.SIZE.BUTTON_HEIGHT/2
		openButton.layer.borderWidth = 3
		openButton.layer.borderColor = UIColor.gray.cgColor
		openButtonImg.isUserInteractionEnabled = false
		openButton.addSubview(openButtonImg)
		
		self.view.addSubview(openButton)
		self.view.addSubview(newButton)
		self.loadFiles()
		super.viewDidLoad()
		self.initLayout()
	}
	
	func initLayout(){
		self.listConstraints = LayoutUtils.layoutToLeftWithWidthAndTopMargin(v: self.listController.view, parent: self.view, width: Constants.SIZE.FILES_WIDTH, topMargin: self.navigationController!.navigationBar.frame.size.height)
		self.detailConstraints = LayoutUtils.layoutFull(v: self.detailController.view, parent: self.view)
		self.newConstraints = LayoutUtils.bottomLeftWithMargins(v: self.newButton, parent: self.view, marginBottom:10, width:Constants.SIZE.BUTTON_HEIGHT, height:Constants.SIZE.BUTTON_HEIGHT, marginLeft: Constants.SIZE.FILES_WIDTH - Constants.SIZE.BUTTON_HEIGHT - 10)
		self.openConstraints = LayoutUtils.bottomRight(v: self.openButton, parent: self.view, margin:10, width:Constants.SIZE.BUTTON_HEIGHT, height:Constants.SIZE.BUTTON_HEIGHT)
		setupC(
			children: [
				listController.view,
				detailController.view,
				newButton,
				openButton
			],
			constraints: [
				listConstraints,
				detailConstraints,
				newConstraints,
				openConstraints
			],
			parent: self.view
		)
		self.newButtonImgConstraints = LayoutUtils.layoutFull(v: newButtonImg, parent: newButton)
		self.openButtonImgConstraints = LayoutUtils.layoutFull(v: openButtonImg, parent: openButton)
		setupC(
			children: [
				newButtonImg
			],
			constraints: [
				newButtonImgConstraints
			],
			parent: newButton
		)
		setupC(
			children: [
				openButtonImg
			],
			constraints: [
				openButtonImgConstraints
			],
			parent: openButton
		)
	}

	private func open(_ file:FileModel?){
		store.dispatch(OpenFileAction(payload: file))
		store.dispatch(NavigateAction(payload: .design))
	}
	
	@objc func newButtonClicked(_ sender: AnyObject?){
		self.open(nil)
	}
	
	@objc func openButtonClicked(_ sender: AnyObject?){
		let file:FileModel? = store.state.fileState.selected
		if (file != nil){
			self.open(file)
		}
	}
	
	func save(){
		let file:FileModel = FileModel(userId: 123, id: 123, title: "title", body: "body body body body", imageSrc:"", data:[], bgColor:[200,100,200], fgColor:[250,250,250])
		_ = Files.save(name: "name34", fileModel: file)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.fileState
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: FileState) {
		self.listController.update(items:state.files, selected:state.selected)
		if(state.selected != nil){
			self.detailController.loadFile(f: state.selected!)
		}
	}

}

