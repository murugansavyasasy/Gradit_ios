//
//  NewCountryScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

class NewCountryScreenVC: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var logoImgview: UIImageView!
    @IBOutlet weak var selectCountryLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var CheckBoxBtn: UIButton!
    @IBOutlet weak var agreeTermsLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    
    var countryList : [CountryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.layer.cornerRadius = 40
        baseView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        tv.register(UINib(nibName: "countryTvCell", bundle: nil), forCellReuseIdentifier: "countryTvCell")
        tv.delegate = self
        tv.dataSource = self
        
        Get_CountryList()
    }
    
    func Get_CountryList() {
        
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
                
                countryList = success.data ?? []
                tv.reloadData()
                
            case .failure(let failure):
                countryList = []
                tv.reloadData()
            }
        }
    }
    
    @IBAction func bactBtnAct(_ sender: Any) {
    }
    
    @IBAction func checkBoxAct(_ sender: UIButton) {
    }
    
    @IBAction func nextBtnAct(_ sender: Any) {
    }
    
}

extension NewCountryScreenVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tv.dequeueReusableCell(withIdentifier: "countryTvCell", for: indexPath) as? countryTvCell else { return UITableViewCell() }
        
        let country = countryList[indexPath.row]
        cell.countryNameLbl.text = country.country
        return cell
    }
    
    
}
