//
//  HintViewController.swift
//  AR Detection
//
//  Created by 曾维 on 2/12/19.
//  Copyright © 2019 Willie Yam. All rights reserved.
//
import UIKit

class HintViewController: UIViewController {

    var nodeName: String!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLabel.image = UIImage(named: "art.scnassets/Targets/" + nodeName + ".png")
    }
    
    @IBAction func hintCloseButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
