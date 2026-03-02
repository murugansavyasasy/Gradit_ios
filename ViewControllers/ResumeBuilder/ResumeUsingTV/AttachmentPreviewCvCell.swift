//
//  AttachmentPreviewCvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/12/25.
//

import UIKit
import WebKit

class AttachmentPreviewCvCell: UICollectionViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
            webView.stopLoading()
            webView.loadHTMLString("", baseURL: nil)
            imageView.isHidden = true
            webView.isHidden = true
        }
    
    func configure(with file: File) {

            guard let urlString = file.url else { return }

            if file.type?.lowercased() == "image" {
                showImage(urlString)
            } else {
                showDocument(urlString)
            }
        }
    
    func showImage(_ urlString: String) {

            imageView.isHidden = false
            webView.isHidden = true

            // Remote image
            if urlString.contains("http"),
               let url = URL(string: urlString) {

//                URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
//                    guard let self,
//                          let data,
//                          let image = UIImage(data: data) else { return }
//
//                    DispatchQueue.main.async {
//                        self.imageView.image = image
//                    }
//                }.resume()
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "ic_white"))
            }
            // Local image
            else if let localURL = URL(string: urlString) {
                imageView.image = UIImage(contentsOfFile: localURL.path)
            }
        }
    
    func showDocument(_ urlString: String) {

           imageView.isHidden = true
           webView.isHidden = false

           // Remote document
           if urlString.contains("http"),
              let url = URL(string: urlString) {

               webView.load(URLRequest(url: url))
           }
           // Local document
           else if let localURL = URL(string: urlString) {

               webView.loadFileURL(
                   localURL,
                   allowingReadAccessTo: localURL.deletingLastPathComponent()
               )
           }
       }
}
