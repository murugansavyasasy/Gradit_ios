//
//  ShowSelectedImageViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 12/05/23.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class ShowSelectedImageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    
    @IBOutlet weak var uploadViews: UIViewX!
    
    @IBOutlet weak var cv: UICollectionView!
    
    var sendImageEvent : [sendImageEventDataDetails] = []
    
    var identifer = "ShowImageCollectionViewCell"
    
    
    
    var headerId : String!
    
    var TotalAws : String!
    var ShowImageTOCollectionView : [String] = []
    var userId : String!
    var coldId : String!
    var priority : String!
    var photoArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("photoArrayphotoArrayphotoArray",photoArray)
        overrideUserInterfaceStyle = .light
        print("ShowImageTOCollectionView",ShowImageTOCollectionView)
        let defaults = UserDefaults.standard
        userId = defaults.string(forKey: DefaultsKeys.memberid)
        coldId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        let rowNib = UINib(nibName: identifer, bundle: nil)
        cv.register(rowNib, forCellWithReuseIdentifier: identifer)
        cv.delegate = self
        cv.dataSource = self
        let uploadViewww = UITapGestureRecognizer(target: self, action: #selector(uploadVc))
        uploadViews.addGestureRecognizer(uploadViewww)
        
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        
        
        dismiss(animated: true)
        
    }
    
    @IBAction func uploadVc(){
        
        
        
        
        
        
        let refreshAlert = UIAlertController(title: "Hold On!", message: "Are you sure do you want to Submit?", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            
            
            self.eventSendImage()
            
        }))
        
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    
    func eventSendImage(){
        
        var evenimageName = FileNames()
        
        evenimageName.FileName = TotalAws
        
        print("printttt", evenimageName.FileName )
        
        var eventImagess = EventImageModal()
        
        eventImagess.collegeid = coldId
        eventImagess.userid = userId
        eventImagess.eventheaderid = headerId
        eventImagess.FileNameArray = [evenimageName]
        
        print("noriceEnier", eventImagess)
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.AddeventphotosWithCloudURL,
            httpMethod: .post,
            queryParam: nil,
            requestBody: eventImagess
        ) { [weak self] (result: Result<EventImageSendResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let particularss):
                
                if particularss.Status == 1{
                    
                    self.sendImageEvent = particularss.data ?? []
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                        
                        guard let self = self else { return }
                        
                        if priority == "p2" || priority == "p3" {
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            
                            vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                        else{
                            
                            let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                            
                            vc.view.backgroundColor = UIColor(named: "Principal" )
                            
                            vc.modalPresentationStyle = .fullScreen
                            self.present(vc, animated: true , completion: nil)
                            
                        }
                        
                        
                    }))
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    self.cv.delegate = self
                    self.cv.dataSource = self
                    self.cv.reloadData()
                    
                }
                
                
                else{
                    
                    
                    let refreshAlert = UIAlertController(title: "", message: particularss.Message, preferredStyle: UIAlertController.Style.alert)
                    
                    refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    
                    
                    self.present(refreshAlert, animated: true, completion: nil)
                    
                    self.cv.delegate = self
                    self.cv.dataSource = self
                    self.cv.reloadData()
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return ShowImageTOCollectionView.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath) as!
        
        ShowImageCollectionViewCell
        
        
        cell.SelectedImageViews.sd_setImage(with: URL(string: ShowImageTOCollectionView[indexPath.row]), placeholderImage: UIImage(named: "placeHolder.png"))
        
        
        
        
        
        return cell
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height:130)
        
    }
    
}
