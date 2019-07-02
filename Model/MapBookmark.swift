import MapKit
class MapBookmark: NSObject, MKAnnotation, Codable, Comparable {
	var title: String?
	var subtitle: String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .medium
		let string = dateFormatter.string(from: creationDate)
		return string
	}
	var coordinate: CLLocationCoordinate2D
	var creationDate: Date
	var id: String
	init(title: String, coordinate: CLLocationCoordinate2D) {
		self.title = title
		self.coordinate = coordinate
		self.creationDate = Date()
		self.id = UUID().uuidString
	}
	static func < (lhs: MapBookmark, rhs: MapBookmark) -> Bool {
		return lhs.creationDate < rhs.creationDate
	}
	static func == (lhs: MapBookmark, rhs: MapBookmark) -> Bool {
		return lhs.id == rhs.id
	}
}
