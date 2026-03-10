//
//  HomePageChatTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 23/04/23.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class HomePageChatTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var chatViewAll: UIViewX!
    
    @IBOutlet weak var Cv: UICollectionView!
    
    
   var  identifier  = "HompageChatCollectionViewCell"
    
    
    
    var dashtype : String!
    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!
    
    var dashBoardDataList : [DashBoardData] = []
    
    var chatsData : [chatData] = []
   
    var str : [String] = []
    var strName : [String] = []
    var is_read_enabled = ""
    var is_write_enabled = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        let defaults = UserDefaults.standard
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        
        Cv.dataSource  = self
        Cv.delegate = self
        
        let cvRowib = UINib(nibName: identifier, bundle: nil)
        Cv.register(cvRowib, forCellWithReuseIdentifier: identifier)
        
        
//        chat()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("printCounts",chatsData.count)
        
        return chatsData.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        
        HompageChatCollectionViewCell

        let chat : chatData = chatsData[indexPath.row]
        
        
        if chat.message == "No such record found!"{
            
            
            
            cell.chatFullViews.isHidden = true
           
            cell.nodataLAbel.text = chat.message
          
            
            
        }
        
        
        else{
            
            cell.chatFullViews.isHidden = false
            let first = String(chat.createdon.prefix(10))
            
            let lastThree = String(chat.createdon.suffix(10)) //"456"
            
            
            let dateFormatterGet = DateFormatter()

                    dateFormatterGet.dateFormat = "dd-MM-yyy"



                    let dateFormatterPrint = DateFormatter()

                    dateFormatterPrint.dateFormat = " dd MMM,yyyy"



                    let date: NSDate? = dateFormatterGet.date(from: first) as NSDate?

           
            cell.dateLabel.text = dateFormatterPrint.string(from: date as! Date)
            cell.timeLabel.text = lastThree
            cell.QuestionLabl.text = chat.question
            cell.studentLabel.text = chat.studentname
            
            
        }
        
        
      
   return cell
    }
    
    func getViewController() -> UIViewController? {

        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        return nil

    }

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        
        HompageChatCollectionViewCell
        let chat : chatData = chatsData[indexPath.row]
        
        if chat.message == "No such record found!"{
            
     
            
        }
        
        else{
            if priority == "p4" {
                
                let vc =  ChatHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true,completion: nil)
                
                
            }
            
            else if priority == "p1" {
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                let currentController = self.getViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true,completion: nil)
                
                
                
            }
            
            
            else if priority == "p2" || priority == "p3" {
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                let currentController = self.getViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true,completion: nil)
                
                
                
            }
            
            
            else if  priority == "p5"{
                
                
                let vc =  ChatHomePageViewController(nibName: nil, bundle: nil)
                let currentController = self.getViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true,completion: nil)
                
                
                
            }
            
            
            
            else if priority == "p6"  {
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                let currentController = self.getViewController()
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = is_read_enabled
                vc.is_write_enabled = is_write_enabled
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true,completion: nil)
                
                
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let chat : chatData = chatsData[indexPath.row]
        
        if chat.message == "No such record found!"{
            
            
            
            return CGSize(width: 400, height: 50)
            
        }
        
        
        else{
            
            return CGSize(width: 400, height: 162)
            
        }
        
        
      
    }
}
