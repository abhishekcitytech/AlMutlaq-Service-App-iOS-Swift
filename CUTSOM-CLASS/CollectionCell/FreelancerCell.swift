//
//  FreelancerCell.swift
//  AlMutlaqRealEstate
//
//  Created by Sandipan on 09/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class FreelancerCell: UICollectionViewCell
{

    var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - override init method
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        showCaseImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        showCaseImageView.center=CGPoint(x: self.bounds.size.width/2,y :self.bounds.size.height/2-10)
        showCaseImageView.contentMode = .scaleAspectFit
        showCaseImageView.backgroundColor = UIColor.clear
        addSubview(showCaseImageView)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: self.frame.size.height-50, width: self.frame.size.width, height: 50))
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.backgroundColor = UIColor.clear
        addSubview(nameLabel)
    }
    
    // MARK: - required init coder Error method
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
