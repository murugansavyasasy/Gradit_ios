//
//  MenuTVCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 05/08/26.
//

import UIKit

@available(iOS 16.0, *)
class MenuTVCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var menuList: [menuApiDataDetails] = []
    var Pages:[[menuApiDataDetails]] = []
    var pageSize: Int = 12
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cv.register(UINib(nibName: "MenuPageCVCell", bundle: nil), forCellWithReuseIdentifier: "MenuPageCVCell")
        cv.delegate = self
        cv.dataSource = self
    }
    
    func configure(with data: [menuApiDataDetails]) {
        
        self.menuList = data
        
        Pages = stride(from: 0, to: menuList.count, by: pageSize).map{
            Array(menuList[$0..<min($0 + pageSize, menuList.count)])
        }
        
           pageControl.numberOfPages = Pages.count
           pageControl.currentPage = 0
           pageControl.hidesForSinglePage = true
        
        cv.reloadData()
    }
    
    
    @IBAction func pageChanged(_ sender: UIPageControl) {

        let indexPath = IndexPath(item: sender.currentPage, section: 0)

        cv.scrollToItem(at: indexPath,
                        at: .centeredHorizontally,
                        animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard scrollView == cv else { return }

        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = page
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = cv.dequeueReusableCell(withReuseIdentifier: "MenuPageCVCell", for: indexPath) as? MenuPageCVCell else{
            return UICollectionViewCell()
        }
        
        let menus = Pages[indexPath.item]
        cell.configure(with: menus)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = cv.frame.width
        
        return CGSize(width: width, height: cv.frame.height)
    }
    
}
