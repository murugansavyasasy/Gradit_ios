//
//  ExameCreationTableViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 11/10/23.
//

protocol ExameCreationCellDelegate: AnyObject {
    func didUpdateSubject(sectionIndex: Int,
                          subjectIndex: Int,
                          subject: getSectionDatasDetails)
}

import UIKit
import DropDown
import ObjectMapper

@available(iOS 16.0, *)
class ExameCreationTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate, GetSectionYearCellDelegate {
    
    
    @IBOutlet weak var secionOverAllView: UIViewX!
    @IBOutlet weak var arrowImgeView: UIImageView!
    @IBOutlet weak var SubjectTabelView: UITableView!
    @IBOutlet weak var sectionCheckBox: CheckBoxThree!
    @IBOutlet weak var sectionLbl: UILabel!
    @IBOutlet weak var innerTableHeight: NSLayoutConstraint!
    
    var subjectList: [getSectionDatasDetails]?
    var selectedIndex: IndexPath?
    weak var delegate: ExameCreationCellDelegate?
    var sectionIndex: Int?
    var fromDate: String?
    var toDate: String?
    var isExpanded: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let rowNib = UINib(nibName: "GetSectionYearTableViewCell", bundle: nil)
        SubjectTabelView.register(rowNib, forCellReuseIdentifier: "GetSectionYearTableViewCell")
        
        
        SubjectTabelView.dataSource = self
        SubjectTabelView.delegate = self
        
        SubjectTabelView.rowHeight = UITableView.automaticDimension
           SubjectTabelView.estimatedRowHeight = 100
           SubjectTabelView.isScrollEnabled = false
        innerTableHeight.constant = 0
       
        
    }
    
    func configure(sectionName: String,
                       subjects: [getSectionDatasDetails],
                       isExpand: Bool) {
            
            sectionLbl.text = sectionName
            self.subjectList = subjects
            self.isExpanded = isExpand
            
            if isExpand {
                calculateHeight()
            } else {
                innerTableHeight.constant = 0
            }
        }
    
    private func calculateHeight() {
            
            SubjectTabelView.reloadData()
            SubjectTabelView.layoutIfNeeded()
            
            // force all cells layout
            for cell in SubjectTabelView.visibleCells {
                cell.layoutIfNeeded()
            }
            
            let height = SubjectTabelView.contentSize.height
            innerTableHeight.constant = height
            
            // update parent table
            DispatchQueue.main.async {
                if let tableView = self.parentTableView() {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        }
    
    private func parentTableView() -> UITableView? {
           var view = self.superview
           while view != nil && !(view is UITableView) {
               view = view?.superview
           }
           return view as? UITableView
       }
    
//    func configure(sectionName: String,subjects: [getSectionDatasDetails],isExpand: Bool) {
//        
//        sectionLbl.text = sectionName
//        self.subjectList = subjects
//        
//        SubjectTabelView.reloadData()
//        SubjectTabelView.layoutIfNeeded()
//        
//        if isExpand {
//            updateInnerTableHeight()
//        } else {
//            innerTableHeight.constant = 0
//        }
//    }
    
    private func updateInnerTableHeight() {
        
        // Ensure correct width before calculating height
      //  SubjectTabelView.frame.size.width = contentView.frame.width
        
        SubjectTabelView.layoutIfNeeded()
        
        let height = SubjectTabelView.contentSize.height
        print("FINAL contentSize:", height)
        
        innerTableHeight.constant = height

//        if let parentTable = self.superview as? UITableView {
//            parentTable.beginUpdates()
//            parentTable.endUpdates()
//        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        guard innerTableHeight.constant != 0 else { return }
//        
//        SubjectTabelView.layoutIfNeeded()
//        innerTableHeight.constant = SubjectTabelView.contentSize.height
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectedIndex = nil
        subjectList = []
        innerTableHeight.constant = 0
        isExpanded = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subjectList?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SubjectTabelView.dequeueReusableCell(withIdentifier: "GetSectionYearTableViewCell", for: indexPath) as! GetSectionYearTableViewCell
        
        cell.configureCell(Data: subjectList?[indexPath.row], indexPath: indexPath)
        cell.detailsStack.isHidden = (selectedIndex == indexPath) ? false : true
        cell.startDate = fromDate
        cell.endDate = toDate
        cell.delegate = self
        cell.indexPath = indexPath
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndex == indexPath{
            self.selectedIndex = nil
        }else{
            self.selectedIndex = indexPath
        }
        
        calculateHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func didTapSave(subject: getSectionDatasDetails, indexPath: IndexPath) {
        
        guard let sectionIndex = sectionIndex else { return }
        
        // Update local array (important for UI consistency)
        subjectList?[indexPath.row] = subject
        
        // 🔥 Forward to ViewController
        delegate?.didUpdateSubject(
            sectionIndex: sectionIndex,
            subjectIndex: indexPath.row,
            subject: subject
        )
    }
}

