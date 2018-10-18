//
//  FeedModel.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import Foundation

final class FeedModel {
    var videos: [Video]
    
    init() {
        let video1 = Video(id: 1, image: #imageLiteral(resourceName: "img6"), name: "Спорт", descr: "Описание", views: 100)
        let video2 = Video(id: 2, image: #imageLiteral(resourceName: "img5"), name: "Хабиб: история успеха", descr: "Тренды №1", views: 20000)
        let video3 = Video(id: 3, image: #imageLiteral(resourceName: "img7"), name: "Левое видео ", descr: "Видео,вроде,  про спорт ", views: 300)
        let video4 = Video(id: 3, image: #imageLiteral(resourceName: "img15"), name: "Спорт это жизнь", descr: "Видос про спорт, химиков и прочих...", views: 200)
        let video5 = Video(id: 3, image: #imageLiteral(resourceName: "img 11"), name: "Заработок в Ютубе", descr: "Как заработать в ютубе ", views: 99)
        let video6 = Video(id: 3, image: #imageLiteral(resourceName: "img6"), name: "Парень пожал 100?", descr: "Немного рекламы канала", views: 5522)
       
        
        videos = [video1, video2, video3, video4, video5, video6]
    }
}
