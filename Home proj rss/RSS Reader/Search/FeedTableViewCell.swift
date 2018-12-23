//
//  FeedTableViewCell.swift
//  RSS Reader
//
//  Created by Ануфриев Артем on 01/12/2018.
//  Copyright © 2018 Ануфриев Артем. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let publishedAtLabel = UILabel()
    let authorLabel = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupTitleLabel()
        setupPublishedAtLabel()
        setupAuthorLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
