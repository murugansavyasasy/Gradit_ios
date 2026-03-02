//
//  addAcademicTV.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 04/07/25.
//

import UIKit
import DropDown

class addAcademicTV: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var ClassLbl: UILabel!
    @IBOutlet weak var PercentageLbl: UILabel!
    @IBOutlet weak var ClassField: PaddedTextField!
    @IBOutlet weak var PercentageField: PaddedTextField!
    @IBOutlet weak var SchoolLbl: UILabel!
    @IBOutlet weak var SchoolField: PaddedTextField!
    @IBOutlet weak var DeleteBtn: UIButton!
    @IBOutlet weak var InstitutetextField: UITextView!
    @IBOutlet weak var addFilesBtn: UIButton!
    @IBOutlet weak var filesCV: UICollectionView!
    @IBOutlet weak var filesCVHeight: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!

    
    var deleteAction: (() -> Void)?
    var onClassChange: ((String) -> Void)?
    var onPercentageChange: ((String) -> Void)?
    var onInstituteChange: ((String) -> Void)?
    var onAddfile: (() -> Void)?
    var onRemoveAttachment: ((Int) -> Void)?
    var attachments: [File]?
    var onPreviewFile: (([File], Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        separatorView.backgroundColor = .lightGray
        separatorView.layer.shadowColor = UIColor.gray.cgColor
        separatorView.layer.shadowOpacity = 0.2
        separatorView.layer.shadowOffset = CGSize(width: 0, height: 5)
        separatorView.layer.shadowRadius = 3
        separatorView.layer.masksToBounds = false
        
        filesCVHeight.constant = 0
        
        // Set label styles
        [ClassLbl, PercentageLbl, SchoolLbl].forEach {
            $0?.textColor = .black.withAlphaComponent(0.7)
            $0?.setFont(style: .medium, size: FontSize.title)
        }
        
        [ClassField, PercentageField, SchoolField].forEach{
            
            $0.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        }
        // Set field styles
        InstitutetextField.layer.cornerRadius = 10
        InstitutetextField.layer.borderColor = UIColor.systemGray4.cgColor
        InstitutetextField.layer.borderWidth = 1
        
        // Button action
        DeleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        filesCV.showsHorizontalScrollIndicator = false
        filesCV.showsVerticalScrollIndicator = false
        filesCV.isScrollEnabled = false
        
        filesCV.register(UINib(nibName: "AttachmentCvCell", bundle: nil), forCellWithReuseIdentifier: "AttachmentCvCell")
        filesCV.delegate = self
        filesCV.dataSource = self
    }
    
    @IBAction func deleteTapped() {
        deleteAction?()
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        
        let text = sender.text ?? ""
        switch sender {
        
        case ClassField:
            onClassChange?(text)
            
        case PercentageField:
            onPercentageChange?(text)
            
        case SchoolField:
            onInstituteChange?(text)
            
        default:
            break
        }
    }
    
    @IBAction func addFilesAct(_ sender: UIButton) {
        onAddfile?()
    }
    
    
    func configureAttachments(_ attachments: [File]) {
        self.attachments = attachments
        updateAttachmentsUI()
    }

    private func updateAttachmentsUI() {
        let row = Int(ceil(Double(attachments?.count ?? 0) / 2.0))
        let height = (row * 50) + 10
        filesCVHeight.constant = CGFloat(height)//attachments?.isEmpty ?? false ? 0 : 60
        filesCV.reloadData()
    }
}

extension addAcademicTV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filesCV.dequeueReusableCell(withReuseIdentifier: "AttachmentCvCell", for: indexPath) as! AttachmentCvCell
        
        let file = attachments?[indexPath.item]
        cell.fileNameLbl.text = file?.displayName
        cell.fileIconBtn.setTitle(file?.iconTitle, for: .normal)
        cell.fileIconBtn.backgroundColor = file?.iconColor
        
        cell.onRemove = { [weak self] in
            self?.onRemoveAttachment?(indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,didSelectItemAt indexPath: IndexPath) {

        onPreviewFile?(attachments ?? [], indexPath.item)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = filesCV.frame.width / 2
        
        return CGSizeMake(width, 50)
    }
}


extension File {

    var displayName: String {
        guard let urlString = url else { return "Document" }

        // Try URL parsing first
        if let parsedURL = URL(string: urlString) {
            return parsedURL.lastPathComponent
        }

        // Fallback (should rarely happen)
        return (urlString as NSString).lastPathComponent
    }

        var iconTitle: String {
            switch type?.lowercased() {
            case "image":
                return "IMG"
            case "pdf":
                return "PDF"
            case "doc":
                return "DOC"
            case "text":
                return "TXT"
            default:
                return "FILE"
            }
        }

        var iconColor: UIColor {
            switch type?.lowercased() {
            case "image":
                return UIColor.blue.withAlphaComponent(0.15)
            case "pdf":
                return UIColor.red.withAlphaComponent(0.15)
            case "doc":
                return UIColor.systemBlue.withAlphaComponent(0.15)
            case "text":
                return UIColor.gray.withAlphaComponent(0.15)
            default:
                return UIColor.lightGray.withAlphaComponent(0.15)
            }
        }

}
