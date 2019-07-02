import Foundation
class TopoMapsAPI: API {
	class func baseUrl(for version: APIVersion) -> String {
		switch version {
		case .v1:
			return "https://eaststudios.net/api/TopoMaps"
		case .v2:
			return "https://eaststudios.net/api/TopoMapsV2"
		case .v3:
			return "https://eaststudios.net/topomaps/api"
		}
	}
	enum APIVersion {
		case v1
		case v2
		case v3
	}
}
