//
//  ViewController.swift
//  CarouselTransitionDemo
//
//  Created by Derek Carter on 4/13/18.
//  Copyright © 2018 Derek Carter. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate, MKMapViewDelegate {
    
    // Map properties
    @IBOutlet private var mapView: MKMapView!
    let distanceInMeters: Double = 1200.0
    
    // Carousel properties
    private var scalingCarousel: ScalingCarouselView!
    var selectedCell = ScalingCarouselCell()
    var carouselDatasource: [Profile] = []
    
    // Transition properties
    let presentTransitionAnimator = PresentTransitionAnimator()
    let dismissTransitionAnimator = DismissTransitionAnimator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        setupDatasource()
        
        setupCarousel()
        
        setupMap()
        
        if carouselDatasource.count > 0 {
            let profile = carouselDatasource[0] as Profile
            let coords = CLLocationCoordinate2D(latitude: profile.latitude, longitude: profile.longitude)
            let region = MKCoordinateRegionMakeWithDistance(coords, distanceInMeters, distanceInMeters)
            self.mapView.setRegion(region, animated: false)
        }
    }
    
    
    // MARK: - Setup Methods
    
    private func setupDatasource() {
        let homer: Profile = Profile(name: "Homer Simpson",
                                     imageName: "homer",
                                     details: "Homer Jay Simpson is a fictional character and the main protagonist of the American animated sitcom The Simpsons as the patriarch of the eponymous family. He is voiced by Dan Castellaneta and first appeared on television, along with the rest of his family, in The Tracey Ullman Show short \"Good Night\" on April 19, 1987. Homer was created and designed by cartoonist Matt Groening while he was waiting in the lobby of James L. Brooks' office. Groening had been called to pitch a series of shorts based on his comic strip Life in Hell but instead decided to create a new set of characters. He named the character after his father, Homer Groening. After appearing for three seasons on The Tracey Ullman Show, the Simpson family got their own series on Fox that debuted December 17, 1989.",
                                     latitude: 41.875824,
                                     longitude: -87.618971)
        self.carouselDatasource.append(homer)
        
        let marge: Profile = Profile(name: "Marge Simpson",
                                     imageName: "marge",
                                     details: "Marjorie Jacqueline \"Marge\" Simpson (née Bouvier) is a fictional character in the American animated sitcom The Simpsons and part of the eponymous family. She is voiced by Julie Kavner and first appeared on television in The Tracey Ullman Show short \"Good Night\" on April 19, 1987. Tracy Ullman provided the first voice of Marge, which was then passed to Julie Kavner upon being picked up by Fox. Marge was created and designed by cartoonist Matt Groening while he was waiting in the lobby of James L. Brooks' office. Groening had been called to pitch a series of shorts based on Life in Hell but instead decided to create a new set of characters. He named the character after his mother Margaret Groening. After appearing on The Tracey Ullman Show for three seasons, the Simpson family received their own series on Fox, which debuted December 17, 1989.",
                                     latitude: 41.880584,
                                     longitude: -87.674226)
        self.carouselDatasource.append(marge)
        
        let bart: Profile = Profile(name: "Bart Simpson",
                                    imageName: "bart",
                                    details: "Bartholomew JoJo \"Bart\" Simpson is a fictional character in the American animated television series The Simpsons and part of the Simpson family. He is voiced by Nancy Cartwright and first appeared on television in The Tracey Ullman Show short \"Good Night\" on April 19, 1987. Cartoonist Matt Groening created and designed Bart while waiting in the lobby of James L. Brooks' office. Groening had been called to pitch a series of shorts based on his comic strip, Life in Hell, but instead decided to create a new set of characters. While the rest of the characters were named after Groening's family members, Bart's name is an anagram of the word brat. After appearing on The Tracey Ullman Show for three years, the Simpson family received its own series on Fox, which debuted December 17, 1989.",
                                    latitude: 41.921120,
                                    longitude: -87.633991)
        self.carouselDatasource.append(bart)
        
        let lisa: Profile = Profile(name: "Lisa Simpson",
                                    imageName: "lisa",
                                    details: "Lisa Marie Simpson is a fictional character in the animated television series The Simpsons. She is the middle child and most intelligent of the Simpson family. Voiced by Yeardley Smith, Lisa was born as a character in The Tracey Ullman Show short \"Good Night\" on April 19, 1987. Cartoonist Matt Groening created and designed her while waiting to meet James L. Brooks. Groening had been invited to pitch a series of shorts based on his comic Life in Hell, but instead decided to create a new set of characters. He named the elder Simpson daughter after his younger sister Lisa Groening. After appearing on The Tracey Ullman Show for three years, the Simpson family were moved to their own series on Fox, which debuted on December 17, 1989.",
                                    latitude: 41.976210,
                                    longitude: -87.901896)
        self.carouselDatasource.append(lisa)
        
        let maggie: Profile = Profile(name: "Maggie Simpson",
                                      imageName: "maggie",
                                      details: "Margaret Evelyn \"Maggie\" Simpson is a fictional character in the animated television series The Simpsons. She first appeared on television in the Tracey Ullman Show short \"Good Night\" on April 19, 1987. Maggie was created and designed by cartoonist Matt Groening while he was waiting in the lobby of James L. Brooks' office. She received her first name from Groening's youngest sister. After appearing on The Tracey Ullman Show for three years, the Simpson family was given their own series on the Fox Broadcasting Company which debuted December 17, 1989.",
                                      latitude: 41.861985,
                                      longitude: -87.617354)
        self.carouselDatasource.append(maggie)
    }
    
    private func setupCarousel() {
        scalingCarousel = ScalingCarouselView(withFrame: CGRect.null, andInset: 60)
        scalingCarousel.dataSource = self
        scalingCarousel.delegate = self
        scalingCarousel.translatesAutoresizingMaskIntoConstraints = false
        scalingCarousel.backgroundColor = UIColor.clear
        scalingCarousel.showsHorizontalScrollIndicator = false
        scalingCarousel.showsVerticalScrollIndicator = false
        
        scalingCarousel.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        view.addSubview(scalingCarousel)
        
        scalingCarousel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        scalingCarousel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        scalingCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scalingCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
    }
    
    private func setupMap() {
        for profile in carouselDatasource {
            let coordinate = CLLocationCoordinate2D(latitude: profile.latitude, longitude: profile.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    private func setCurrentUser() {
        if let indexPath = scalingCarousel.currentCenterCellIndex {
            let selectedProfile = carouselDatasource[indexPath.row]
            let coords = CLLocationCoordinate2D(latitude: selectedProfile.latitude, longitude: selectedProfile.longitude)
            let region = MKCoordinateRegionMakeWithDistance(coords, distanceInMeters, distanceInMeters)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    // MARK: - UICollectionViewDataSource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let profile = carouselDatasource[indexPath.row]
        cell.setImage(name: profile.imageName)
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate Methods
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            selectedCell = cell
            
            if let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPath) {
                let rectForCell: CGRect! = collectionView.convert(layoutAttributes.frame, to: collectionView.superview)
                presentTransitionAnimator.cellFrame = rectForCell
                presentTransitionAnimator.cellCornerRadius = cell.mainView.layer.cornerRadius
                dismissTransitionAnimator.cellFrame = rectForCell
                dismissTransitionAnimator.cellCornerRadius = cell.mainView.layer.cornerRadius
            }
            
            let detailViewController = storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            
            let profile = carouselDatasource[indexPath.row]
            detailViewController.name = profile.name
            detailViewController.imageName = profile.imageName
            detailViewController.details = profile.details
            detailViewController.transitioningDelegate = self
            present(detailViewController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIScrollViewDataSource Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scalingCarousel.didScroll()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setCurrentUser()
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate Methods
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentTransitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissTransitionAnimator
    }
    
}
