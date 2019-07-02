import UIKit
class ClassifyResultCell: UICollectionViewCell {
	@IBOutlet var backgroundImageView: UIImageView!
	@IBOutlet var certaintyVisualEffectView: UIVisualEffectView!
	@IBOutlet var certaintyLabel: UILabel!
	@IBOutlet var nameVisualEffectView: UIVisualEffectView!
	@IBOutlet var nameLabel: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		certaintyVisualEffectView.layer.cornerRadius = 8
		certaintyVisualEffectView.clipsToBounds = true
	}
	func setup(item: Item, certainty: Double) {
		if let urlString = item.images.first?.thumbnailURL, let url = URL(string: urlString) {
			backgroundImageView.setImage(url: url)
		}
		certaintyLabel.text = String(format: "%.2f %%", certainty * 100)
		nameLabel.text = item.title
	}
}
