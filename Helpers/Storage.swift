import Foundation
public class Storage {
	enum Directory {
		case documents
		case caches
	}
	static fileprivate func getURL(for directory: Directory) -> URL? {
		var searchPathDirectory: FileManager.SearchPathDirectory
		switch directory {
		case .documents:
			searchPathDirectory = .documentDirectory
		case .caches:
			searchPathDirectory = .cachesDirectory
		}
		return FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first
	}
	static func store<T: Encodable>(_ object: T, to directory: Directory, as fileName: String) {
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(object)
			store(data: data, to: directory, as: fileName)
		} catch {
			print(error)
		}
	}
	private static func store(data: Data, to directory: Directory, as fileName: String) {
		guard let url = getURL(for: directory)?.appendingPathComponent(fileName, isDirectory: false) else {
			print("Can't store data to \(directory) as \(fileName), the url is nil")
			return
		}
		if FileManager.default.fileExists(atPath: url.path) {
			try? FileManager.default.removeItem(at: url)
		}
		FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
	}
	private static func retrieve(_ fileName: String, from directory: Directory) -> Data? {
		guard let url = getURL(for: directory)?.appendingPathComponent(fileName, isDirectory: false) else {
			print("Can't retrieve \(fileName) from \(directory), the url is nil")
			return nil
		}
		if !FileManager.default.fileExists(atPath: url.path) {
			print("Can't retrieve \(fileName) from \(directory), the file does not exist")
			return nil
		}
		return FileManager.default.contents(atPath: url.path)
	}
	static func retrieve<T: Decodable>(_ fileName: String, from directory: Directory, as type: T.Type) -> T? {
		if let data = retrieve(fileName, from: directory) {
			let decoder = JSONDecoder()
			do {
				let model = try decoder.decode(type, from: data)
				return model
			} catch {
				print(error)
				return nil
			}
		}
		return nil
	}
	static func clear(_ directory: Directory) {
		guard let url = getURL(for: directory) else {
			return
		}
		do {
			let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
			for fileUrl in contents {
				try FileManager.default.removeItem(at: fileUrl)
			}
		} catch {
			print(error)
		}
	}
	static func remove(_ fileName: String, from directory: Directory) {
		guard let url = getURL(for: directory)?.appendingPathComponent(fileName, isDirectory: false) else {
			print("Can't remove \(fileName) from \(directory), the url is nil")
			return
		}
		if FileManager.default.fileExists(atPath: url.path) {
			do {
				try FileManager.default.removeItem(at: url)
			} catch {
				print(error)
			}
		}
	}
	static func fileExists(_ fileName: String, in directory: Directory) -> Bool {
		guard let url = getURL(for: directory)?.appendingPathComponent(fileName, isDirectory: false) else {
			print("Can't check if \(fileName) exists in \(directory), the url is nil")
			return false
		}
		return FileManager.default.fileExists(atPath: url.path)
	}
}
