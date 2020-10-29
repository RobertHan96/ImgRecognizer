import UIKit

extension FilterVC {
    func setupUI() {
        self.navigationController?.title = "필터 선택"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        self.navigationItem.rightBarButtonItems = [add, play]
        
        filterdImage.image = AppDelegate().originImage?.image
        filterPreviewCollectionView.delegate = self
        filterPreviewCollectionView.dataSource = self
        filterPreviewCollectionView.register(UINib(nibName: "FilterPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterPreViewCell")

    }
    
    @objc func addTapped() {
        
    }
    
    @objc func playTapped() {
        
    }
}
