//
//  FeedModel.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import Foundation

final class FeedModel {
    var goods: [Good]
    
    init() {
        let good1 = Good(id: 1, image: #imageLiteral(resourceName: "img6"), name: "Спорт", company: "Описание", views: 100)
        let good2 = Good(id: 2, image: #imageLiteral(resourceName: "img5"), name: "Хабиб: история успеха", company: "Тренды №1", views: 20000)
        let good3 = Good(id: 3, image: #imageLiteral(resourceName: "img7"), name: "Левое видео ", company: "Видео,вроде,  про спорт ", views: 300)
        let good4 = Good(id: 3, image: #imageLiteral(resourceName: "img15"), name: "Спорт это жизнь", company: "Видос про спорт, химиков и прочих...", views: 200)
        let good5 = Good(id: 3, image: #imageLiteral(resourceName: "img 11"), name: "Заработок в Ютубе", company: "Как заработать в ютубе ", views: 99)
        let good6 = Good(id: 3, image: #imageLiteral(resourceName: "img6"), name: "Парень пожал 100?", company: "Немного рекламы канала", views: 5522)
       
        
        goods = [good1, good2, good3, good4, good5, good6]
    }
}
