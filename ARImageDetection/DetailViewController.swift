//
//  DetailViewController.swift
//  AR Detection
//
//  Created by 曾维 on 1/12/19.
//  Copyright © 2019 Willie Yam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    var nodeName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel.image = UIImage(named: "art.scnassets/planet.png")
        contentLabel.text = "This is " + nodeName
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
