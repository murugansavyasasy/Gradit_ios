//
//  ChatTvTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/02/23.
//

import UIKit
import ObjectMapper

class ChatTvTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var Cv: UICollectionView!
    
    var Indentifiers = "ChatCollectionViewCell"
    
    var chatFortPageRefName : [chatFrontPageDataDetails] = []
    
    var memberId : String!
    var colgId   : String!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        let defaults = UserDefaults.standard
        
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
       
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        
        chatfortPage()
        let rowNib = UINib(nibName: Indentifiers, bundle: nil)
        Cv.register(rowNib, forCellWithReuseIdentifier: Indentifiers)
//        chatCollectionView.delegate = self
//        chatCollectionView.dataSource = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatFortPageRefName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers, for: indexPath) as!
        
        ChatCollectionViewCell
        
        let chatForntPages : chatFrontPageDataDetails = chatFortPageRefName[indexPath.row]
        
        cell.subjectNameCellLabel.text = chatForntPages.subjectname
        cell.staffNameCellLabel.text = chatForntPages.staffname
        
        let intract = UITapGestureRecognizer(target: self, action: #selector(intractVc))
        cell.interactCellView.addGestureRecognizer(intract)
        
        
        
        return cell
    }
    
    @IBAction func intractVc(){
       
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.size.width / 2, height:180)
        
    }
    
    
    func chatfortPage(){
        
        var chatfornt = ChatFrontPageModal()
        
        chatfornt.college_id = colgId
        chatfornt.student_id = memberId
        
        APiCallManager.shared.callApi(url: APIEndpoints.GetstaffdetailsForApp, httpMethod: .post, queryParam: nil, requestBody: chatfornt) { [weak self] (result:Result<ChatFrontPageResponce,Error>) in
            guard let self = self else{return}
            switch result {
            case .success(let success):
                chatFortPageRefName = success.data ?? []
                Cv.dataSource = self
                Cv.delegate = self
                Cv.reloadData()
            case .failure(let error):
               print("Error: \(error)")
            }
        }
        
    }
    
}
    
    

