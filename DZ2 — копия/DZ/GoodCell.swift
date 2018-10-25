//
//  GoodCell.swift
//  SportShop
//
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

protocol GoodCellDelegate: class {
    func addToCartTapped(video: Video)
}

final class GoodCell: UITableViewCell {
    
    @IBOutlet weak var PreviewImage: UIImageView!
    @IBOutlet weak var VideoName: UILabel!
   
 
    @IBOutlet weak var DescrName: UILabel!
    
    weak var delegate: GoodCellDelegate?
    
    private var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PreviewImage.backgroundColor = UIColor.white
        DescrName.textColor = UIColor.brown
    }
    
    func configureView(video: Video) {
        self.video = video
        PreviewImage.image = video.image
        VideoName.text = video.name
        DescrName.text = video.descr
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
   
    
}

