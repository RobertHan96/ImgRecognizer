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
        currentNavi?.navigationBar.backgroundColor = Color.lime.accent1
            currentNavi?.navigationBar.shadowImage = UIImage()
            let backButton: UIBarButtonItem = UIBarButtonItem()
        backButton.title = "navigationVarBackButtonTitle".localized
            currentNavi?.navigationBar.topItem?.backBarButtonItem = backButton
            currentNavi?.navigationBar.topItem?.title = ""
        }
    }
