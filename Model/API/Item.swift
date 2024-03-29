import UIKit
struct Item: Codable {
	let id: String
	let title: String
	let subtitle: String
	let scientificName: String?
	private let description: String
	let images: [Image]
	let detailURL: String
	var attributedDescription: NSAttributedString {
		let html = "<meta charset=\"UTF-8\"><style>body{text-align: center; font-family: '-apple-system', 'HelveticaNeue'; font-size: \(UIFont.systemFontSize)px;}ul, ol{text-align: left;}</style>" + description
		return html.htmlToAttributedString ?? NSAttributedString(string: description)
	}
	var searchText: String {
		return title + ":" + subtitle + ":" + (scientificName ?? "")
	}
	struct Image: Codable {
		let id: String
		let url: String
		let thumbnailURL: String
		let fullSizeURL: String
		let size: Size
		let attribution: Attribution?
		struct Size: Codable {
			let width: Int
			let height: Int
		}
		struct Attribution: Codable {
			let value: String
			let url: String?
		}
	}
}
