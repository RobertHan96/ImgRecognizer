import Foundation
import UIKit
import Material
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

extension UIView {
    func captureScreenToImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image {
            rendererContext in layer.render(in: rendererContext.cgContext)
            }
        }
    }

extension UINavigationController {
    func setupNavigationViewUI(currentNavi : UINavigationController?) {
        let bar = currentNavi?.navigationBar
        bar!.setBackgroundImage(UIImage(), for: .default)
        bar!.shadowImage = UIImage()
        bar!.isTranslucent = true

        let backButton: UIBarButtonItem = UIBarButtonItem()
        backButton.title = "navigationVarBackButtonTitle".localized
        currentNavi?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }
