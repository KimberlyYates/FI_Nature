import UIKit
class ItemsFlowLayout: UICollectionViewFlowLayout {
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
}
