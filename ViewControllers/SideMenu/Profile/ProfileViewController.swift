//
//  ProfileViewController.swift
//  Vs_GradIt
//
//  Created by APPLE on 27/09/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate  {
   
    

    
    @IBOutlet weak var reusee: ReuseView!
    
    @IBOutlet weak var backView: UIView!
    
    
    
    
    @IBOutlet weak var tv: UITableView!
    
    
    
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    
   
    
    let rowIdentifier = "ProfileTableViewCell"
    let imgRowIdentifier = "ProfileDetailsTableViewCell"
    let menuIdentifier = "MenuCollectionViewCell"
    var MenuRefName :[menuApiDataDetails] = []
    
    var profileData : [ProfileData] = []
    
    var memberId : Int!
    
    var priority : String!
    
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var collegeId : String!
    var menuMemberid : String!
    
    var str : [String] = []
   
    var strName : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        let defaults = UserDefaults.standard
        
        memberId = defaults.integer(forKey: DefaultsKeys.memberid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        collegeId  = defaults.string(forKey: DefaultsKeys.collegeid)
        menuMemberid = defaults.string(forKey: DefaultsKeys.memberid)
        tv.dataSource = self
        tv.delegate = self
//        MenuId()
        profile()
       
        
        if priority == "p1" {


            print("PrincipalVieewwColor")
            view.backgroundColor = UIColor(named: "Principal" )
          
                reusee.menuImg.image = UIImage(named: "principalBigMenu")

        }else if priority == "p4" {

            print("StudentVieewwColor")
            view.backgroundColor = UIColor(named: "studentViewColors")
          

            reusee.menuImg.image = UIImage(named: "studentSwipeImage")

        } else if priority == "p3" ||  priority == "p2" {

            print("HooodddVieewwColor")
            view.backgroundColor = UIColor(named: "Teaching Staff")
           
            reusee.menuImg.image = UIImage(named: "HodImage")

        }
        else if priority == "p5"{
            
            
            
            view.backgroundColor = UIColor(named: "FatherColor")
           
            reusee.menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }


        swipeMenuHeight.constant = 150
                reusee.call_back = { [self]
                    (val) in
                  
                    
                        self.swipeMenuHeight.constant =  reusee.callid
                   
                    print("ProfileViewController",reusee.callid)
                    
               
                }
                    
        
        let rowNib = UINib(nibName: rowIdentifier, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: rowIdentifier)
        
        
        let imageRowNib = UINib(nibName: imgRowIdentifier, bundle: nil)
        tv.register(imageRowNib, forCellReuseIdentifier: imgRowIdentifier)
        
        
        
        
        let backGesture = UITapGestureRecognizer(target: self, action: #selector(backVc))
        backView.addGestureRecognizer(backGesture)
        // Do any additional setup after loading the view.
    }


    
  @IBAction  func backVc() {
        dismiss(animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: imgRowIdentifier, for: indexPath)as! ProfileDetailsTableViewCell
            var profile : ProfileData = profileData[indexPath.row]
            if  profile.key == "College Logo"{
                
                
                cell.profileImg.sd_setImage(with: URL(string: profile.value), placeholderImage: UIImage(named: "person.fill"))
                

//                    cell.profileImg.setImageWith(profile.value)
                
                
            }
        
       
        return cell
    
    }else{
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: indexPath)as! ProfileTableViewCell
        
        
        var profile : ProfileData = profileData[indexPath.row]
        
        cell.keyLbl.text = profile.key
        cell.valueLbl.text = profile.value
        
        
        return cell
    }
    
    
    }
    
    func profile() {
        
        
      
            
            let param : [String : Int] =
            [
                "id" : memberId
            ]
            
        GetProfileDetailsRequest.call_request(param: param){ [self]
                (res) in
                
                let profile_response : ProfileResponse = Mapper<ProfileResponse>().map(JSONString: res)!
                
                self.profileData = profile_response.data
                
                
                tv.dataSource = self
                tv.delegate = self
                tv.reloadData()
                

            
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
        return 220
        }else{
            return 80
        }
    }
    
    
    
    // This part for bottom  swipe view .
      
   
    
    
    
    
    
  
    
    
    
      
}
