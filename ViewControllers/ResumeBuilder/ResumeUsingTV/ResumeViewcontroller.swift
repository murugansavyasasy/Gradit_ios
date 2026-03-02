//
//  ResumeViewcontroller.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 29/05/25.
//

import UIKit

class ResumeViewcontroller: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Tv: UITableView!
    
    var HeaderString = ["My Profile","Basic Details","Academic Records","Skill sets"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Tv.delegate = self
        Tv.dataSource = self
        
        let headerNib = UINib(nibName: "ResumeHeaderCell", bundle: nil)
        Tv.register(headerNib, forHeaderFooterViewReuseIdentifier: "ResumeHeaderCell")
        
        let nib1 = UINib(nibName: "MyprofileTvCell", bundle: nil)
        Tv.register(nib1, forCellReuseIdentifier: "MyprofileTvCell")
        
        let nib2 = UINib(nibName: "BasicDetailsTvCell", bundle: nil)
        Tv.register(nib2, forCellReuseIdentifier: "BasicDetailsTvCell")
        
        let nib3 = UINib(nibName: "AcademicRecordTVcell", bundle: nil)
        Tv.register(nib3, forCellReuseIdentifier: "AcademicRecordTVcell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return HeaderString.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = Tv.dequeueReusableHeaderFooterView(withIdentifier: "ResumeHeaderCell") as! ResumeHeaderCell
        
        header.HeaderLbl.text = HeaderString[section]
        
        return header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 1
        case 3:
            return 8
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
            
        case 0:
            let cell = Tv.dequeueReusableCell(withIdentifier: "MyprofileTvCell", for: indexPath) as! MyprofileTvCell
            
            return cell
            
        case 1:
            let cell = Tv.dequeueReusableCell(withIdentifier: "BasicDetailsTvCell", for: indexPath) as! BasicDetailsTvCell
            
            return cell
        case 2:
            let cell = Tv.dequeueReusableCell(withIdentifier: "AcademicRecordTVcell", for: indexPath) as! AcademicRecordTVcell
            
            return cell
            
        case 3:
            let cell = Tv.dequeueReusableCell(withIdentifier: "BasicDetailsTvCell", for: indexPath) as! BasicDetailsTvCell
            
            return cell
            
        default:
            fatalError("Unknown section")
        }
    }

    
}
