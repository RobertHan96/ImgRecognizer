import UIKit
import Material

extension FilterVC {
    func setupUI() {
        self.navigationController?.setupNavigationViewUI(currentNavi: self.navigationController)
        let dowloadImage = UIBarButtonItem(image: UIImage.downloadButtonImage, style: .plain, target: self, action: #selector(dowloadImg))
        let analayzeImage = UIBarButtonItem(image: UIImage.analayzeButtonImage, style: .plain, target: self, action: #selector(analayzeImg))
        self.navigationItem.rightBarButtonItems = [dowloadImage, analayzeImage]
        filterdImage.layer.borderWidth = 1
        filterdImage.layer.borderColor = UIColor.darkGray.cgColor
        filterdImage.layer.cornerRadius = 10
        
        filterPreviewCollectionView.borderColor = .InfromLabelTextColor
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
