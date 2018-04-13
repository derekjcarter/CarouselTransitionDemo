//
//  DetailViewController.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    public var name: String = ""
    public var details: String = ""
    public var imageName: String = ""
    
    @IBOutlet private weak var contentContainerView: UIView!
    @IBOutlet private weak var containerLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var detailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close(_:))))
        
        contentContainerView.layer.masksToBounds = true
        
        nameLabel.text = name
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        detailLabel.text = details
    }
    
    func setPositionContainer(left: CGFloat, right: CGFloat, top: CGFloat, bottom: CGFloat) {
        containerLeadingConstraint.constant = left
        containerTrailingConstraint.constant = right
        containerTopConstraint.constant = top
        containerBottomConstraint.constant = bottom
        
        view.layoutIfNeeded()
    }
    
    func setCornerRadius(radius: CGFloat) {
        contentContainerView.layer.cornerRadius = radius
    }
    
    @objc func close(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
