//
//  MoreSubCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 14/03/24.
//

import UIKit
import WebKit

class MoreSubCollectionViewCell: UICollectionViewCell,UIScrollViewDelegate {

    
    @IBOutlet weak var scrolles: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var webvie: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
                   image.contentMode = .scaleAspectFit
                         
                         // Add the image view as a subview of the scroll view
                     scrolles.addSubview(image)
                         
                         // Set up the scroll view
              scrolles.delegate = self
               scrolles.minimumZoomScale = 1.0
            scrolles.maximumZoomScale = 3.0
                         
                         // Add constraints to make the image view fill the scroll view
               image.translatesAutoresizingMaskIntoConstraints = false
                   image.topAnchor.constraint(equalTo: scrolles.contentLayoutGuide.topAnchor).isActive = true
                   image.leadingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.leadingAnchor).isActive = true
                  image.bottomAnchor.constraint(equalTo: scrolles.contentLayoutGuide.bottomAnchor).isActive = true
                  image.trailingAnchor.constraint(equalTo: scrolles.contentLayoutGuide.trailingAnchor).isActive = true
                   
        
    }

    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { // image zoom
          return image
      }

      func scrollViewDidZoom(_ scrollView: UIScrollView) {
          // Center the image view within the scroll view as it zooms
          let xOffset = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
          let yOffset = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
          scrollView.contentInset = UIEdgeInsets(top: yOffset, left: xOffset, bottom: yOffset, right: xOffset)
      }
    
}
