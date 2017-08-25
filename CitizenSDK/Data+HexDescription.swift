import Foundation

extension Data {
    var hexDescription: String {
        return self.map { String(format: "%02hhx", $0) }.joined()
    }
}
