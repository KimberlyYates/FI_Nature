import Foundation
import MapKit
extension TopoMapsAPI {
	class func fetchTile(_ path: MKTileOverlayPath, mapTypeID: String,
						 completion: ((_ result: Data?, Error?) -> Void)?) {
		MapTileCache.fetchTile(path, mapTypeID: mapTypeID, completion: { data in
			if let data = data {
				completion?(data, nil)
			} else {
				if let url = URL(string: baseUrl(for: .v2) + "/Map/?mapType=" + mapTypeID + "&zoom=" + String(path.z) + "&x=" + String(path.x) + "&y=" + String(path.y) + "&app=nature") {
					makeRequest(url: url, method: "GET", completion: { data, error in
						completion?(data, error)
						DispatchQueue.global(qos: .background).async {
							if let data = data {
								MapTileCache.storeTile(data, path: path, mapTypeID: mapTypeID)
							}
						}
					})
				} else {
					completion?(nil, nil)
				}
			}
		})
	}
}
