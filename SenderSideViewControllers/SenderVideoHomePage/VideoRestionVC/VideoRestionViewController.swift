//
//  VideoRestionViewController.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 15/05/23.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class VideoRestionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    var idenfier = "VideoRestionTableViewCell"
    
    var restionData : [RestionDataDetails] = []
    @IBOutlet weak var tv: UITableView!
    
    @IBOutlet weak var confirmView: UIViewX!
    
    var addImageBackGroundurl : String!
    
    var smallImageUrl  : String!
    
    var imageWebUrl : String!
    
    var videoMenuId : String!
    
    var str : [String] = []
    
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .light
        
        restion()
        
        
        let rowNib = UINib(nibName: idenfier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: idenfier)
        
        
        let confirm  = UITapGestureRecognizer(target: self, action: #selector(conifrmVC))
        confirmView.addGestureRecognizer(confirm)
        
    }
    
    
    
    
    @IBAction func conifrmVC(){
        
        
        
        let vc = VideoPlusPageViewController(nibName: nil, bundle: nil)
        
        vc.addImageBackGroundurl = addImageBackGroundurl
        vc.smallImageUrl = smallImageUrl
        vc.imageWebUrl = imageWebUrl
        vc.videoMenuId = videoMenuId
        vc.str = str
        vc.strName = strName
        vc.is_read_enabled = is_read_enabled
        vc.is_write_enabled = is_write_enabled
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true,completion: nil)
        
        
    }
    
    func restion() {
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetVideoContentRestriction,
            httpMethod: .post,
            queryParam: nil,
            requestBody: nil
        ) { [weak self] (result: Result<restionResponce, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let menuResp):
                
                print("order data", menuResp)
                
                self.restionData = menuResp.data ?? []
                
                self.tv.delegate = self
                self.tv.dataSource = self
                self.tv.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return restionData.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idenfier , for: indexPath) as!
        
        
        VideoRestionTableViewCell
        
        
        //  
        let rest  : RestionDataDetails = restionData[indexPath.row]
        
        let str = String(indexPath.row+1)
        
        cell.numberLabel.text = str
        
        
        
        cell.contentLabel.text = rest.content
        
        
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
    
    
    @IBAction func backbtn(_ sender: Any) {
        
        
        dismiss(animated: true)
    }
    
}
