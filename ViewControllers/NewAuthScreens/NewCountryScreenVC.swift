//
//  NewCountryScreenVC.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 20/08/26.
//

import UIKit

@available(iOS 16.0, *)
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
    
    private var countryList : [CountryData] = []
    private var selectedIndex: IndexPath?
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
        
        let fullText = "I agree to the Terms and Conditions"
        let underlineText = "Terms and Conditions"
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
                tv.reloadData()
                
            case .failure(let failure):
                countryList = []
                tv.reloadData()
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
        
        if selectedIndex == nil {
            showAlert(message: "Please select your country")
            return
        }
        
        if !isTermsAgreed {
            showAlert(message: "Please agree to the terms and conditions")
            return
        }
        
       // UserDefaults.standard.set("1", forKey: DefaultsKeys.TermsAndCondition)
        
        let selectedCountry = countryList[selectedIndex?.row ?? 0]
        if let data = try? JSONEncoder().encode(selectedCountry) {
            UserDefaults.standard.set(data, forKey: DefaultsKeys.CountryId)
        }
        
        UserDefaults.standard.set(countryList[selectedIndex!.row].baseurls,forKey: DefaultsKeys.baseUrl)
        
        let vc = MobileNumberVC()
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
}

@available(iOS 16.0, *)
extension NewCountryScreenVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tv.dequeueReusableCell(withIdentifier: "countryTvCell", for: indexPath) as? countryTvCell else { return UITableViewCell() }
        
        let country = countryList[indexPath.row]
        cell.countryNameLbl.text = country.country
        
        if selectedIndex == indexPath {
            cell.SelectionCheckbox.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }else {
            cell.SelectionCheckbox.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tv.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

@available(iOS 16.0, *)
extension NewCountryScreenVC : UISearchBarDelegate {
    
    
}
