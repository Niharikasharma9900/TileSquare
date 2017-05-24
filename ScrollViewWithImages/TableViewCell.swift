//
//  TableViewCell.swift
//  Restaurant
//
//  Created by Niharika Sharma on 2017-03-23.
//  Copyright © 2017 Niharika Sharma. All rights reserved.
//

import UIKit
import EasyPeasy


protocol ButtonCellDelegate {
    func cellTapped(cell: TableViewCell)
}


class TableViewCell: UITableViewCell {

    
    var myLabel1: UILabel!
    var myLabel2: UILabel!
    var myButton1 : UIButton!
    var myButton2 : UIButton!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?,frame: CGSize) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let gap : CGFloat = 10
        let labelHeight: CGFloat = 30
        let labelWidth: CGFloat = 70
       
        
        myLabel1 = UILabel()
        myLabel1.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
        myLabel1.textColor = UIColor.black
        contentView.addSubview(myLabel1)
        
        myLabel2 = UILabel()
        myLabel2.frame = CGRect(x:0, y:0, width:labelWidth, height:labelHeight)
        myLabel2.textColor = UIColor.black
        contentView.addSubview(myLabel2)
//        
        myButton1 = UIButton()
        
        myButton1.setImage(UIImage(named: "browser.png"), for: UIControlState.normal)
    //    myButton1.frame = CGRect(x:bounds.width-imageSize - gap, y:label2Y, width:imageSize, height:imageSize)
        myButton1.frame = CGRect(x:20, y:0, width:labelWidth, height:labelHeight + 5)
        myButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        myButton1.titleLabel?.minimumScaleFactor = 0.1
     //   myButton1.titleLabel?.font = 10
        myButton1.titleLabel?.textColor = UIColor.black
        myButton1.backgroundColor = UIColor.lightGray
         myButton1.setTitle("+", for: .normal)
        
       // contentView.addSubview(myButton1)
        
               self.frame.size = frame
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
