//
//  DetailViewController.swift
//  AR Detection
//
//  Created by 曾维 on 1/12/19.
//  Copyright © 2019 Willie Yam. All rights reserved.
//

import UIKit

//  Controller class for the detail view to display the information about what we scanned.
class DetailViewController: UIViewController {
//  the detail view title controller
    @IBOutlet weak var titleLabel: UILabel!
//  the center image in hint view controller
    @IBOutlet weak var imageLabel: UIImageView!
//  the content in hint view controller
    @IBOutlet weak var contentLabel: UILabel!
//  Used nodeName to get the parameter passed from the main view controller
    var nodeName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
//  To update the information in the detail view
        titleLabel.text = "Detail of the model"
        imageLabel.image = UIImage(named: "art.scnassets/Targets/" + nodeName + ".png")
//  In case of the AR app has not detected any target
        if (nodeName == "") {
            contentLabel.text = ""
        } else {
            contentLabel.text = "This is" + nodeName
        }
        
    }
// the button action in the top right when it is tapped
    @IBAction func closeButtonTapped(_ sender: Any) {
// close the Hint View
        dismiss(animated: true, completion: nil)
    }
}
