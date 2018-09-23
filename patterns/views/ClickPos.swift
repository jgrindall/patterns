
import UIKit
import ReSwift

struct ClickPos{
	var pos:CGPoint
	var time:TimeInterval
	func isCloseTo(clickPos:ClickPos) -> Bool {
		let p0 = clickPos.pos
		let p1 = self.pos
		let dx = p0.x - p1.x
		let dy = p0.y - p1.y
		let dt = clickPos.time - self.time
		return (abs(dx) < 10 && abs(dy) < 10 && abs(dt) < 500)
	}
}
