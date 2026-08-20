//
//  ReuseView.swift
//  Vs_GradItCollege
//
//  Created by APPLE on 09/11/22.
//

import UIKit
import Foundation
import ObjectMapper


@available(iOS 16.0, *)
class ReuseView  : UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var SwipeUpImageTop: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var menuImg: UIImageView!
    @IBOutlet weak var arrowImg: UIImageView!
    
    @IBOutlet weak var swipeMenu: UIView!
    @IBOutlet weak var downView: UIView!
    @IBOutlet weak var swipeMenuHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cv: UICollectionView!
    
    var loginAsType : String!
    var memberId : String!
    var colgId : String!
    
    var priority : String!
    var MenuRefName :[menuApiDataDetails] = []
    var str : [String] = []
    
    var strName : [String] = []
    var NoticeBoardId = "1"
    var videoId = "2"
    var EventId = "3"
    var communicationId = "4"
    var imagePdfId = "5"
    var Assigment = "6"
    var is_read_enabled = ""
    var is_write_enabled = ""
    let nibName = "ReuseView"
    let menuIdentifier = "MenuCollectionViewCell"
    
    var callid : CGFloat!
    var call_back: ((CGFloat) -> Void)?
    static var main_Vc : NewHomescreenVC!
    let backgroundView = UIView()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        
        let defaults = UserDefaults.standard
        loginAsType = defaults.string(forKey: DefaultsKeys.loginAsType)
        memberId = defaults.string(forKey: DefaultsKeys.memberid)
        colgId = defaults.string(forKey: DefaultsKeys.collegeid)
        priority = defaults.string(forKey: DefaultsKeys.priority)
        
        
        
        
        
        commonInit()
        
        MenuIdList()
        if priority == "p1" {
            
            
            print("PrincipalVieewwColor")
            menuImg.image = UIImage(named: "principalBigMenu")
            
        }else if priority == "p4" {
            
            print("StudentVieewwColor")
            menuImg.image = UIImage(named: "studentSwipeImage")
            
        } else if priority == "p3" ||  priority == "p2" {
            
            print("HooodddVieewwColor")
            menuImg.image = UIImage(named: "HodImage")
            
        }
        else if priority == "p5"{
            
            menuImg.image = UIImage(named: "StaffBigMenu")
            
            
        }
        swipeMenuHeight.constant = 150
        
        cv.dataSource = self
        cv.delegate = self
        
        
        cv!.isPagingEnabled = true
        cv!.isScrollEnabled = true
        cv!.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
        
        cv.alwaysBounceVertical = true
        
        let menuRowNib = UINib(nibName: menuIdentifier, bundle: nil)
        cv.register(menuRowNib, forCellWithReuseIdentifier: menuIdentifier)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .up
        downView.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        downView.addGestureRecognizer(swipeDown)
        
        
    }
    
    
    func MenuIdList() {
        
        var Menu = menuApiIdModal ()
        Menu.college_id = colgId
        Menu.priority = priority
        Menu.user_id = memberId
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.GetParentUserMenuWithReadWriteAccess,
            httpMethod: .post,
            queryParam: nil,
            requestBody: Menu
        ) {[weak self] (result:Result<menuApiIdResponce, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                if success.Status == 1 {
                    
                    MenuRefName = success.data
                    DefaultsKeys.MenuRefName = MenuRefName
                    
                    for i in MenuRefName{
                        str.append(i.menu_slug)
                        strName.append(i.menu_name)
                        print("is_read_enabled",i.is_read_enabled)
                        print("is_write_enabled",i.is_write_enabled)
                        is_read_enabled = String(i.is_read_enabled)
                        is_write_enabled = String(is_write_enabled)
                    }
                    
                    cv.delegate = self
                    cv.dataSource = self
                    cv.reloadData()
                }
                
                
            case .failure(let failure):
                print("Error:",failure.localizedDescription)
            }
        }
    }
    
    
    
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if priority == "p4" {
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    arrowImg.image = UIImage(named: "down")
                    
                    SwipeUpImageTop.constant = 30
                    print("Swiped up")
                default:
                    break
                }
            }
            
            
            else if priority == "p1" {
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 140
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        print("heloooohgfdfg")
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        print("heloooohgfdfg")
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        print("heloooohgfdfgP1")
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped upkjhgfghjk")
                    
                    SwipeUpImageTop.constant = 30
                default:
                    break
                }
                
                
            }
            
            else if priority == "p3" ||  priority == "p2" {
                
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    //
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                    SwipeUpImageTop.constant = 30
                default:
                    break
                }
                //
            }
            
            else if priority == "p7"  {
                
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    
                    //
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                    SwipeUpImageTop.constant = 30
                default:
                    break
                }
                //
            }
            
            else if priority == "p5"{
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    //
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                    SwipeUpImageTop.constant = 30
                default:
                    break
                }
                //
                
                
                
            }
            
            else if priority == "p6"  {
                
                
                
                switch swipeGesture.direction {
                case .right:
                    print("Swiped right")
                case .down:
                    swipeMenuHeight.constant = 150
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    callid =  swipeMenuHeight.constant
                    call_back?(callid)
                    arrowImg.image = UIImage(named: "up")
                    print("Swiped down")
                case .left:
                    print("Swiped left")
                case .up:
                    
                    if str.count <= 4{
                        
                        print("uiouiop")
                        swipeMenuHeight.constant = 150
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    //
                    else if str.count  == 5{
                        
                        print("uioiuiopkjhgbjnkmjhvgyjbkn,m")
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 6{
                        
                        
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    //
                    else if str.count == 7 {
                        
                        
                        
                        swipeMenuHeight.constant = 240
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 8{
                        
                        
                        swipeMenuHeight.constant = 240
                        
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 9{
                        
                        
                        swipeMenuHeight.constant = 300
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    else if str.count == 10{
                        
                        
                        swipeMenuHeight.constant = 300
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 11{
                        
                        
                        swipeMenuHeight.constant = 300
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 12{
                        
                        
                        swipeMenuHeight.constant = 300
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 13{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    
                    else if str.count == 14{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                    }
                    
                    else if str.count == 15{
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                        
                    }
                    
                    else {
                        
                        
                        swipeMenuHeight.constant = 400
                        callid =  swipeMenuHeight.constant
                        call_back?(callid)
                        
                    }
                    
                    
                    print("swipeMenuHeight.constant\(swipeMenuHeight.constant)")
                    
                    arrowImg.image = UIImage(named: "down")
                    print("Swiped up")
                    SwipeUpImageTop.constant = 30
                default:
                    break
                }
                //
            }
            
        }
        
    }
    
    //
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MenuRefName.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MenuCollectionViewCell
        
        cell.menuNameLbl.text = strName[indexPath.row]
        cell.menuImg.image = UIImage(named: String(str[indexPath.row]))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4, height: 78)
    }
    
    
    
    func getCurrentViewController() -> UIViewController? {
        
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
        let currentController = self.getCurrentViewController()
        print("select")
        let stud : menuApiDataDetails = MenuRefName[indexPath.row]
        let read = String(stud.is_read_enabled)
        let write =  String(stud.is_write_enabled)
        
        if priority == "p4"{
            
            print("5545454343")
            if str[indexPath.row] == "home"{
                print("ytrtrew")
                let currentController = self.getCurrentViewController()
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            else if str[indexPath.row] == "resume_builder"{
                print("ytrtrew")
                let currentController = self.getCurrentViewController()
                let vc = ResumeVC(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            else if str[indexPath.row] == "placement_events"{
                print("ytrtrew")
                let currentController = self.getCurrentViewController()
                let vc = PlacementEventsVC(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            } else if str[indexPath.row] == "placement_training"{
                print("ytrtrew")
                let currentController = self.getCurrentViewController()
                let vc = PlacementTrainingVC(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            
            else if str[indexPath.row] == "voice"{
                
                let currentController = self.getCurrentViewController()
                let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
                
                print("communicationssssssss")
                
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
               
                vc.str = str
                print("hgjhgnbv",is_read_enabled)
                vc.strName = strName
                
                vc.modalPresentationStyle = .fullScreen
                
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                currentController?.present(vc, animated: true, completion: nil)
                
            }else if str[indexPath.row] == "text"{
                let currentController = self.getCurrentViewController()
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                
                print("communicationssssssss")
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                print("hgjhgnbv",is_read_enabled)
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen

                currentController?.present(vc, animated: true, completion: nil)
             
                
            } else if str[indexPath.row] == "examination"{
                
                let currentController = self.getCurrentViewController()
                let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }else if str[indexPath.row] == "attendance"{
                
                let currentController = self.getCurrentViewController()
                let vc = AttendanceViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }else if str[indexPath.row] == "assignment"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                //
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "circular"{
                
                let currentController = self.getCurrentViewController()
                let vc = ImageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "hall_ticket"{
                
                
                let currentController = self.getCurrentViewController()
                
                let vc = HallTicketViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            } else if str[indexPath.row] == "notice_board"{
                
                let currentController = self.getCurrentViewController()
                let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            } else if str[indexPath.row] == "events"{
                
                let currentController = self.getCurrentViewController()
                let vc = EventsViewController(nibName: nil, bundle: nil)
                vc.modalPresentationStyle = .fullScreen
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "faculty"{
                let currentController = self.getCurrentViewController()
                let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
            
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "video"{
                let currentController = self.getCurrentViewController()
                let vc = VideoViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "chat"{
                
                let currentController = self.getCurrentViewController()
                let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "course_details"{
                
                
                let currentController = self.getCurrentViewController()
                let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
              
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "category_credit_points"{
                
                let currentController = self.getCurrentViewController()
                let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "sem_credit_points"{
                
                let currentController = self.getCurrentViewController()
                let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
            
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            } else if str[indexPath.row] == "exam_application_details"{
                
                let currentController = self.getCurrentViewController()
                let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "StudentParent")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
        }else if priority == "p1"{
            
           if str[indexPath.row] == "home"{
                
                
                let currentController = self.getCurrentViewController()
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "voice"{
                
                let currentController = self.getCurrentViewController()
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.MenuRefName = MenuRefName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "text"{
                
                let currentController = self.getCurrentViewController()
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.MenuRefName = MenuRefName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                
                vc.CommuniSegementName.backgroundColor = UIColor(named: "UnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "Selector")
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "examination"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.examSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                let currentController = self.getCurrentViewController()
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.str = str
                vc.strName = strName
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.segmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "Selector")
               
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                let currentController = self.getCurrentViewController()
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.assigmentMenuId = Assigment
                vc.str = str
                vc.strName = strName
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let currentController = self.getCurrentViewController()
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                let currentController = self.getCurrentViewController()
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.noticeSegments.backgroundColor = UIColor(named: "UnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                let currentController = self.getCurrentViewController()
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "UnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "Selector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                let currentController = self.getCurrentViewController()
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "video"{
                
                let currentController = self.getCurrentViewController()
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
                
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                let currentController = self.getCurrentViewController()
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            //   mark_your_attendance
            
            else if str[indexPath.row] == "mark_your_attendance"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "attendance_report"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationHistoryVc(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Principal" )
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
        }
        
        
        else if priority == "p3" ||  priority == "p2" {
            
            if str[indexPath.row] == "home" {
                
                
                
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                print("TeacherFaculty")
                
                
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            
            else if str[indexPath.row] == "video"{
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
               
                
                vc.VideoMenuId = videoId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "mark_your_attendance"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "attendance_report"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationHistoryVc(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
        }
        
        
        else if priority == "p7" {
            
            if str[indexPath.row] == "home" {
                
                
                
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                //
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
               
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                print("TeacherFaculty")
                
                
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
               
                vc.str = str
                vc.strName = strName
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
               
                
                vc.VideoMenuId = videoId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "mark_your_attendance"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "univercityColorCod" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        else if priority == "p5"{
            
            
            if str[indexPath.row] == "home"{
                
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                //
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: false, completion: nil)
                
                
            }
            
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            else if str[indexPath.row] == "voice"{
                
                let vc = CommunicationHomePageViewController(nibName: nil, bundle: nil)
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "text"{
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                
                
                vc.modalPresentationStyle = .fullScreen
              
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.CommuniSegementName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
                
            }
            else if str[indexPath.row] == "examination"{
                
                
                let vc = ExaminationHomePageViewController(nibName: nil, bundle: nil)
                
                
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.examSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "attendance"{
                
                
                let vc = AttendanceViewController(nibName: nil, bundle: nil)
                
              
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
//                vc.segmentName.backgroundColor = UIColor(named: "FatherUnselector")
//                vc.segmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                let vc = AssigmentHomePageViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "circular"{
                
                let currentController = self.getCurrentViewController()
                let vc = ImageViewController(nibName: nil, bundle: nil)
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.imageSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
                
            }
            
            
            
            else if str[indexPath.row] == "notice_board"{
                
                
                let vc = NoticeBoardHomePageViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.noticeSegments.backgroundColor = UIColor(named: "FatherUnselector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                let vc = EventsViewController(nibName: nil, bundle: nil)
               
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.eventSegmentName.backgroundColor = UIColor(named: "FatherUnselector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "FatherSelector")
                vc.modalPresentationStyle = .fullScreen
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "faculty"{
                
                let vc = FacultyHomePageViewController(nibName: nil, bundle: nil)
                
                
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "video"{
                
                let vc = VideoViewController(nibName: nil, bundle: nil)
                
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc = ChatHomePageViewController(nibName: nil, bundle: nil)
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "course_details"{
                
                let vc = CourseHomePageViewController(nibName: nil, bundle: nil)
                
                
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "category_credit_points"{
                
                let vc = CategoryHomePageViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            else if str[indexPath.row] == "sem_credit_points"{
                
                let vc = SemesterHomePageViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            
            
            else if str[indexPath.row] == "exam_application_details"{
                
                
                let vc = ExamDetailsHomePageViewController(nibName: nil, bundle: nil)
                
                
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "FatherColor")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
        }
        
        
        else if priority == "p6" {
            
            
            if str[indexPath.row] == "home"{
                
                
                
                let vc = NewHomescreenVC(nibName: nil, bundle: nil)
                
               
                vc.str = str
                vc.strName = strName
                //                vc.is_read_enabled = is_read_enabled
                //                vc.is_write_enabled = is_write_enabled
                //
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "feedetails"{
                
                let currentController = self.getCurrentViewController()
                
                let vc = FeePaymentViewController(nibName: nil, bundle: nil)
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "voice"{
                
                
                let vc = SenderCommunicationHomePageViewController(nibName: nil, bundle: nil)
              
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "text"{
                
                
                let vc = CommuniSMSViewController(nibName: nil, bundle: nil)
                
                vc.ComunimenuId = communicationId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.CommuniSegementName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.CommuniSegementName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "examination"{
                
                
                let vc = SenderExmainationHomePageViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.examSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.examSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
            }
            
            
            
            else if str[indexPath.row] == "attendance"{
                
                let vc =  SenderAttendanceVcViewController(nibName: nil, bundle: nil)
                
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.segmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.segmentName.selectedSegmentTintColor = UIColor(named: "HodUnSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "assignment"{
                
                
                let vc = SenderAssigmentHomePageViewController(nibName: nil, bundle: nil)
              
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.assigmentSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.assigmentSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                //
            }
            
            
            else if str[indexPath.row] == "circular"{
                
                let vc = SenderImagePdfHomePageViewController(nibName: nil, bundle: nil)
               
                vc.imagePdfMenuIdType = imagePdfId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.imageSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.imageSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated:
                                            true, completion: nil)
                
            }
            
            else if str[indexPath.row] == "notice_board"{
                
                let vc = SenderGraditNoticeBoardMenuViewController(nibName: nil, bundle: nil)
               
                vc.menuTypessww = NoticeBoardId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.noticeSegments.backgroundColor = UIColor(named: "HodUnSelector")
                vc.noticeSegments.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated:
                                            true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "events"{
                
                
                let vc = SenderEventHomePageViewController(nibName: nil, bundle: nil)
               
                vc.EventMenuId = EventId
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.eventSegmentName.backgroundColor = UIColor(named: "HodUnSelector")
                vc.eventSegmentName.selectedSegmentTintColor = UIColor(named: "HodSelector")
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            
            else if str[indexPath.row] == "faculty"{
                
                print("TeacherFaculty")
                
                
                
                let vc = SenderFacultyViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
            }
            
            else if str[indexPath.row] == "video"{
                
                
                let vc = SenderVideoHomePageViewController(nibName: nil, bundle: nil)
               
                //
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.VideoMenuId = videoId
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
            }
            
            
            else if str[indexPath.row] == "chat"{
                
                
                let vc =  ChatSenderViewController(nibName: nil, bundle: nil)
               
                vc.str = str
                vc.strName = strName
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            else if str[indexPath.row] == "mark_your_attendance"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationViewController(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
            else if str[indexPath.row] == "attendance_report"{
                let currentController = self.getCurrentViewController()
                let vc =  LocationHistoryVc(nibName: nil, bundle: nil)
                vc.is_read_enabled = read
                vc.is_write_enabled = write
                
                vc.view.backgroundColor = UIColor(named: "Teaching Staff" )
                
                
                
                
                vc.modalPresentationStyle = .fullScreen
                currentController?.present(vc, animated: true, completion: nil)
                
                
                
            }
            
            
        }
        
    }
    
    
    
    
    
    
}









