import UIKit
import Material

extension FilterVC {
    func setupUI() {
        self.navigationController?.setupNavigationViewUI(currentNavi: self.navigationController)
        let btnDowloadImage = Icon.icon("ic_arrow_downward_white")
        let dowloadImage = UIBarButtonItem(image: btnDowloadImage, style: .plain, target: self, action: #selector(dowloadImg))
        let btnImageAnalayze = Icon.icon("ic_search_white")
        let analayzeImage = UIBarButtonItem(image: btnImageAnalayze, style: .plain, target: self, action: #selector(analayzeImg))
        self.navigationItem.rightBarButtonItems = [dowloadImage, analayzeImage]
        
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
