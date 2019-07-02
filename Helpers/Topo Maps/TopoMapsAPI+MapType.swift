import Foundation
extension TopoMapsAPI {
	class func fetchMapTypes(completion: @escaping (_ result: [MapType]?, Error?) -> Void) {
		guard let url = URL(string: baseUrl(for: .v1) + "/GetMapType/?app=nature") else {
			completion(nil, nil)
			return
		}
		get(url, type: [MapType].self, completion: completion)
	}
}
