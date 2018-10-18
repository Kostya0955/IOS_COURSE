//
//  VideoViewController.swift
//   gallery_test
//  Created by Головнёв Константин on 17.10.2018.
//  Copyright © 2018 Головнёв Константин. All rights reserved.
//

import UIKit

final class GoodViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
   
    @IBOutlet weak var DeskrLAbel: UILabel!
    @IBOutlet weak var ImageV: UIImageView!
    
    @IBOutlet weak var btnClick: UIButton!
    var good: Good!
    
    @IBOutlet weak var Review: UILabel!
    
    @IBOutlet var VColor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.applyRoundCorner(btnClick)
      //  VColor.backgroundColor = UIColor.white
    }

    func setupUI() {
        
        ImageV.image = good.image
        NameLabel.text = good.name.uppercased()
        DeskrLAbel.text = good.company
        Review.text = "Просмотров: \(good.views)"

        let gesture = UITapGestureRecognizer(target: self, action: #selector(openInFullScreen))
        ImageV.addGestureRecognizer(gesture)
    }

    @objc func openInFullScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "FullScreenImageViewController") as? FullScreenImageViewController else { return }
    
        vc.good = good
        present(vc, animated: true, completion: nil)
    }
    func applyRoundCorner(_ object: AnyObject){
        object.layer.cornerRadius = object.frame.size.width / 2
        object.layer.masksToBounds = true
    }

    @IBAction func transition(_ sender: Any) {
        openInFullScreen()
    }
}

