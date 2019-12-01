//
//  DialogCollectionViewCell.swift
//  ARImageDetection
//
//  Created by Willie Yam on 2018-07-13.
//  Copyright © 2018 Willie Yam. All rights reserved.
//

import UIKit

class DialogCollectionViewCell: UICollectionViewCell {
    
    var delegate: DialogCollectionViewCellDelegate?
    var index = 0
    
    @IBOutlet weak var screenImageButton: UIButton!
    @IBOutlet weak var screenLabel: UILabel!
    @IBAction func screenImageButtonTapped(_ sender: Any) {
        delegate?.screenImageButtonTapped(index: index)
    }
}

protocol DialogCollectionViewCellDelegate {
    func screenImageButtonTapped(index: Int)
}
