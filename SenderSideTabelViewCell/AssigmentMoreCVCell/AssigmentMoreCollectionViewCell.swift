//
//  AssigmentMoreCollectionViewCell.swift
//  Vs_GradItCollege
//
//  Created by admin on 29/02/24.
//

import UIKit

class AssigmentMoreCollectionViewCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate {
    
    @IBOutlet weak var studentLabel: UILabel!
    @IBOutlet weak var WHoleView: UIViewX!
    @IBOutlet weak var sucessImageView: UIImageView!
    
    @IBOutlet weak var registerNo: UILabel!
    
    @IBOutlet weak var cv: UICollectionView!
    @IBOutlet weak var sendView: UIViewX!
    @IBOutlet weak var MarkTextField: UITextField!
    @IBOutlet weak var NameLabel: UILabel!
    var menuIdentifier = "MoreImageCCCollectionViewCell"
    var Filepath : [FilepathDataDetails] = []
    var Filepath2 : [FilepathDataDetails] = []
    var stringss : [String] = []
    
    var assigmentMemberCount : [AssigmentmebCountData] = []
    var main : UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
        
        
        let menuRowNib = UINib(nibName: menuIdentifier, bundle: nil)
        cv.register(menuRowNib, forCellWithReuseIdentifier: menuIdentifier)
        
        MarkTextField.delegate = self
        cv.delegate = self
        cv.dataSource = self
        addDoneButtonOnKeyboard()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return Filepath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuIdentifier , for: indexPath) as! MoreImageCCCollectionViewCell
        
        
        
        let image  : FilepathDataDetails =  Filepath[indexPath.row]
        
        
        
        
        
        
        
        
        
        if image.filetype == "pdf" {
            print(".pdf is present in the array")
            
            cell.pdfView.isHidden = false
        } else {
            print(".pdf is not present in the array")
            cell.pdfView.isHidden = true
        }
        
        
        if  indexPath.row == 5{
            
            if Filepath2.count > Filepath.count {
                //
                
                print(".pdhe array")
                cell.countView.isHidden = false
                cell.countLabl.text = "+" + String(Filepath2.count-6)
            }
            else{
                
                cell.countView.isHidden = true
            }
            
            
            
            
        }else{
            
            
            cell.countView.isHidden = true
            
        }
        
        
        
        
        cell.CellmageView.sd_setImage(with: URL(string: image.fileurl), placeholderImage: UIImage(named: "ic_white"))
        
        let imagee = AssigmentMoreImageShow(target: self, action: #selector(ImageShowVc))
        imagee.fileType = image.filetype
        imagee.indexss = indexPath.row
        imagee.imageUrls = image.fileurl
        
        cell.fullView.addGestureRecognizer(imagee)
        
        let count = AssigmentMoreImageShow(target: self, action: #selector(ImageShowVc))
        count.fileType = image.filetype
        
        count.imageUrls = image.fileurl
        
        cell.countView.addGestureRecognizer(count)
        
        return cell
        
    }
    
    @IBAction func ImageShowVc( gesture :AssigmentMoreImageShow ){
        
        
        
        print("imageUrlssssssssdfghgfdsdfg",gesture.imageUrls)
        //      
        //        
        
        stringss.removeAll()
        
        for i in Filepath2{
            
            stringss.append(i.fileurl)
        }
        
        
        
        if let index = stringss.firstIndex(of: gesture.imageUrls) {
            stringss.remove(at: index)
            stringss.insert(gesture.imageUrls, at: 0)
        }
        
        
        
        
        
        
        let vc = assigmntMoreSubViewController(nibName: nil, bundle: nil)
        
        vc.MoreimgfilePath = gesture.imageUrls
        
        vc.stringss = stringss
        vc.Filepath2 = Filepath2
        vc.modalPresentationStyle = .fullScreen
        
        main.present(vc, animated: true,completion: nil)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let collectionView = collectionView.bounds.width
        print("heloooooooooooo",CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2))
        return CGSize(width: collectionView / 3 - 2, height: collectionView / 3 - 2)
        //            
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    class AssigmentMoreImageShow : UITapGestureRecognizer{
        
        
        var imageUrls : String!
        var fileType : String!
        var indexss : Int!
        
    }
    
    
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        MarkTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        MarkTextField.resignFirstResponder()
    }
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        sucessImageView.image = UIImage(named: "sendRocket")
        print("printssssssssssss",textField)
    }
    //    
    //    
    
    //    
    
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        sucessImageView.image = UIImage(named: "sendRocket")
        return range.location <= 2
    }
    
    
    
    
}



