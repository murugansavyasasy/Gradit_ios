//
//  PriorityProfileCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 25/08/26.
//

import UIKit

class PriorityProfileCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImageBaseView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
   
    var users : [datalogin] = []
    var onHeightChange: (() -> Void)?
    var onUserSelected: (() -> Void)?
    var colors: [UIColor] = [UIColor.systemBlue, UIColor.orange, UIColor.systemGreen, UIColor.systemRed]
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 0.5
        cellView.layer.borderColor = UIColor.lightGray.cgColor
        
        profileImageBaseView.layer.cornerRadius = profileImageBaseView.frame.height/2
        
        tv.register(UINib(nibName: "PriorityInnerCell", bundle: nil), forCellReuseIdentifier: "PriorityInnerCell")
        
        tv.delegate = self
        tv.dataSource = self
        
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 60
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tableViewHeight.constant = 0
    }
    
    func configureCell(users: [datalogin], isExpanded: Bool) {
        
        self.users = users
        
        tv.isHidden = !isExpanded
        
        if isExpanded {
            arrowImage.image = UIImage(systemName: "chevron.up")
            tableViewHeight.constant = CGFloat(users.count) * 250
            contentView.layoutIfNeeded()
            tv.reloadData()
            tv.layoutIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                let newHeight = self.tv.contentSize.height
                if self.tableViewHeight.constant != newHeight {
                    self.tableViewHeight.constant = newHeight
                    self.contentView.layoutIfNeeded()
                }
                self.onHeightChange?()
            }
        }else{
            arrowImage.image = UIImage(systemName: "chevron.down")
            DispatchQueue.main.async { [weak self] in
                self?.tableViewHeight.constant = 0
                self?.onHeightChange?()
            }
        }
    }
    
    func priorityColor(priority: String) -> UIColor{
        
        switch priority {
        case "p1":
            return UIColor(named: "Principal") ?? .systemBackground

        case "p2", "p3", "p6":
            return UIColor(named: "Teaching Staff") ?? .systemBackground

        case "p4":
            return UIColor(named: "studentViewColors") ?? .systemBackground

        case "p5":
            return UIColor(named: "FatherColor") ?? .systemBackground

        case "p7":
            return UIColor(named: "univercityColorCod") ?? .systemBackground

        default:
            return UIColor(named: "Principal") ?? .systemBackground
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tv.dequeueReusableCell(withIdentifier: "PriorityInnerCell", for: indexPath) as? PriorityInnerCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        
        let color: UIColor

        if indexPath.row == 0 {
            color = priorityColor(priority: users.first?.priority ?? "")
        } else {
            color = colors[indexPath.row % colors.count]
        }
        
        cell.firstLetterBaseview.backgroundColor = color.withAlphaComponent(0.15)
        
        cell.FirstLetterLbl.text = user.membername?.first?.uppercased()
        cell.nameLbl.text = user.membername
        
        var details = [user.coursename,user.yearname,user.semestername,user.colgname]
        
        if user.priority != "p4" && user.priority != "p5" {
            details.insert(user.loginas, at: 0)
        }
        
        let detailString = details
            .compactMap{$0}
            .filter({!$0.isEmpty})
            .joined(separator: " • ")
        
        cell.detailsLbl.text = detailString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let loginDetail = users[indexPath.row]
        
        let defaults = UserDefaults.standard
        
        defaults.set(loginDetail.colglogo, forKey: DefaultsKeys.colglogo)
        defaults.set(loginDetail.loginas, forKey: DefaultsKeys.loginAsType)
        defaults.set(loginDetail.membername, forKey: DefaultsKeys.memberName)
        defaults.set(loginDetail.colgname, forKey: DefaultsKeys.colgName)
        defaults.set(loginDetail.colgid, forKey: DefaultsKeys.collegeid)
        defaults.set(loginDetail.memberid, forKey: DefaultsKeys.memberid)
        defaults.set(loginDetail.priority, forKey: DefaultsKeys.priority)
        defaults.set(loginDetail.colgcity, forKey:DefaultsKeys.colgcity)
        defaults.set(loginDetail.divname, forKey: DefaultsKeys.divname)
        defaults.set(loginDetail.divid ,   forKey:DefaultsKeys.divid)
        defaults.set(loginDetail.courseid,forKey: DefaultsKeys.courseid)
        defaults.set(loginDetail.coursename,forKey:DefaultsKeys.coursename)
        defaults.set(loginDetail.deptid,forKey: DefaultsKeys.deptid)
        defaults.set(loginDetail.deptname,forKey: DefaultsKeys.deptname)
        defaults.set(loginDetail.yearid,forKey: DefaultsKeys.yearid)
        defaults.set(loginDetail.yearname,forKey: DefaultsKeys.yearname)
        defaults.set(loginDetail.sectionid,forKey: DefaultsKeys.sectionid)
        defaults.set(loginDetail.sectionname,forKey: DefaultsKeys.sectionname)
        defaults.set(loginDetail.semesterid,forKey: DefaultsKeys.semesterid)
        defaults.set(loginDetail.semestername,forKey: DefaultsKeys.semestername)
        defaults.set(loginDetail.is_parent_target_enabled,forKey: DefaultsKeys.is_parent_target_enabled)
        defaults.set(loginDetail.is_allow_to_make_call,forKey: DefaultsKeys.is_allow_to_make_call)
        
        onUserSelected?()
    }
}

