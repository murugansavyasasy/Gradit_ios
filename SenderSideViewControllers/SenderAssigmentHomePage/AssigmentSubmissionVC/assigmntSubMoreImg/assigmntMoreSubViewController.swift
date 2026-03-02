//
//  assigmntMoreSubViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/03/24.
//

import UIKit
import KRProgressHUD

class assigmntMoreSubViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stringss.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idenfier , for: indexPath) as! MoreSubCollectionViewCell
        
        
        let image  = stringss[indexPath.row]
        
        

        
        if image.contains(".pdf"){
            cell.image.isHidden = true
            cell.webvie.isHidden  = false
            cell.scrolles.isHidden = true
            let url = URL (string: image)
            let requestObj = URLRequest(url: url!)
            cell.webvie.load(requestObj)
        }
        else{
          
            cell.image.isHidden = false
           
            cell.scrolles.isHidden = false
            cell.webvie.isHidden  = true
            
            cell.image.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "person.fill"))
//        
         
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       

            return  CGSize(width: collectionView.frame.size.width / 2 + 160, height: collectionView.frame.size.height)
//
        
        
       
    }
    
    
  

    @IBOutlet weak var cv: UICollectionView!
    
    var Filepath2 : [FilepathDataDetails ] = []
    var idenfier = "MoreSubCollectionViewCell"
    var stringss : [String] = []
    var  MoreimgfilePath : String!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        print("MoreimgfilePathMoreimgfilePath",MoreimgfilePath)
        

        
        let menuRowNib = UINib(nibName: idenfier, bundle: nil)
        cv.register(menuRowNib, forCellWithReuseIdentifier: idenfier)
        
        
        cv.delegate = self
        cv.dataSource = self
    }


   
    @IBAction func backBtn(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
}
