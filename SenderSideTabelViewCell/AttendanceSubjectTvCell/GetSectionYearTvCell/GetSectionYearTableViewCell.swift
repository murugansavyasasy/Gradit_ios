//
//  GetSectionYearTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by MACBOOKPRO on 26/03/23.
//

protocol GetSectionYearCellDelegate: AnyObject {
    func didTapSave(subject: getSectionDatasDetails, indexPath: IndexPath)
}

import DropDown
import UIKit

class GetSectionYearTableViewCell: UITableViewCell,UITextFieldDelegate, UITextViewDelegate {
   
   
    @IBOutlet weak var checkSubjectImageView: UIImageView!
    @IBOutlet weak var sylubasTextView: UITextView!
    @IBOutlet weak var venueTextField: UITextField!
    @IBOutlet weak var SubjectLabel: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var sessionBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var detailsStack: UIStackView!
    
    var sessions = ["Fn", "An"]
    var sessionDropDown = DropDown()
    var subjectData: getSectionDatasDetails?
    let placeHolderLabel = UILabel()
    weak var delegate: GetSectionYearCellDelegate?
    var indexPath: IndexPath?
    var startDate: String?
    var endDate: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        venueTextField.layer.cornerRadius = 8
        venueTextField.layer.borderWidth = 1
        venueTextField.layer.borderColor = UIColor.gray.cgColor
        venueTextField.addDoneBtn()
        
        sylubasTextView.layer.cornerRadius = 8
        sylubasTextView.layer.borderWidth = 1
        sylubasTextView.layer.borderColor = UIColor.gray.cgColor
        sylubasTextView.addDoneBtn()
        
        dateBtn.layer.cornerRadius = 8
        dateBtn.layer.borderWidth = 1
        
        sessionBtn.layer.cornerRadius = 8
        sessionBtn.layer.borderWidth = 1
        
        saveBtn.layer.cornerRadius = 10
        
        venueTextField.delegate = self
        sylubasTextView.delegate = self
        
         detailsStack.isHidden = true
        
        setupSessionDropDown()
        
       
        placeHolderLabel.text = "Syllabus"
        placeHolderLabel.font = UIFont.systemFont(ofSize: 14)
        placeHolderLabel.textColor = UIColor.systemGray4
        placeHolderLabel.numberOfLines = 0

        sylubasTextView.addSubview(placeHolderLabel)

        // Use Auto Layout
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeHolderLabel.topAnchor.constraint(equalTo: sylubasTextView.topAnchor, constant: 8),
            placeHolderLabel.leadingAnchor.constraint(equalTo: sylubasTextView.leadingAnchor, constant: 5),
            placeHolderLabel.trailingAnchor.constraint(equalTo: sylubasTextView.trailingAnchor)
        ])
        
    }
    
    func setupSessionDropDown() {
        sessionDropDown.anchorView = sessionBtn
        sessionDropDown.direction = .bottom
        sessionDropDown.bottomOffset = CGPoint(x: 0, y: sessionBtn.bounds.height)
        sessionDropDown.dataSource = sessions
        
        sessionDropDown.selectionAction = {[weak self] index, item in
            self?.sessionBtn.setTitle(item, for: .normal)
            self?.sessionBtn.setTitleColor(.black, for: .normal)
            self?.subjectData?.examsession = item
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        sessionBtn.setTitle("Session", for: .normal)
        dateBtn.setTitle("DD/MM/YY", for: .normal)
        detailsStack.isHidden = true 
    }
    
    
    func configureCell(Data: getSectionDatasDetails?, indexPath: IndexPath) {
        
        self.subjectData = Data
        self.indexPath = indexPath
        
        SubjectLabel.text = Data?.subjectname
        
        venueTextField.text = Data?.examvenue
        sylubasTextView.text = Data?.examsyllabus
        
        placeHolderLabel.isHidden = !(Data?.examsyllabus?.isEmpty ?? true)
        
        if let date = Data?.examdate, !date.isEmpty {
            dateBtn.setTitle(date, for: .normal)
            dateBtn.setTitleColor(.black, for: .normal)
        }
        
        if let session = Data?.examsession, !session.isEmpty {
            sessionBtn.setTitle(session, for: .normal)
            sessionBtn.setTitleColor(.black, for: .normal)
        }
    }
    
    
    @IBAction func saveBtnAct(_ sender: Any) {
        
        guard let subject = subjectData,
              let indexPath = indexPath else { return }
        
        // Trim values to avoid spaces-only input
        let venue = venueTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let syllabus = sylubasTextView.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let date = subject.examdate ?? ""
        let session = subject.examsession ?? ""
        
        // ✅ Validation checks
        if venue.isEmpty {
            showAlert(title: "Validation",message: "Please enter exam venue")
            return
        }
        
        if syllabus.isEmpty {
            showAlert(title: "Validation",message: "Please enter syllabus")
            return
        }
        
        if date.isEmpty {
            showAlert(title: "Validation",message: "Please select exam date")
            return
        }
        
        if session.isEmpty {
            showAlert(title: "Validation",message: "Please select session (FN/AN)")
            return
        }
        
        // ✅ Assign values back to model (important)
        subjectData?.examvenue = venue
        subjectData?.examsyllabus = syllabus
        subjectData?.isSaved = true
        // ✅ Pass valid data
        delegate?.didTapSave(subject: subjectData!, indexPath: indexPath)
        
        showAlert(title: "Success", message: "Exam details saved successfully")
    }
    
    func showAlert(title: String, message: String) {
        
        guard let vc = self.parentViewController else { return }
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        vc.present(alert, animated: true)
    }
    
    @IBAction func dateBtnAct(_ sender: UIButton) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let minDate = formatter.date(from: startDate ?? "")
        let maxDate = formatter.date(from: endDate ?? "")
        
        RPicker.selectDate(title: "Select Exam Date",
                           cancelText: "Cancel",
                           datePickerMode: .date,
                           minDate: minDate,   // ✅ key logic
                           maxDate: maxDate,
                           style: .Inline,
                           didSelectDate: { [weak self] selectedDate in
            
            guard let self = self else { return }
            
            let display = selectedDate.dateString("dd/MM/yyyy")
            
            dateBtn.setTitle(display, for: .normal)
            dateBtn.setTitleColor(.black, for: .normal)
            subjectData?.examdate = display
        })
    }
    
    @IBAction func sessionBtnAct(_ sender: UIButton) {
        
        sessionDropDown.show()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        placeHolderLabel.isHidden = !textView.text.isEmpty
        subjectData?.examsyllabus = textView.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        subjectData?.examvenue = textField.text
    }
    
}
