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
                
                cell.profileImg.sd_setImage(with: URL(string: profile.value ?? ""), placeholderImage: UIImage(named: "person.fill"))
                
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
        
        let param : [String : Any] =
        [
            "id" : memberId ?? 0
        ]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetProfileDetails,
            httpMethod: .get,
            queryParam: param,
            requestBody: nil
        ) { [weak self] (result: Result<ProfileResponse, Error>) in
            
            guard let self = self else { return }
            
            switch result {
                
            case .success(let profile_response):
                
                if profile_response.Status == 1 {
                    self.profileData = profile_response.data ?? []
                    self.tv.dataSource = self
                    self.tv.delegate = self
                    self.tv.reloadData()
                }else {
                    let alert = UIAlertController(
                        title: "Failed",
                        message: profile_response.Message ?? "Something went wrong.",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                        self.dismiss(animated: true)
                    })
                    
                    self.present(alert, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                let alert = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                    self.dismiss(animated: true)
                })
                
                self.present(alert, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 220
        }else{
            return 80
        }
    }
}
