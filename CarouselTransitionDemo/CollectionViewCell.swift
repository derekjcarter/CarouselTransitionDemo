//
//  CollectionViewCell.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//

import UIKit

class CollectionViewCell: ScalingCarouselCell {
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.clipsToBounds = true
        mainView.backgroundColor = .white
    }
    
    func setImage(name: String?) {
        if let mainView = self.mainView as? MainView {
            if let imageView = mainView.imageView {
                imageView.contentMode = .scaleAspectFit
                if let name = name {
                    imageView.image = UIImage(named: name)
                }
                else {
                    imageView.image = nil
                }
            }
        }
    }
    
}


class MainView: UIView {
    
    var imageName: String?
    @IBOutlet var imageView: UIImageView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
