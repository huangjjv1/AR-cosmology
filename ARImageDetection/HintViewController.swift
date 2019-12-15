//
//  HintViewController.swift
//  AR Detection
//
//  Created by 曾维 on 2/12/19.
//  Copyright © 2019 Willie Yam. All rights reserved.
//
import UIKit

//  Controller class for the hint view after game started
class HintViewController: UIViewController {
//  Used nodeName to get the parameter passed from the main view controller
    var nodeName: String!
//  the center image in hint view controller
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// use the nodeName to find the right picture to display
        imageLabel.image = UIImage(named: "art.scnassets/Targets/" + nodeName + ".png")
    }
// the button action in the top right when it is tapped
    @IBAction func hintCloseButtonTapped(_ sender: Any) {
// close the Hint View
        dismiss(animated: true, completion: nil)
    }
}
