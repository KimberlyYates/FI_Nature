import Foundation
extension Sequence where Iterator.Element == (key: String, value: String) {
	var httpBody: String {
		var body = ""
		for (key, value) in self {
			body.append("&" + key + "=" + value)
		}
		return body
	}
}
public extension Sequence where Iterator.Element: Hashable {
	var uniqueElements: [Iterator.Element] {
		return Array( Set(self) )
	}
}
public extension Sequence where Iterator.Element: Equatable {
	var uniqueElements: [Iterator.Element] {
		return self.reduce([]){
			uniqueElements, element in
			uniqueElements.contains(element)
				? uniqueElements
				: uniqueElements + [element]
		}
	}
}
