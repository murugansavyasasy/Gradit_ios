//
//  MoreImageVcViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 28/02/24.
//

import UIKit

class MoreImageVcViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var viewFullHeight: NSLayoutConstraint!
    
    @IBOutlet weak var TopicLabel: UILabel!
    
    
    @IBOutlet weak var Cv: UICollectionView!
    
    var imageFile : [String]  = []
    var fileType : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    var TopicLbl : String!
    var menuIdentifier = "MoreImageCCCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        
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
        
        if containsPDF {
            cell.pdfView.isHidden = false
        } else {
            print(".pdf is not present in the array")
            
            cell.pdfView.isHidden = true
        }
        
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
        if imageFile.count == 1{
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
            
        }else if imageFile.count == 2{
            
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
        }else if imageFile.count == 3{
            
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
        }else if imageFile.count == 4{
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
            
        }else if imageFile.count == 5{
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
            
        }else if imageFile.count == 6{
            
            let collectionView = collectionView.bounds.width
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
            
            print("heeeeee", CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2))
        }
        else{
            
            let collectionView = collectionView.bounds.width
            print("heeeeee", CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2))
            return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
            
        }
        
       
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
