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
    
    var countrys : [CountryData] = []
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
        
        countryTableView.delegate = self
        countryTableView.dataSource = self
    }
    
    @IBAction func countryTap() {
        countryTableView.isHidden = false
        arrowImageView.image = UIImage(named: "arrow-up")
        countryList()
    }
    
    @IBAction func nextTap() {
        
        if  countrySelectLabel.text!.isEmpty {
            nextView.isUserInteractionEnabled = true
        }else {
            
            var shortnameArr : [String] = []
            
            for listItem in countrys {
                
                if listItem.isSelected == true{
                    
                    let shortNames = listItem.country?.filter { _ in listItem.isSelected == true  } ?? ""
                    
                    shortnameArr.append(shortNames)
                }
            }
            
            let term : String = "1"
            
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
        
        let Shopres : CountryData = countrys[indexPath.row]
        
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
        
        let param : [String : Int] = ["AppId" : 1]
        
        APiCallManager.shared.callApi(
            url: APIEndpoints.countryList,
            httpMethod: .get,
            queryParam: param,
            requestBody: nil
        ) {[weak self] (result: Result<CountryListResponse, Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                countrys = success.data ?? []
                countryTableView.isHidden = false
                countryTableView.reloadData()
                
            case .failure(let failure):
                countrys = []
                countryTableView.reloadData()
            }
        }
    }
    
    func VersionCheck () {
        
        let param : [String : Any] = [
            "versionID" :DefaultsKeys.versionID,
            "device_type" : "iphone"
        ]
        
        APiCallManager.shared.callApi(url: APIEndpoints.versionCheck, httpMethod: .get, queryParam: param, requestBody: nil){[weak self] (result:Result<VersionCheckResponse,Error>) in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let success):
                
                versionCheck = success.data ?? []
                
                let defaults = UserDefaults.standard
                
                defaults.set(versionCheck.first?.videojson, forKey: DefaultsKeys.vimeoAccessToken)
                
                defaults.set(versionCheck.first?.videosizelimit, forKey: DefaultsKeys.videosizelimit)
                
                defaults.set(versionCheck.first?.videosizealert, forKey: DefaultsKeys.videosizealert)
                
                
            case .failure(let failure):
                print(failure.localizedDescription)
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





