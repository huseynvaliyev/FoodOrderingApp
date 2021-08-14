//
//  ViewController.swift
//  FoodOrderingApp
//
//  Created by Huseyn Valiyev on 12.08.2021.
//

import UIKit

class OnboardingViewController: UIViewController {
    

    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageController.currentPage = currentPage
            if currentPage == slides.count - 1 {
                getStartedButton.setTitle("GET STARTED", for: .normal)
            } else {
                getStartedButton.setTitle("NEXT", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [
            .init(title: "Welcome", description: "It’s a pleasure to meet you. We are excited that you’re here so let’s get started!", image: #imageLiteral(resourceName: "first")),
            .init(title: "All your favorites", description: "Order from the best local restaurants with easy, on-demand delivery", image: #imageLiteral(resourceName: "second")),
            .init(title: "Free delivery offers", description: "Free delivery for new customers via Apple Pay and others payment .methods.", image: #imageLiteral(resourceName: "third")),
            .init(title: "Choose your food", description: "Easly find your type of food craving and you'll get delivery in wide range.", image: #imageLiteral(resourceName: "fourth"))
        ]
        getStartedButton.layer.cornerRadius = 8
        pageController.numberOfPages = slides.count
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        if currentPage == slides.count - 1 {
            performSegue(withIdentifier: "signIn", sender: self)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: OnboardingViewCell.indentifier, for: indexPath) as! OnboardingViewCell
        cell.setup(slide: slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

