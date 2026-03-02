    //
    //  HomeTableViewCell.swift
    //  Vs_GradIt
    //
    //  Created by APPLE on 26/09/22.
    //

    import UIKit
    import WebKit
    import ObjectMapper

    class HomeTableViewCell: UITableViewCell {


    @IBOutlet weak var smallImg: UIImageView!
    @IBOutlet weak var bigImg: UIImageView!

    @IBOutlet weak var adView: UIView!


    @IBOutlet weak var Cv: UICollectionView!


    @IBOutlet weak var tv: UITableView!


    var index : Int!


    var dash : String!



    var adverstiments : [AdData] = []
    var adverstiments2 : [AdData] = []
    var adverstiment3 : [AdData] = []
    var dashBoardDataList : [DashBoardData] = []
    var dasff : [String] = []

    var addImage = ""

    var strr = (String)()
    var identifers  = "AdvertismentCVCollectionViewCell"

    var dashtypes : String!
    var dashOrder : Int!

    var colgId : String!
    var memberId : String!
    var loginAsType : String!
    var priority : String!

    var image1 : String!
    var image2 : String!

    var strinds : String!

    override func awakeFromNib() {
    super.awakeFromNib()



    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)


    }




    }
