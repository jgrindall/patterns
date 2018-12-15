
import UIKit
import ReSwift

class FileCell: UICollectionViewCell {
	private var textView: UILabel = UILabel(frame: CGRect())
	private var textConstraints:[NSLayoutConstraint] = []
	
	private var tickView: UILabel = UILabel(frame: CGRect())
	private var tickConstraints:[NSLayoutConstraint] = []
	
	private var markerView:UIView = UIView(frame: CGRect())
	private var markerConstraints:[NSLayoutConstraint] = []
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: Constants.SIZE.FILE_CELL_WIDTH, height: Constants.SIZE.FILE_CELL_HEIGHT))
	}
	
	private func initLayout(){
		let PADDING_X:CGFloat = 5.0;
		let TEXT_HEIGHT:CGFloat = 40.0;
		self.textView.translatesAutoresizingMaskIntoConstraints = false
		self.textConstraints = LayoutUtils.layoutExact(v: self.textView, parent: self, x: PADDING_X + Constants.SIZE.FILE_MARKER_SIZE + PADDING_X, y: 5, width: 100, height: 40)
		NSLayoutConstraint.activate(self.textConstraints)
		self.tickView.translatesAutoresizingMaskIntoConstraints = false
		self.tickConstraints = LayoutUtils.layoutExact(v: tickView, parent: self, x: PADDING_X, y: (Constants.SIZE.FILE_CELL_HEIGHT - Constants.SIZE.FILE_MARKER_SIZE)/2, width: Constants.SIZE.FILE_MARKER_SIZE, height: Constants.SIZE.FILE_MARKER_SIZE)
		NSLayoutConstraint.activate(self.tickConstraints)
		self.markerView.translatesAutoresizingMaskIntoConstraints = false
		self.markerConstraints = LayoutUtils.layoutExact(v: markerView, parent: self, x: PADDING_X, y: (Constants.SIZE.FILE_CELL_HEIGHT - Constants.SIZE.FILE_MARKER_SIZE)/2, width: Constants.SIZE.FILE_MARKER_SIZE, height: Constants.SIZE.FILE_MARKER_SIZE)
		NSLayoutConstraint.activate(self.markerConstraints)
	}
	
	override var isSelected: Bool{
		didSet{
			//self.tickView.isHidden = !self.isSelected
		}
	}
	
	public func loadData(p:FileModel){
		self.textView.text = p.title
		let bgColor:UIColor = MathUtils.arrayToColor(p.bgColor)
		markerView.backgroundColor = bgColor
		tickView.font = UIFont(name: "Verdana", size: 24)
		let isLight = MathUtils.getGray(bgColor) > 0.65
		//tickView.textColor = isLight ? .black : .white
		markerView.layer.borderColor = isLight ? UIColor.black.cgColor : UIColor.clear.cgColor
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		tickView.isHidden = true
		self.contentView.addSubview(textView)
		self.contentView.addSubview(markerView)
		self.contentView.addSubview(tickView)
		markerView.layer.masksToBounds = true
		markerView.layer.cornerRadius = 4
		markerView.layer.borderWidth = 1
		tickView.textColor = .black
		tickView.text = "✓"
		textView.font = UIFont(name: "Verdana", size: 14)
		self.initLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
