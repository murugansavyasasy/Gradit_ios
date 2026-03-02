//
//  AttachmentPreviewVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/12/25.
//

import UIKit

class AttachmentPreviewVC: UIViewController{
    
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var BackView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var OptionBtn: UIButton!
    @IBOutlet weak var downloadPopupView: UIView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var DownloadBtn: UIButton!
    
    var Files: [File] = []
    var selectedIndex: Int = 0
    private var hideIndexWorkItem: DispatchWorkItem?
    var Title = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        BackView.layer.shadowColor = UIColor.black.cgColor
        BackView.layer.shadowOpacity = 0.25
        BackView.layer.shadowOffset = CGSize(width: 0, height: 4)
        BackView.layer.shadowRadius = 8
        BackView.layer.masksToBounds = false
        
        downloadPopupView.isHidden = true
        downloadPopupView.layer.cornerRadius = 10
        downloadPopupView.layer.shadowOpacity = 0.25
        downloadPopupView.layer.shadowOffset = CGSize(width: 0, height: 2)
        downloadPopupView.layer.shadowRadius = 2
        
        OptionBtn.transform = CGAffineTransform(rotationAngle: .pi / 2)
        
        backBtn.setTitle(Title, for: .normal)
        
        indexLabel.setFont(style: .medium, size: 14)
        cv.showsHorizontalScrollIndicator = false
        cv.register(UINib(nibName: "AttachmentPreviewCvCell", bundle: nil), forCellWithReuseIdentifier: "AttachmentPreviewCvCell")
        cv.delegate = self
        cv.dataSource = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewTapped)))
        view.gestureRecognizers?.first?.cancelsTouchesInView = false
    }
    
    @IBAction func ViewTapped(){
        
        downloadPopupView.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard selectedIndex < Files.count else { return }

        cv.scrollToItem(
            at: IndexPath(item: selectedIndex, section: 0),
            at: .centeredHorizontally,
            animated: false
        )
        
        updateIndexLabel(currentIndex: selectedIndex)
    }
    
    func updateIndexLabel(currentIndex: Int) {

        indexLabel.text = "\(currentIndex + 1) / \(Files.count)"
        showIndexLabelTemporarily()
    }

    func showIndexLabelTemporarily() {

        // Cancel any pending hide
        hideIndexWorkItem?.cancel()

        // Show label
//        indexLabel.alpha = 1
//        indexLabel.isHidden = false

        indexLabel.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.indexLabel.alpha = 1
        }

        
        // Create new hide task
        let workItem = DispatchWorkItem { [weak self] in
            UIView.animate(withDuration: 0.3) {
                self?.indexLabel.alpha = 0
            }
        }

        hideIndexWorkItem = workItem

        // Hide after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentIndex()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        if !decelerate {
            updateCurrentIndex()
        }
    }

    func updateCurrentIndex() {
        let pageWidth = cv.frame.width
        guard pageWidth > 0 else { return }

        let index = Int(round(cv.contentOffset.x / pageWidth))
        selectedIndex = max(0, min(index, Files.count - 1))

        updateIndexLabel(currentIndex: selectedIndex)
    }

    
    @IBAction func backAct(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func OptionAct(_ sender: Any) {
        downloadPopupView.isHidden.toggle()
    }

    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    
    @IBAction func DownloadAct(_ sender: Any) {
        
        guard selectedIndex < Files.count else {
                showAlert(title: "Download Failed", message: "Invalid file index.")
                return
            }

            downloadPopupView.isHidden = true
            let file = Files[selectedIndex]
        
        let urlString = file.url ?? ""
       
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let session = URLSession(configuration: .default)
        let downloadTask = session.downloadTask(with: url) { (tempLocalUrl, response, error) in
            if let error = error {
                print("Download error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "Download failed", okTitle: "Ok", okAction: {})
                }
                return
            }

            guard let tempLocalUrl = tempLocalUrl else {
                print("No file URL")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "No file found", okTitle: "Ok", okAction: {})
                }
                return
            }

            let fileManager = FileManager.default
            let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)

            do {
                if fileManager.fileExists(atPath: destinationUrl.path) {
                    try fileManager.removeItem(at: destinationUrl)
                }
                try fileManager.moveItem(at: tempLocalUrl, to: destinationUrl)
                print("File downloaded to: \(destinationUrl)")
                
                // ✅ UI updates on main thread
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Success", message: "Resume downloaded successfully", okTitle: "Ok", okAction: {})
                }
            } catch {
                print("File move error: \(error)")
                DispatchQueue.main.async {
                    AlertHelper.showOKAlert(on: self, title: "Failed", message: "Failed to download resume", okTitle: "Ok", okAction: {})
                }
            }
        }

        downloadTask.resume()
    }

       
    
    @IBAction func shareAct(_ sender: Any) {
        guard selectedIndex < Files.count else {
            showAlert(title: "Share Failed", message: "Invalid file.")
            return
        }
        
        downloadPopupView.isHidden = true
        let file = Files[selectedIndex]
        
        let filePath = file.url ?? ""  // e.g., "https://s3.amazonaws.com/..." or "file://..." or local path
        
        if filePath.lowercased().hasPrefix("http") {
            // Remote URL (e.g., AWS)
            guard let remoteURL = URL(string: filePath) else {
                print("Invalid remote URL")
                return
            }
            
            // Download the PDF
            URLSession.shared.dataTask(with: remoteURL) { data, response, error in
                guard let data = data, error == nil else {
                    print("Failed to download PDF:", error ?? "Unknown error")
                    return
                }
                
                // Save to temp location
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("SharedPDF.pdf")
                do {
                    try data.write(to: tempURL)
                    
                    DispatchQueue.main.async {
                        let activityVC = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
                        self.present(activityVC, animated: true, completion: nil)
                    }
                } catch {
                    print("Failed to save downloaded PDF:", error)
                }
            }.resume()
            
        } else {
            // Local file path
            var fileURL: URL
            
            if filePath.lowercased().hasPrefix("file://") {
                fileURL = URL(fileURLWithPath: filePath.replacingOccurrences(of: "file://", with: ""))
            } else {
                // Assume it's a filename in the Documents directory
                if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    fileURL = documentsDir.appendingPathComponent(filePath)
                } else {
                    print("Unable to locate documents directory.")
                    return
                }
            }
            
            // Check if local file exists
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                print("Local file not found at path: \(fileURL.path)")
                return
            }
            
            // Share the local file
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }


}

extension AttachmentPreviewVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "AttachmentPreviewCvCell", for: indexPath) as! AttachmentPreviewCvCell
        
        let file = Files[indexPath.row]
        
        cell.configure(with: file)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cv.frame.width, height: cv.frame.height)
    }
    
}
