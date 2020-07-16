import Firebase
import Foundation

class MLkitManager {
    static func detectLabels(img : UIImage, completeion : @escaping (VisionLabel) -> Void) {
        let img = VisionImage(image: img)
        let options = VisionOnDeviceImageLabelerOptions()
        options.confidenceThreshold = 0.5
        let labeler = Vision.vision().onDeviceImageLabeler(options: options)
        labeler.process(img) { labels, error in
            guard error == nil, let labels = labels else { return }
            for label in labels {
                let labelName = label.text
                guard let labelConfidence = label.confidence else { return }
                let labelConfFloat = labelConfidence.floatValue * 100
                let labelConfStr = "\(Int(labelConfFloat))%"
                let label = VisionLabel(name: labelName, confidence: labelConfStr)
                completeion(label)
            }
        }
    }
}
