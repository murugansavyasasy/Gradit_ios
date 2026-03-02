//
//  ExameCreactionViewController.swift
//  Vs_GradItCollege
//
//  Created by admin on 11/10/23.
//

import UIKit

@available(iOS 16.0, *)
class ExameCreactionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var tv: UITableView!
    var selectedCell : IndexPath?
    
    var identifiers = "ExameCreationTableViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let rowNib = UINib(nibName: identifiers, bundle: nil)
        tv.register(rowNib, forCellReuseIdentifier: identifiers)
        
        tv.delegate = self
        tv.dataSource = self
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiers, for: indexPath) as!
        
        ExameCreationTableViewCell
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            print("klklkkllllll")
            
            cell.SubjectTabelView.isHidden = false
            
        }
        
        else{
            
            
            cell.SubjectTabelView.isHidden = true
        }
        
        //
        cell.sectionLbl.text = "a"
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        
        if let selectedCells = selectedCell, selectedCells == indexPath {
            
            selectedCell = nil
            
            
        }
        
        else{
            
            selectedCell = indexPath
            
        }
        
        
        
        tv.beginUpdates()
        tv.endUpdates()
        tv.reloadData()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let selectedCell = selectedCell, selectedCell == indexPath {
            
            return 120
            
        } else {
            
            return 50
            
        }
    }
    
    
    
    
    
    
    
}
