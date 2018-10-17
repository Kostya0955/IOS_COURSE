//
//  Good.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

final class Good {
    var id: Int
    var image: UIImage
    var name: String
    var company: String
    var price: Double
    
    init(id: Int, image: UIImage, name: String, company: String, price: Double) {
        self.id = id
        self.image = image
        self.name = name
        self.company = company
        self.price = price
    }
}
