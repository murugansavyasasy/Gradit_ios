//
//  InternshipTv.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 11/07/25.
//

import UIKit


class InternshipTv: UITableViewCell, UITextFieldDelegate, Datepicker {

    @IBOutlet weak var CompanyName: UILabel!
    @IBOutlet weak var CompanyField: PaddedTextField!
    @IBOutlet weak var RoleLbl: UILabel!
    @IBOutlet weak var RoleField: PaddedTextField!
    @IBOutlet weak var PeriodLbl: UILabel!
    @IBOutlet weak var FromField: TextfieldWithImage!
    @IBOutlet weak var ToField: TextfieldWithImage!
    @IBOutlet weak var RemoveBtn: UIButton!
    
    @IBOutlet weak var FromDateView: UIView!
    @IBOutlet weak var TodateView: UIView!
    @IBOutlet weak var FromDateLbl: UILabel!
    @IBOutlet weak var ToDateLbl: UILabel!
    
    var onCompanyChange: ((String) -> Void)?
    var onRoleChange: ((String) -> Void)?
    var onFromChange: ((String) -> Void)?
    var onToChange: ((String) -> Void)?
    var deleteAction: (() -> Void)?
    var isFrom = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        FromDateView.layer.borderWidth = 1
        TodateView.layer.borderWidth = 1
        
        FromDateView.layer.borderColor = UIColor.systemGray4.cgColor
        TodateView.layer.borderColor = UIColor.systemGray4.cgColor
        
        FromDateView.layer.cornerRadius = 10
        TodateView.layer.cornerRadius = 10
        
        CompanyName.setFont(style: .medium, size: FontSize.title)
        RoleLbl.setFont(style: .medium, size: FontSize.title)
        PeriodLbl.setFont(style: .medium, size: FontSize.title)
        FromDateLbl.setFont(style: .regular, size: FontSize.title)
        ToDateLbl.setFont(style: .regular, size: FontSize.title)
        
        CompanyField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        RoleField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        FromField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        ToField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        RemoveBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        if #available(iOS 14.0, *) {
            FromDateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDatePicker)))
            TodateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDatePicker2)))
        } else {
            // Fallback on earlier versions
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        
        switch sender {
            
        case CompanyField:
            onCompanyChange?(text)
            
        case RoleField:
            onRoleChange?(text)
            
        case FromField:
            onFromChange?(text)
            
        case ToField:
            onToChange?(text)
            
        default:
            break
        }
    }
    
    @objc func deleteTapped() {
        
        deleteAction?()
    }
    
    @available(iOS 14.0, *)
    @objc func showDatePicker() {
        isFrom = true
           guard let vc = parentViewController else { return }

           let picker = DatePickerVC()
           picker.modalPresentationStyle = .overCurrentContext
           picker.delegate = self
           picker.dateSelection = 2
           picker.date = FromDateLbl.text
           picker.view.backgroundColor = .black.withAlphaComponent(0.6)
           vc.present(picker, animated: false)
       }
    
    @available(iOS 14.0, *)
    @objc func showDatePicker2() {
        isFrom = false
           guard let vc = parentViewController else { return }

           let picker = DatePickerVC()
           picker.modalPresentationStyle = .overCurrentContext
           picker.delegate = self
           picker.dateSelection = 2
           picker.date = FromDateLbl.text
           picker.view.backgroundColor = .black.withAlphaComponent(0.6)
           vc.present(picker, animated: false)
       }

       // MARK: - Datepicker delegate method
       func date(date: String) {
           if isFrom{
               FromDateLbl.text = date
               onFromChange?(date)
           }else {
               ToDateLbl.text = date
               onToChange?(date)
           }
       }

}

extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let r = responder {
            if let vc = r as? UIViewController {
                return vc
            }
            responder = r.next
        }
        return nil
    }
}
