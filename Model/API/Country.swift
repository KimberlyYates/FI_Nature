import Foundation
struct Country: Codable {
	let id: String
	let categoryCount: Int
	var localized: String {
		return Locale.current.localizedString(forRegionCode: id) ?? id
	}
}
