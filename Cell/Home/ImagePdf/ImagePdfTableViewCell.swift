//
//  ImagePdfTableViewCell.swift
//  Vs_GradIt
//
//  Created by APPLE on 26/09/22.
//

import UIKit

class ImagePdfTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var cv: UICollectionView!
    
    
    
    
    let cvIdentifier = "ImageScrollCollectionViewCell"
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cvIdentifier, for: indexPath) as! ImageScrollCollectionViewCell
        
        return cell
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        cv.dataSource = self
        cv.delegate = self
        
        
        let cvRowib = UINib(nibName: cvIdentifier, bundle: nil)
        cv.register(cvRowib, forCellWithReuseIdentifier: cvIdentifier)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 245, height: 140)
    }
    
}
