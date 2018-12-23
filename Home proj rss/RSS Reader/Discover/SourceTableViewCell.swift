//
//  SourceTableViewCell.swift
//  RSS Reader
//
//  Created by Константин Головнев on 11/12/2018.
//  Copyright © 2018 Константин Головнев. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {
    
    var sourceTitle = UILabel()
    var followButton = UIButton()
    var id = String()
    var index = Int()
    var added = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFollowButton()
        setupTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
