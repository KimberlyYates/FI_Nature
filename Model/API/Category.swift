import UIKit
struct Category: Codable {
	let id: String
	let name: String
	let notice: String?
	let countryCode: String
	let imageName: String
	let hexColor: String
	let useLightText: Bool
	let itemCount: Int
	var image: UIImage? {
		return UIImage(named: "section." + imageName)
	}
	var color: UIColor {
		return UIColor(hex: hexColor)
	}
}
