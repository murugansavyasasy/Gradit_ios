//
//  PlacementEventTvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 24/08/25.
//

import UIKit

// MARK: - PlacementEventTvCell
class PlacementEventTvCell: UITableViewCell,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var placementDefView: UIView!
    @IBOutlet weak var dateBaseView: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var eventNameLbl: UILabel!
    @IBOutlet weak var eventDescriptionLbl: UILabel!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var companiesCV: UICollectionView!
    @IBOutlet weak var eligibleCourseDefLbl: UILabel!
    @IBOutlet weak var eligibleCoursesLbl: UILabel!
    @IBOutlet weak var eligibilityCriteriaDefLbl: UILabel!
    @IBOutlet weak var EligibilityCriteriaLbl: UILabel!
    @IBOutlet weak var selectionProcessDefLbl: UILabel!
    @IBOutlet weak var SelectionProcessCV: UICollectionView!
    @IBOutlet weak var companiesCVHeight: NSLayoutConstraint!
    @IBOutlet weak var SelectionProcessCVHeight: NSLayoutConstraint!
    @IBOutlet weak var eventModeBaseView: UIView!
    @IBOutlet weak var eventModeLbl: UILabel!
    
    @IBOutlet weak var trainingTimeStack: UIStackView!
    @IBOutlet weak var selectionProcessStack: UIStackView!
    @IBOutlet weak var scheduledTimeDefLbl: UILabel!
    @IBOutlet weak var scheduledTimeLbl: UILabel!
    @IBOutlet weak var repeatsonLbl: UILabel!
    @IBOutlet weak var PlacementEventDefLbl: UILabel!
    
    @IBOutlet weak var repeatsOnBaseView: UIView!
    
    var companyDetails: [CompanyDetail] = []
    var selectionProcess: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Cell UI
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.systemGray4.cgColor
        placementDefView.layer.cornerRadius = 12
        
        eventModeBaseView.layer.cornerRadius = 12
        
        dateBaseView.layer.cornerRadius = dateBaseView.frame.width / 2
        
        eventNameLbl.setFont(style: .semibold, size: FontSize.header)
        dateLbl.setFont(style: .medium, size: FontSize.body)
        timeLbl.setFont(style: .medium, size: FontSize.body)
        eventDescriptionLbl.setFont(style: .regular, size: FontSize.title)
        eventDescriptionLbl.setFont(style: .regular, size: FontSize.body)
        locationBtn.setTitleFont(style: .medium, size: FontSize.title)
//        repeatsonBtn.setTitleFont(style: .medium, size: FontSize.title)
//        repeatsonBtn.titleLabel?.numberOfLines = 0
//        repeatsonBtn.titleLabel?.lineBreakMode = .byWordWrapping

        eventModeLbl.setFont(style: .medium, size: FontSize.title)
        
        eligibleCourseDefLbl.setFont(style: .regular, size: FontSize.body)
        eligibilityCriteriaDefLbl.setFont(style: .regular, size: FontSize.body)
        selectionProcessDefLbl.setFont(style: .regular, size: FontSize.body)
        scheduledTimeDefLbl.setFont(style: .regular, size: FontSize.body)
        
        eligibleCoursesLbl.setFont(style: .semibold, size: FontSize.body)
        EligibilityCriteriaLbl.setFont(style: .semibold, size: FontSize.body)
        scheduledTimeLbl.setFont(style: .semibold, size: FontSize.body)
        
        PlacementEventDefLbl.setFont(style: .regular, size: FontSize.body)
        
        
        // Register collection view cell
        companiesCV.register(UINib(nibName: "PlacementCVcell", bundle: nil),
                             forCellWithReuseIdentifier: "PlacementCVcell")
        SelectionProcessCV.register(UINib(nibName: "PlacementCVcell", bundle: nil),
                                    forCellWithReuseIdentifier: "PlacementCVcell")
        
        companiesCV.delegate = self
        companiesCV.dataSource = self
        SelectionProcessCV.delegate = self
        SelectionProcessCV.dataSource = self
        
        // Layout for companiesCV
        if let layout = companiesCV.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.sectionInset = .zero
        }
        companiesCV.isScrollEnabled = false
        
        // Layout for SelectionProcessCV (left aligned)
        let selectionLayout = LeftAlignedCollectionViewFlowLayout()
        selectionLayout.scrollDirection = .vertical
        selectionLayout.minimumInteritemSpacing = 8
        selectionLayout.minimumLineSpacing = 8
        selectionLayout.sectionInset = .zero
        SelectionProcessCV.collectionViewLayout = selectionLayout
        SelectionProcessCV.isScrollEnabled = false
    }
    
    func configure(first: [CompanyDetail], second: [String]) {
        self.companyDetails = first
        self.selectionProcess = second
        companiesCV.reloadData()
        SelectionProcessCV.reloadData()
        
        // Let Auto Layout finish, then update heights
        DispatchQueue.main.async {
            self.companiesCVHeight.constant = self.companiesCV.collectionViewLayout.collectionViewContentSize.height
            self.SelectionProcessCVHeight.constant = self.SelectionProcessCV.collectionViewLayout.collectionViewContentSize.height
            
            // Ask table view to re-measure
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }

    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collectionView == companiesCV ? companyDetails.count : selectionProcess.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacementCVcell", for: indexPath) as! PlacementCVcell
        if collectionView == companiesCV {
            cell.label.setFont(style: .regular, size: FontSize.body)
            cell.label.text = companyDetails[indexPath.item].companyName
            let imageUrl = URL(string: companyDetails[indexPath.item].logo ?? "")
            cell.imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(systemName: ""))
        } else {
            cell.label.setFont(style: .semibold, size: FontSize.body)
            cell.label.text = selectionProcess[indexPath.item]
            cell.imageView.image = UIImage(named: "TickImage")
        }
        cell.label.numberOfLines = 0 // allow wrapping
        return cell
    }
    
    // MARK: - 3 per row with dynamic height
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpacing = flowLayout.minimumInteritemSpacing * (itemsPerRow - 1) +
                           flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = floor(availableWidth / itemsPerRow)
        
        // Measure height based on text
        let sizingLabel = UILabel()
        sizingLabel.numberOfLines = 0
        sizingLabel.font = UIFont.systemFont(ofSize: 14)
        
        if collectionView == companiesCV {
            sizingLabel.text = companyDetails[indexPath.item].companyName
        } else {
            sizingLabel.text = selectionProcess[indexPath.item]
        }
        
        let targetSize = CGSize(width: cellWidth - 16, height: CGFloat.greatestFiniteMagnitude) // subtract padding
        let estimatedSize = sizingLabel.sizeThatFits(targetSize)
        let cellHeight = estimatedSize.height + 16 // vertical padding
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}


// MARK: - Custom FlowLayout for Left Alignment
class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        
        for layoutAttribute in attributes where layoutAttribute.representedElementCategory == .cell {
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}
