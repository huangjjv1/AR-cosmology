//
//  DialogViewController.swift
//  ARImageDetection
//
//  Created by Willie Yam on 2018-07-13.
//  Copyright © 2018 Willie Yam. All rights reserved.
//

import UIKit

class DialogViewController: UIViewController {
    
    let screens = ["iPhoneX1", "iPhoneX2", "iPhoneX3"]
    let titles = ["Wallpaper", "Home", "Chapters"]
    let images = ["ARScreen1", "ARScreen2", "ARScreen3"]
    
    var delegate: DialogViewControllerDelegate?

    @IBOutlet weak var screenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screenCollectionView.delegate = self
        screenCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
}


extension DialogViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenCell", for: indexPath) as! DialogCollectionViewCell
        
        cell.screenImageButton.setImage(UIImage(named: screens[indexPath.row]), for: .normal)
        cell.screenLabel.text = titles[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
}

extension DialogViewController: DialogCollectionViewCellDelegate {
    func screenImageButtonTapped(index: Int) {
        dismiss(animated: true, completion: nil)
        delegate?.screenImageButtonTapped(image: UIImage(named: images[index])!)
    }
}

protocol DialogViewControllerDelegate {
    func screenImageButtonTapped(image: UIImage)
}
