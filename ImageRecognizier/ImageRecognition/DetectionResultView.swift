import UIKit

class DetectionResultView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var firstResultLabel: UILabel!
    @IBOutlet weak var secondResultLabel: UILabel!
    @IBOutlet weak var firstConfLabel: UILabel!
    @IBOutlet weak var secondConfLabel: UILabel!
    @IBOutlet weak var firstConfGraphBar: UIView!
    @IBOutlet weak var secondConfGraphBar: UIView!
    @IBOutlet weak var firstConfGraphBarWidth: NSLayoutConstraint!
    @IBOutlet weak var secondConfGraphBarWidth: NSLayoutConstraint!
    
    
    
    override init(frame: CGRect) {
        super.init(frame : frame)
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder : aCoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DetectionResultView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
