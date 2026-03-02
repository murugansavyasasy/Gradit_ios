//
//  SkillSetsTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit

protocol SkillSelectionDelegate: AnyObject {
    func didSelectSkills(_ selectedSkills: [String])
}

class SkillSetsTv: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate {
    
    @IBOutlet weak var LanguageKnownLbl: UILabel!
    @IBOutlet weak var LanguagesField: PaddedTextField!
    @IBOutlet weak var SoftSkillsLbl: UILabel!
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var AreasOfInterestLbl: UILabel!
    @IBOutlet weak var AreasField: PaddedTextField!
    @IBOutlet weak var CvHeight: NSLayoutConstraint!
    @IBOutlet weak var SkillSetFieldHeight: NSLayoutConstraint!
    @IBOutlet weak var AreaTextview: AutoGrowingTextView!
    
    @IBOutlet weak var LanguageTextview: AutoGrowingTextView!
    
    var onLanguageField: ((String) -> Void)?
    var onAreasField: ((String) -> Void)?
    var softSkills: [String] = []
    var selectedSkills: [String] = []
    weak var delegate: SkillSelectionDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        LanguageKnownLbl.setFont(style: .medium, size: FontSize.title)
        SoftSkillsLbl.setFont(style: .medium, size: FontSize.title)
        AreasOfInterestLbl.setFont(style: .medium, size: FontSize.title)
        LanguagesField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        AreasField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        AreaTextview.delegate = self
        LanguageTextview.delegate = self
        AreaTextview.placeholder = "Enter comma separated"
        LanguageTextview.placeholder = "Enter comma separated"
        
        cv.register(UINib(nibName: "SoftSkillCV", bundle: nil),forCellWithReuseIdentifier: "SoftSkillCV")
        
        cv.delegate = self
        cv.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with skills: [String], selected: [String]) {
        self.softSkills = skills
        self.selectedSkills = selected
        let height = ceil(Double(softSkills.count / 2))
        CvHeight.constant = height * 50
        cv.reloadData()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView == AreaTextview{
            onAreasField?(textView.text)
        }else {
            onLanguageField?(textView.text)
        }
        
        if let tableView = self.superview(of: UITableView.self) {
                UIView.setAnimationsEnabled(false)
                tableView.beginUpdates()
                tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
            
        case LanguagesField:
            onLanguageField?(text)
            
        case AreasField:
            onAreasField?(text)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return softSkills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "SoftSkillCV", for: indexPath) as! SoftSkillCV
        let skill = softSkills[indexPath.item]
        let isSelected = selectedSkills.contains(skill)
        cell.OptionBtn.isUserInteractionEnabled = false
        cell.configure(skill: skill, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let skill = softSkills[indexPath.item]
            if selectedSkills.contains(skill) {
                selectedSkills.removeAll { $0 == skill }
            } else {
                selectedSkills.append(skill)
            }
            delegate?.didSelectSkills(selectedSkills)
            collectionView.reloadData()
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = cv.frame.width / 2
        return CGSize(width: width, height: 50)
    }
}



extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: T.self)
    }
}
