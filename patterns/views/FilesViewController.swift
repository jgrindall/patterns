
import UIKit
import RSClipperWrapper
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
		displayContentController(container: self, content: listController)
		displayContentController(container: self, content: detailController)
		openButton.setTitle("Open", for: .normal)
		openButton.addTarget(self, action: #selector(FilesViewController.openButtonClicked(_:)), for: .touchUpInside)
		openButton.backgroundColor = .green
		self.view.addSubview(openButton)
		newButton.setTitle("New", for: .normal)
		newButton.addTarget(self, action: #selector(FilesViewController.newButtonClicked(_:)), for: .touchUpInside)
		newButton.backgroundColor = .green
		self.view.addSubview(newButton)
		self.loadFiles()
		super.viewDidLoad()
		self.initLayout()
	}
	
	func initLayout(){
		self.listController.view.translatesAutoresizingMaskIntoConstraints = false
		self.listConstraints = LayoutUtils.layoutToLeftWithWidth(v: self.listController.view, parent: self.view, width: Constants.SIZE.FILES_WIDTH)
		NSLayoutConstraint.activate(self.listConstraints)
		
		self.detailController.view.translatesAutoresizingMaskIntoConstraints = false
		self.detailConstraints = LayoutUtils.layoutToRightWithMargin(v: self.detailController.view, parent: self.view, margin:Constants.SIZE.FILES_WIDTH)
		NSLayoutConstraint.activate(self.detailConstraints)
		
		self.newButton.translatesAutoresizingMaskIntoConstraints = false
		self.newConstraints = LayoutUtils.bottomLeft(v: self.newButton, parent: self.view, margin:10, width:120, height:60)
		NSLayoutConstraint.activate(self.newConstraints)
		
		self.openButton.translatesAutoresizingMaskIntoConstraints = false
		self.openConstraints = LayoutUtils.bottomRight(v: self.openButton, parent: self.view, margin:10, width:120, height:60)
		NSLayoutConstraint.activate(self.openConstraints)

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
		let file:FileModel = FileModel(userId: 123, id: 123, title: "title", body: "body body body body", imageSrc:"", data:[])
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

