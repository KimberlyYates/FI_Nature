import UIKit
class ItemCell: UICollectionViewCell {
	@IBOutlet var backgroundImageView: UIImageView!
	@IBOutlet var dimmingView: UIView!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var subtitleLabel: UILabel!
	override func prepareForReuse() {
		super.prepareForReuse()
		backgroundImageView.cancelImageFetch()
		backgroundImageView.image = nil
	}
}
