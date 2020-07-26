import Foundation
import UIKit

extension String {
    var localized: String {
          return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")

       }
}

extension Float {
    // try ~ catch 문으로 변환 필요
    var makeConfPoint: String {return "\(String(format : "%.1f", self))%" }
    var makeConfToConts: CGFloat {return CGFloat(self*0.01) }

}
