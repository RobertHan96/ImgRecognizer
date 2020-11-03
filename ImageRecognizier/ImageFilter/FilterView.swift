import UIKit

extension FilterVC {
    func setupUI() {
        self.navigationController?.title = "필터 선택"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(playTapped))
        self.navigationItem.rightBarButtonItems = [add, play]
        filterPreviewCollectionView.delegate = self
        setupFlowLayout()
        filterPreviewCollectionView.dataSource = self
        filterPreviewCollectionView.register(UINib(nibName: "FilterPreviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "filterPreViewCell")
    }
    
    private func setupFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        
        let halfWidth = UIScreen.main.bounds.width / 5
        flowLayout.itemSize = CGSize(width: halfWidth * 0.9 , height: halfWidth * 0.9)
        self.filterPreviewCollectionView.collectionViewLayout = flowLayout
    }

}
