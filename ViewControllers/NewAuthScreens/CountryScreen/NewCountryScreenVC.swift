//
//  NewCountryScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

@available(iOS 16.0, *)
class NewCountryScreenVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var logoImgview: UIImageView!
    @IBOutlet weak var selectCountryLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var CheckBoxBtn: UIButton!
    @IBOutlet weak var agreeTermsLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nodataImage: UIImageView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    private var countryList : [CountryData] = []
    private var FiltercountryList : [CountryData] = []
    private var selectedCountry: CountryData?
    private var termsRange : NSRange?
    private var isTermsAgreed : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.layer.cornerRadius = 40
        baseView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.searchTextField.addDoneBtn()
        searchBar.delegate = self
        nextBtn.layer.cornerRadius = 10
        
        nodataImage.isHidden = true
        noDataLbl.isHidden = true
        
        let fullText = "I agree to the Terms & Conditions"
        let underlineText = "Terms & Conditions"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: underlineText){
            termsRange = NSRange(range, in: fullText)
            
            attributedString.addAttributes([.foregroundColor: UIColor.systemBlue, .underlineStyle: NSUnderlineStyle.single.rawValue], range: termsRange!)
        }
        agreeTermsLbl.attributedText = attributedString
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(clickTermsUrl))
        agreeTermsLbl.addGestureRecognizer(tapgesture)
        
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
                FiltercountryList = countryList
                tv.reloadData()
                
                if countryList.isEmpty {
                    nodataImage.isHidden = false
                    noDataLbl.isHidden = false
                }else{
                    nodataImage.isHidden = true
                    noDataLbl.isHidden = true
                }
                
                noDataLbl.text = success.Message
                
            case .failure(let failure):
                countryList = []
                FiltercountryList = countryList
                tv.reloadData()
                nodataImage.isHidden = false
                noDataLbl.isHidden = false
                noDataLbl.text = failure.localizedDescription
            }
        }
    }
    
    @IBAction func clickTermsUrl(_ gesture : UITapGestureRecognizer){
        
        guard let range = termsRange else { return }
        guard let label = gesture.view as? UILabel,
              let attributedText = label.attributedText else { return }
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: label.bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.lineBreakMode = label.lineBreakMode
        let location = gesture.location(in: label)
        let index = layoutManager.characterIndex(
            for: location,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        if NSLocationInRange(index, range) {
            openTermsVC()
        }
    }
    
    func openTermsVC() {
        let vc = MenuTermsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func bactBtnAct(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func checkBoxAct(_ sender: UIButton) {
        
        isTermsAgreed.toggle()
        if isTermsAgreed {
            CheckBoxBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }else{
            CheckBoxBtn.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func nextBtnAct(_ sender: Any) {
        
        guard let selectedCountry = selectedCountry else {
            showAlert(message: "Please select your country")
            return
        }
        
        guard isTermsAgreed else{
            showAlert(message: "Please agree to the terms and conditions")
            return
        }
        
       // UserDefaults.standard.set("1", forKey: DefaultsKeys.TermsAndCondition)
        UserDefaults.standard.set("1", forKey: DefaultsKeys.CountryId)
        
        if let data = try? JSONEncoder().encode(selectedCountry) {
            UserDefaults.standard.set(data, forKey: DefaultsKeys.SelectedCountry)
        }
        
        UserDefaults.standard.set(selectedCountry.baseurls,forKey: DefaultsKeys.baseUrl)
        
        let vc = MobileNumberVC()
        vc.HideBackBtn = false
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )

        present(alert, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if text.isEmpty {
            FiltercountryList = countryList
        }else {
            FiltercountryList = countryList.filter { country in
                country.country?.lowercased().contains(text) ?? false ||
                country.codecountry?.lowercased().contains(text) ?? false
            }
        }
        
        tv.reloadData()
        
        if FiltercountryList.isEmpty {
            nodataImage.isHidden = false
            noDataLbl.isHidden = false
            noDataLbl.text = "No Data Found!"
        }else {
            nodataImage.isHidden = true
            noDataLbl.isHidden = true
        }
    }
}

@available(iOS 16.0, *)
extension NewCountryScreenVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return FiltercountryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tv.dequeueReusableCell(withIdentifier: "countryTvCell", for: indexPath) as? countryTvCell else { return UITableViewCell() }
        
        let country = FiltercountryList[indexPath.row]
        cell.countryNameLbl.text = country.country
        let flag_url = URL(string: "https://www.worldometers.info//img/flags/small/tn_in-flag.gif")
        cell.flagImageView.sd_setImage(with: flag_url, placeholderImage: UIImage(named: "gradit_logo"))
        if let selectedCountry = selectedCountry,
           selectedCountry.country == country.country
        {
            cell.SelectionCheckbox.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.SelectionCheckbox.tintColor = .systemGreen
        }else {
            cell.SelectionCheckbox.setImage(UIImage(systemName: "circle"), for: .normal)
            cell.SelectionCheckbox.tintColor = .lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = FiltercountryList[indexPath.row]
        tv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
