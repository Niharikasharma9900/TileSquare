//
//  MaleView.swift
//  ScrollViewWithImages
//
//  Created by 苏菲 on 2017-04-07.
//  Copyright © 2017 Sophie. All rights reserved.
//

import UIKit
import EasyPeasy

class MaleView: UIView {
    let topImageView = UIImageView()
    let leftImageView = UIImageView()
    let rightImageView = UIImageView()
    let bottomImageView = UIImageView()
    let furtherLeft = UIImageView()
    let furtherRight = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray

        leftImageView.addSubview(topImageView)
        topImageView.contentMode = .scaleAspectFit
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        topImageView <- [CenterX(), CenterY(), Width(300), Height(100)]
  
       

       self.addSubview(leftImageView)
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
         leftImageView.backgroundColor = .clear
        leftImageView <- [CenterY(0), CenterX(), Width(400), Height(180)]

        self.addSubview(rightImageView)
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView <- [CenterY(), CenterX(50), Width(80), Height(60)]

        self.addSubview(bottomImageView)
        bottomImageView.contentMode = .scaleAspectFit
        bottomImageView.translatesAutoresizingMaskIntoConstraints = false
        bottomImageView <- [CenterY(50), CenterX(), Width(80), Height(60)]

        self.addSubview(furtherLeft)
        furtherLeft.contentMode = .scaleAspectFit
        furtherLeft.translatesAutoresizingMaskIntoConstraints = false
        furtherLeft <- [CenterY(), CenterX(-150), Width(80), Height(60)]
        
        self.addSubview(furtherRight)
        furtherRight.contentMode = .scaleAspectFit
        furtherRight.translatesAutoresizingMaskIntoConstraints = false
        furtherRight <- [CenterY(), CenterX(150), Width(80), Height(60)]

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
