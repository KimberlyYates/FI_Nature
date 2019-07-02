import CoreLocation
extension CLLocationManager {
	var isAuthorized: Bool {
		let status = CLLocationManager.authorizationStatus()
		return status == .authorizedAlways || status == .authorizedWhenInUse
	}
}
