import Network
import UIKit

let emtpySearchKeywordWaing : String = "검색어를 입력해주세요."
let noResultSearchWaring : String = """
                                    검색결과가 없습니다.
                                    정확한 곡/아티스트명을 입력하세요.
                                    """
let whileDBisChangingError : String = "랭킹DB 갱신 중, 잠시 후 재접속해주세요."
let whileDBisfetchingError : String = "랭킹정보 불러오는 중"
let checkNetworkConetion = NWPathMonitor()
let networkQueue = DispatchQueue.global(qos: .background)

// Firebase DB에서 랭킹 갱신 중일때 토스트메시지 안내를 위한 함수
// 네트워크 연결 여부를 판단하는 함수 Bool값 반환
func cehckNetworkConect() -> Bool {
    var networkConection : Bool = true
    checkNetworkConetion.start(queue: networkQueue)
    checkNetworkConetion.pathUpdateHandler = { path in
        if path.status == .unsatisfied {
            networkConection = false
        }
    }
    return networkConection
}
// 네트워크 미연결시 에러 안내 팝업으로 이동시키는 함수
func popupError(currentView : UIViewController) {
    let storyBoard = UIStoryboard.init(name: "NetwrokWaringPopup", bundle: nil)
    let popupVC = storyBoard.instantiateViewController(withIdentifier: "netwrokWaring")
    popupVC.modalPresentationStyle = .overCurrentContext
    currentView.present(popupVC, animated: true, completion: nil)
}
