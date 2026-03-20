//
//  TemplateTvCell.swift
//  Vs_GradItCollege
//
//  Created by Lakshmanan on 30/05/25.
//

import UIKit

class TemplateTvCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cvHeight: NSLayoutConstraint!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var CV: UICollectionView!
    
    var selectedTemplate = 0
    var selectedColour = 0
    
    var isTemplate: Bool?
    var onTemplate: ((Int) -> Void)?
    var onColour: ((String) -> Void)?
    
//    let colorHexCodes = [
//        "#2C3E50", // Midnight Blue
//        "#2ECC71", // Emerald Green
//        "#E74C3C", // Alizarin Red
//        "#F1C40F", // Sunflower Yellow
//        "#2980B9", // Belize Hole Blue
//        "#9B59B6", // Amethyst Purple
//        "#ECF0F1", // Clouds Grey
//        "#34495E", // Wet Asphalt
//        "#E67E22", // Orange Carrot
//        "#BDC3C7"  // Silver
//    ]

    var colorHexCodes : [String] = []
    var template: [ResumeTemplate] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib1 = UINib(nibName: "templateCvCell", bundle: nil)
        CV.register(nib1, forCellWithReuseIdentifier: "templateCvCell")
        
        let nib2 = UINib(nibName: "ColoursCvCell", bundle: nil)
        CV.register(nib2, forCellWithReuseIdentifier: "ColoursCvCell")
        
        CV.delegate = self
        CV.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(template: [ResumeTemplate], colours: [String], istemplate: Bool){
        
        self.template = template
        self.colorHexCodes = colours
        self.isTemplate = istemplate
        CV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isTemplate == true{
            return template.count
        }else {
            return colorHexCodes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isTemplate == true {
            let cell = CV.dequeueReusableCell(withReuseIdentifier: "templateCvCell", for: indexPath) as! templateCvCell
            
            let image_Url = URL(string: template[indexPath.item].resume_template_image ?? "")
            cell.TemplateImage.sd_setImage(with: image_Url)
            cell.TitleLbl.text = template[indexPath.item].resume_template_name
            //ProfileImg.sd_setImage(with: image_Url, placeholderImage: UIImage(systemName: "person.circle"))
            
            if indexPath.item == selectedTemplate {
                cell.TemplateImage.layer.borderWidth = 3
                cell.TemplateImage.layer.borderColor = UIColor(named: "IndigoColour")?.cgColor
                
                cell.TitleLbl.textColor = UIColor(named: "IndigoColour")
            }else {
                cell.TemplateImage.layer.borderWidth = 1
                cell.TemplateImage.layer.borderColor = UIColor.systemGray.cgColor
                cell.TitleLbl.textColor = .black
            }
            
            return cell
            
        }else {
            
            let cell = CV.dequeueReusableCell(withReuseIdentifier: "ColoursCvCell", for: indexPath) as! ColoursCvCell
            
            let selectedColor = UIColor(hex: colorHexCodes[indexPath.item])
            cell.Button.backgroundColor = selectedColor
            
            if indexPath.item == selectedColour {
                
                cell.Button.setImage(UIImage(systemName: "checkmark"), for: .normal)
                cell.Button.layer.borderColor = UIColor(named: "IndigoColour")?.cgColor
            }else {
                cell.Button.setImage(UIImage(systemName: ""), for: .normal)
                cell.Button.layer.borderColor = UIColor.clear.cgColor
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isTemplate == true {
            let width = CV.frame.width / 3
            
            return CGSize(width: width, height: 200)
            
        }else {
            
            let width = CV.frame.width / 5
            return CGSize(width: 70, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isTemplate == true {
            
            selectedTemplate = indexPath.item
            onTemplate?(selectedTemplate + 1)
            
        }else {
            
            selectedColour = indexPath.item
            onColour?(colorHexCodes[selectedColour])
        }
        
        CV.reloadData()
    }
}


import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r, g, b, a: CGFloat
        switch hexSanitized.count {
        case 6:
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            a = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            r = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
