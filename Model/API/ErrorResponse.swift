import Foundation
struct ErrorResponse: Decodable, Error {
	let status: String
	static let unknown = ErrorResponse(status: "UNKNOWN_STATE")
}
extension ErrorResponse: LocalizedError {
	public var errorDescription: String? {
		return ("api-error." + status).localized
	}
}
