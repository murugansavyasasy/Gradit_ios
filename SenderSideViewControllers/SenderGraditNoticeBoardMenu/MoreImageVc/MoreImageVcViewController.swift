//
//  MoreImageVcViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 28/02/24.
//

import UIKit

class MoreImageVcViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var TopicLabel: UILabel!
    @IBOutlet weak var Cv: UICollectionView!
    
    var imageFile : [String]  = []
    var fileType : String!
    var TopicLbl : String!
    var menuIdentifier = "MoreImageCCCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        TopicLabel.text = TopicLbl
        Cv.dataSource = self
        Cv.delegate = self
        let menuRowNib = UINib(nibName: menuIdentifier, bundle: nil)
        Cv.register(menuRowNib, forCellWithReuseIdentifier: menuIdentifier)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageFile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MoreImageCCCollectionViewCell
        let image = imageFile[indexPath.row]
        let containsPDF = imageFile.contains { $0.contains(".pdf") }
        cell.pdfView.isHidden = !containsPDF
        cell.CellmageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "ic_white"))
        let imagee = MoreImageShow(target: self, action: #selector(ImageShowVc))
        imagee.imageUrls = imageFile[indexPath.row]
        cell.CellmageView.addGestureRecognizer(imagee)
        return cell
        
    }
    
    @IBAction func ImageShowVc( gesture :MoreImageShow ){
        let vc = MoreImageDownLoadViewController(nibName: nil, bundle: nil)
        vc.MoreimgfilePath = gesture.imageUrls
        vc.fileType = fileType
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionView = collectionView.bounds.width
        return CGSize(width: collectionView / 3 - 8, height: collectionView / 3 - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

class MoreImageShow : UITapGestureRecognizer{
    var imageUrls : String!
}
