//
//  CountryListViewController.swift
//  GraditLoginApp
//
//  Created by MACBOOKPRO on 15/10/22.
//

import UIKit
import ObjectMapper

@available(iOS 16.0, *)
class CountryListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


@IBOutlet weak var arrowImageView: UIImageView!
@IBOutlet weak var countrySelectLabel: UILabel!

@IBOutlet weak var countryTextField: UITextField!


@IBOutlet weak var selectCountryView: UIViewX!

@IBOutlet weak var countryTableView: UITableView!

@IBOutlet weak var nextView: UIViewX!


@IBOutlet weak var upDownArrowView: UIView!


var countrys : [dataDetails] = []
var identifer = "CountryTableViewCell"

var countryName : String!


var versionCheck : [VersionCheckData] = []
override func viewDidLoad() {
    super.viewDidLoad()
    
    
    overrideUserInterfaceStyle = .light
    countrySelectLabel.text = "--Select Country--"
    
    
    let  tapGesture = UITapGestureRecognizer(target: self, action: #selector(countryTap))
    
    selectCountryView.addGestureRecognizer(tapGesture)
    
    countryTableView.isHidden = false
    
    let rownib = UINib(nibName: identifer, bundle: nil)
    countryTableView.register(rownib, forCellReuseIdentifier: identifer)
    
    
    
}

@IBAction func countryTap() {
    
    
    
    countryTableView.isHidden = false
    
    arrowImageView.image = UIImage(named: "arrow-up")
    
    countryList()
}

@IBAction func nextTap() {
    
    if  countrySelectLabel.text!.isEmpty {
        
        nextView.isUserInteractionEnabled = true
        
        
    }
    
    
    
    
    
    else {
        
        
        
        
        var shortnameArr : [String] = []
        
        
        for listItem in countrys {
            
            if listItem.isSelected == true{
                
                
                let shortNames = listItem.country.filter { _ in listItem.isSelected == true  }
                
                
                
                
                shortnameArr.append(shortNames)
                
                
                
            }
            
            else{
                
            }
        }
        
        
        var term : String = "1"
        
        let userDefault = UserDefaults.standard
        userDefault.set(term, forKey: DefaultsKeys.CountryId)
        
        let vc = LoginNewViewController(nibName: nil, bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
        
    }
    
}


func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return countrys.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as!
    CountryTableViewCell
    
    let Shopres : dataDetails = countrys[indexPath.row]
    
    cell.cellPhnLable.text = "+\(Shopres.codecountry!)"
    
    cell.cellPhnNumberLable.text = Shopres.country
    
    countryName = Shopres.country
    
    
    
    
    if nextView.backgroundColor == UIColor(named: "Next") {
        
        let tapNext = UITapGestureRecognizer(target: self, action: #selector(nextTap))
        
        nextView .addGestureRecognizer(tapNext)
        
        
        
    }else{
        
        cell.countryCellView.isHidden = false
        print("NextView Not Access")
    }
    
    let selectedGestures = CheckBoxGesturess(target: self, action: #selector(changeSelection))
    
    selectedGestures.checkBoxss = cell.checkView
    selectedGestures.baseURl = countrys[indexPath.row].baseurls
    selectedGestures.pos = indexPath.row
    cell.checkView.addGestureRecognizer(selectedGestures)
    
    
    
    return cell
}





@IBAction func changeSelection(gesture : CheckBoxGesturess){
    
    
    if countrys[gesture.pos].isSelected == true{
        
        countrys[gesture.pos].isSelected = false
        
        countrySelectLabel.text = ""
        nextView.backgroundColor = UIColor.gray
        
        gesture.checkBoxss.setImage(UIImage.init(named: "checkbox"), for: .normal)
        
    }else{
        
        gesture.checkBoxss.setImage(UIImage.init(named: "radio"), for: .normal)
        countryTableView.isHidden = true
       // Constant.baseUrl = (gesture.baseURl ?? "https://www.thegradit.com/")+"api/AppDetailsBal/"
        arrowImageView.image = UIImage(named: "download")
        countrySelectLabel.text = countryName
        VersionCheck ()
        countrys[gesture.pos].isSelected = true
        nextView.backgroundColor = UIColor(named: "Next")
        
    }
    
    countryTableView.reloadData()
    
    
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
}


func countryList () {
    let param : [String : String] =
    [
        
        "AppId" : "1"
        
    ]
    
    CountryListRequest.call_request(param: param){ [self]
        (res) in
        let countryResponse : CountryListResponse =
        Mapper<CountryListResponse>().map(JSONString: res)!
        PreferencesUtil.saveToPrefs(key: Constant.CountryResponse, value: res)
        
        countrys = countryResponse.data
        print("countryResponse",countryResponse)
        countryTableView.isHidden = false
        countryTableView.delegate = self
        countryTableView.dataSource = self
        countryTableView.reloadData()
        
    }
    
}



func VersionCheck () {
    
    let defaults = UserDefaults.standard
    let param : [String : Any] =
    [
        
        "versionID" :DefaultsKeys.versionID,
        
        "device_type" : "iphone"
    ]
    
    
    VersionCheckRequest.call_request(param: param)  {
        
        [self] (res) in
        
        let VersionUpdate : VersionCheckResponce = Mapper<VersionCheckResponce>().map(JSONString: res)!
        
        
        versionCheck = VersionUpdate.versionData
        if VersionUpdate.Status == 1 {
            
            for i in versionCheck {
                
                print("DefaultsKeys.123",i.videojson)
                let defaults = UserDefaults.standard
                
                defaults.set(i.videojson, forKey: DefaultsKeys.vimeoAccessToken)
                
                defaults.set(i.videosizelimit, forKey: DefaultsKeys.videosizelimit)
                
                defaults.set(i.videosizealert, forKey: DefaultsKeys.videosizealert)
                
                
                print("DefaultsKeys.vimeoAccessToken",DefaultsKeys.vimeoAccessToken)
                print("DefaultsKeys.",i.videojson)
            }
            
            
            print("VersionCheckSuccess")
        }
    }
}

}






class CheckBoxGesturess : UITapGestureRecognizer {

var pos : Int!

var memberName : String!

var checkBoxss : CheckBox!
var baseURl : String?

}





