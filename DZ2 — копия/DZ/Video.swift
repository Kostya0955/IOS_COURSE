//
//  Video.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

final class Video {
    var id: Int
    var image: UIImage
    var name: String
    var descr: String
    var views: Int
    
    init(id: Int, image: UIImage, name: String, descr: String, views: Int) {
        self.id = id
        self.image = image
        self.name = name
        self.descr = descr
        self.views = views
    }
}
