//
//  NewsTableViewCell.swift
//  RSS Reader
//
//  Created by Константин Головнев on 10/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var newsImage = UIImageView()
    var newsTitle = UILabel()
    var sourceName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImage()
        setupSourceName()
        setupNewsTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
