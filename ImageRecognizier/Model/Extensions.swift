import Foundation
import UIKit
import Material

extension String {
    var localized: String {
          return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")

       }
    }

extension Float {
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

extension UIColor {
    static let navigationBarButtinColor: UIColor = UIColor(named: "NavigationButtonColor")!
    static let ResultGraphBarColor: UIColor = UIColor(named: "ResultGraphBarColor")!
    static let ResultNameColor: UIColor = UIColor(named: "ResultNameColor")!
    static let ResultConfColor: UIColor = UIColor(named: "ResultConfColor")!
    static let InfromLabelTextColor: UIColor = UIColor(named: "InfromLabelTextColor")!
    static let BlackBackgroundColor: UIColor = UIColor(named: "BlackBackgroundColor")!
}

extension UIImage {
    static let photoCameraButtonImage = Icon.icon("ic_photo_camera_white")
    static let downloadButtonImage = Icon.icon("ic_arrow_downward_white")
    static let analayzeButtonImage = Icon.icon("ic_search_white")
    static let resultShareButtomImage = Icon.icon("cm_share_white")

}
