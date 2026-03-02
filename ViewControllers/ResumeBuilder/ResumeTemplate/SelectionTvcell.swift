//
//  SelectionTvcell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 15/07/25.
//

import UIKit

class SelectionTvcell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var SelectBtn: UIButton!
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    
    var datasource = [""]
    var width: Double?
    var selectedItems: [String] = []
    var onSelectionChanged: (([String]) -> Void)?
    var isAllSelected: Bool = true
    var internDate = [""]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.SelectBtn.tintColor =  UIColor(named: "IndigoColour")
        TitleLbl.setFont(style: .semibold, size: FontSize.title)
        SelectBtn.setTitleFont(style: .medium, size: FontSize.title)
        cv.register(UINib(nibName: "SoftSkillCV", bundle: nil), forCellWithReuseIdentifier: "SoftSkillCV")
        cv.delegate = self
        cv.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectAllTapped() {
        if isAllSelected {
            selectedItems = []
            SelectBtn.setImage(UIImage(systemName: "square"), for: .normal)
            self.SelectBtn.tintColor =  .systemGray4
        } else {
            selectedItems = datasource
            self.SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.SelectBtn.tintColor =  UIColor(named: "IndigoColour")
        }
        isAllSelected.toggle()
        onSelectionChanged?(selectedItems)
        cv.reloadData()
    }
    
    private func updateSelectButtonState() {
            if selectedItems.count == datasource.count {
                SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                SelectBtn.tintColor = UIColor(named: "IndigoColour")
            } else {
                SelectBtn.setImage(UIImage(systemName: "square"), for: .normal)
                SelectBtn.tintColor = .systemGray4
            }
        }

    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        cv.collectionViewLayout.invalidateLayout()
//    }

//    func configure(with data: [String]) {
//        print("data",data)
//        self.datasource = data
//        self.selectedItems = data
//        isAllSelected = true
//        self.SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
//        self.SelectBtn.tintColor =  UIColor(named: "IndigoColour")
//        self.onSelectionChanged?(selectedItems)
//        cvHeight.constant = CGFloat(data.count * 40)
//        cv.reloadData()
////        self.layoutIfNeeded()
//       // self.cv.layoutIfNeeded()
////        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
////                guard let self = self else { return }
////                self.cv.collectionViewLayout.invalidateLayout()
////                self.cv.reloadData()
////            }
//    }
    
    func configure(with data: [String], selectedItems: [String]) {
        self.datasource = data
        self.selectedItems = selectedItems // ✅ GOOD: preserve external selection
        isAllSelected = selectedItems.count == data.count
        SelectBtn.setImage(UIImage(systemName: isAllSelected ? "checkmark.square" : "square"), for: .normal)
        SelectBtn.tintColor = isAllSelected ? UIColor(named: "IndigoColour") : .systemGray4
        //onSelectionChanged?(self.selectedItems)
        cvHeight.constant = CGFloat(data.count * 50)
        cv.reloadData()
//        DispatchQueue.main.async {
//                self.cv.layoutIfNeeded()
//            let height = self.cv.collectionViewLayout.collectionViewContentSize.height
//            self.cvHeight.constant = height
//            }
    }
    
    
    func configure2(with data: [String], date: [String]) {
        print("data",data)
        self.datasource = data
        self.internDate = date
        if selectedItems.isEmpty {
            selectedItems = data
        }
       // self.selectedItems = data
        isAllSelected = true
        self.SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        self.SelectBtn.tintColor =  UIColor(named: "IndigoColour")
        self.onSelectionChanged?(selectedItems)
        cvHeight.constant = CGFloat(data.count * 50)
        self.layoutIfNeeded()
        self.cv.layoutIfNeeded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }
                self.cv.collectionViewLayout.invalidateLayout()
                self.cv.reloadData()
            }
    }
    
}

extension SelectionTvcell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = datasource[indexPath.item]
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "SoftSkillCV", for: indexPath) as! SoftSkillCV
        cell.OptionBtn.setTitle(datasource[indexPath.item], for: .normal)
        
        cell.configure2(title: item, isSelected: selectedItems.contains(item))
        cell.onSelectionChanged = { [weak self] in
            guard let self = self else {return}
            
            if let index = self.selectedItems.firstIndex(of: item) {
                self.selectedItems.remove(at: index)
                self.SelectBtn.setImage(UIImage(systemName: "square"), for: .normal)
                self.SelectBtn.tintColor =  .systemGray4
            } else {
                self.selectedItems.append(item)
                if self.selectedItems.count == self.datasource.count {
                    self.SelectBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                    self.SelectBtn.tintColor =  UIColor(named: "IndigoColour")
                    self.isAllSelected = true
                }
            }
            self.onSelectionChanged?(self.selectedItems)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let DefWidth = cv.frame.width
        return CGSize(width: DefWidth, height: 50)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let title = datasource[indexPath.row]
//
//      // 2. Define the font used by the button
//      let font = UIFont.systemFont(ofSize: 14)      // match your button.titleLabel?.font
//
//      // 3. Calculate the maximum width for the text
//      //    If you have section insets or content insets, subtract them here
//      let maxTextWidth = collectionView.bounds.width - 16  // e.g. 8pt horizontal padding each side
//
//      // 4. Measure the bounding rect with infinite height
//      let textRect = title.boundingRect(
//        with: CGSize(width: maxTextWidth, height: .greatestFiniteMagnitude),
//        options: .usesLineFragmentOrigin,
//        attributes: [.font: font],
//        context: nil
//      )
//
//      // 5. Add vertical padding around the button’s title
//      let verticalPadding: CGFloat = 4  // e.g. 6pt top + 6pt bottom
//      let cellHeight = ceil(textRect.height) + verticalPadding
//
//      // Return full-width cell with dynamic height
//      return CGSize(width: collectionView.bounds.width, height: cellHeight)
//    }

}
