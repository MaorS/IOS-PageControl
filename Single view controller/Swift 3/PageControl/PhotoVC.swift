//
//  PhotoVC.swift
//  UIPageViewController Post
//
//  Created by Maor Shams on 05/05/2017.
//  Copyright © 2017 Maor Shams. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photoName : String!
    var photoIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photoName = photoName{
            self.imageView.image = UIImage(named: photoName)
        }
    }
}
