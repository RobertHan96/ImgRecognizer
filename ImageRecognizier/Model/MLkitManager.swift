import Firebase
import Foundation

class MLkitManager {
    static func detectLabels(img : UIImage, completeion : @escaping ([VisionLabel]) -> Void) {
        let img = VisionImage(image: img)
        let cloudOptions = VisionCloudImageLabelerOptions()
        cloudOptions.confidenceThreshold = 0.5
        let labeler = Vision.vision().cloudImageLabeler(options: cloudOptions)
        labeler.process(img) { labels, error in
            guard error == nil, let labels = labels else { return }
            var resultLabels : [VisionLabel] = []
            for label in labels {
                let labelName = label.text
                guard let labelConfidence = label.confidence else { return }
                let labelConfFloat = labelConfidence.floatValue * 100
//                let labelConfStr = "\(Int(labelConfFloat))%"
                let label = VisionLabel(name: labelName, confidence: labelConfFloat)
                resultLabels.append(label)
            }
            completeion(resultLabels)
        }
    }
    
    static func detectLandmarks(img : UIImage, completeion : @escaping ([VisionLabel]) -> Void) {
        let img = VisionImage(image: img)
        let cloudOptions = VisionCloudDetectorOptions()
        cloudOptions.modelType = .latest
        cloudOptions.maxResults = 20
        var  vision = Vision.vision()
        let cloudDetector = vision.cloudLandmarkDetector(options: cloudOptions)
        
        cloudDetector.detect(in: img) { (landmarks, error) in
            guard error == nil, let landmarks = landmarks, !landmarks.isEmpty else {
              return
            }
            var resultRandmarks : [VisionLabel] = []
            for landmark in landmarks {
                guard let name = landmark.landmark else {return}
//              let boundingPoly = landmark.frame
//              let entityId = landmark.entityId
                guard let confidence = landmark.confidence else {return}
                let landmarkConfFloat = confidence.floatValue * 100
//                let landmarkConfStr = "\(Int(landmarkConfFloat))%"
                resultRandmarks.append(VisionLabel(name: name, confidence: landmarkConfFloat))
            }
            completeion(resultRandmarks)
        }
        
        
    }
    
}
