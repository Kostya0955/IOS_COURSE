//
//  GoodCell.swift
//  SportShop
//
//  Created by Кирилл Володин on 24.09.2018.
//  Copyright © 2018 Кирилл Володин. All rights reserved.
//

import UIKit

protocol GoodCellDelegate: class {
    func addToCartTapped(good: Good)
}

final class GoodCell: UITableViewCell {
    
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var companyName: UILabel!
 
    
    weak var delegate: GoodCellDelegate?
    
    private var good: Good?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        goodImage.backgroundColor = UIColor.white
        companyName.textColor = UIColor.brown
    }
    
    func configureView(good: Good) {
        self.good = good
        goodImage.image = good.image
        goodName.text = good.name
        companyName.text = good.company
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    
}

