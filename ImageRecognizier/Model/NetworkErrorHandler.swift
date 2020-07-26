import Network
import UIKit


class NetworkErrorHandler {
    var checkNetworkConetion : NWPathMonitor
    var networkQueue : DispatchQueue

    init(mornitor : NWPathMonitor, queue : DispatchQueue){
        self.checkNetworkConetion = mornitor
        self.networkQueue = queue
    }
    
    func cehckNetworkConect() -> Bool {
        var networkConection : Bool = true
        checkNetworkConetion.start(queue: networkQueue)
        checkNetworkConetion.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("[Log] connected with internet")
            } else {
                networkConection = false
            }
        }
        return networkConection
    }

    func popupError(currentView : UIViewController) {
        let storyBoard = UIStoryboard.init(name: "NetwrokWaringPopup", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "netwrokWaring")
        popupVC.modalPresentationStyle = .overCurrentContext
        DispatchQueue.main.async {
            currentView.present(popupVC, animated: true, completion: nil)
        }
    }

}
