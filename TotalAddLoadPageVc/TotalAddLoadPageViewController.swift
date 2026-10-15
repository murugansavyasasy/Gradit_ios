//
//  TotalAddLoadPageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 28/02/23.
//

import UIKit
import WebKit
import KRProgressHUD

class TotalAddLoadPageViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    
    var AddWebUrl : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
        view.backgroundColor = .priorityColor
       
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
       loadWebPage()
    }
    
    private func loadWebPage() {
        guard let AddWebUrl,
              !AddWebUrl.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              let url = URL(string: AddWebUrl) else {
            KRProgressHUD.dismiss()
            return
        }
        
        KRProgressHUD.show()
        
        let request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30
        )
        
        webView.load(request)
    }

  
    @IBAction func backbtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func webView(
           _ webView: WKWebView,
           didFinish navigation: WKNavigation!
       ) {
           KRProgressHUD.dismiss()
       }

       func webView(
           _ webView: WKWebView,
           didFail navigation: WKNavigation!,
           withError error: Error
       ) {
           KRProgressHUD.dismiss()
           
           let alert = UIAlertController(
               title: "Unable to Load",
               message: "Please try again later.",
               preferredStyle: .alert
           )

           alert.addAction(
               UIAlertAction(title: "OK", style: .default)
           )

           present(alert, animated: true)
       }

       func webView(
           _ webView: WKWebView,
           didFailProvisionalNavigation navigation: WKNavigation!,
           withError error: Error
       ) {
           KRProgressHUD.dismiss()
           
           let alert = UIAlertController(
               title: "Unable to Load",
               message: "Please try again later.",
               preferredStyle: .alert
           )

           alert.addAction(
               UIAlertAction(title: "OK", style: .default)
           )

           present(alert, animated: true)
       }
}


import UIKit
import SDWebImage

class AdTapGesture: UITapGestureRecognizer {
    var url: String?
}

extension UIImageView {
    
    func setAdImage(
        imageURL: String?,
        adURL: String?,
        placeholder: UIImage? = UIImage(named: "Default_Ad"),
        from viewController: UIViewController
    ) {
        
        self.isUserInteractionEnabled = false

        // Remove previous ad gestures
        self.gestureRecognizers?
            .filter { $0 is AdTapGesture }
            .forEach { self.removeGestureRecognizer($0) }

        let defaultAdURL = "https://www.schoolchimes.com"
        
        let imageURL = imageURL ?? ""

        self.sd_setImage(
            with: URL(string: imageURL),
            placeholderImage: placeholder
        ) { [weak self] image, error, _, _ in

            guard let self = self else { return }

            let finalAdURL: String

            if let image = image, error == nil {
                // Image successfully loaded
                finalAdURL = adURL ?? ""
            } else {
                // Image failed -> use default ad URL
                finalAdURL = defaultAdURL
            }

            guard !finalAdURL.isEmpty else {
                self.isUserInteractionEnabled = false
                return
            }

            let gesture = AdTapGesture(
                target: viewController,
                action: #selector(UIViewController.handleAdTap(_:))
            )

            gesture.url = finalAdURL

            self.isUserInteractionEnabled = true
            self.addGestureRecognizer(gesture)
        }
    }
}

extension UIViewController {

    @objc func handleAdTap(_ gesture: AdTapGesture) {

        guard let url = gesture.url,
              !url.isEmpty else {
            return
        }

        let vc = TotalAddLoadPageViewController(
            nibName: nil,
            bundle: nil
        )

        vc.AddWebUrl = url
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true)
    }
}
