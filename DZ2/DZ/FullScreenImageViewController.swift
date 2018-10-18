//
//  FullScreenImageViewController.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = video.image
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        imageView.addGestureRecognizer(gesture)
    }
    
    @objc func swiped() {
        dismiss(animated: true, completion: nil)
    }
}
