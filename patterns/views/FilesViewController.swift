
import UIKit
import RSClipperWrapper
import ReSwift
import Disk

class FilesViewController: UIViewController, StoreSubscriber, PPageViewController {
	
	private var listController:FileListController
	private var detailController:DetailViewController
	private var openButton:UIButton = UIButton(frame:CGRect(x: 900, y: 700, width: 80, height: 40))
	private var newButton:UIButton = UIButton(frame:CGRect(x: 0, y: 700, width: 80, height: 40))
	
	required init(){
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 120, height: 40)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.listController = FileListController(collectionViewLayout: flowLayout)
		self.detailController = DetailViewController()
		super.init(nibName: nil, bundle: nil)
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
		displayContentController(container: self, content: listController, frame: CGRect(x: 0, y: 0, width: 150, height: 900))
		displayContentController(container: self, content: detailController, frame: CGRect(x: 200, y: 0, width: 800, height: 800))
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
		print("newstate", state)
		self.listController.update(items:state.files, selected:state.selected)
		if(state.selected != nil){
			self.detailController.loadFile(f: state.selected!)
		}
	}

}

