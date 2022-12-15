//
//  RestaurantCarouselView.swift
//  TravelDiscovery
//
//  Created by Hakan Körhasan on 9.12.2022.
//

import SwiftUI
import Kingfisher
// UIKit VC to use
struct RestaurantCarouselContainer: UIViewControllerRepresentable{
    
    let imageUrlStrings: [String]
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pvc = CarouselPageViewController(
            imageUrlStrings: imageUrlStrings)
        return pvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
 
    typealias UIViewControllerType = UIViewController
}

class CarouselPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    
    // make belows dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
    
    // make pagination
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == 0 {
            return nil
        }
        
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == allControllers.count - 1 {
            return nil
        }
        
        return allControllers[index + 1]
    }
    
    var allControllers: [UIViewController] = []
    
    init(imageUrlStrings: [String]){
        
        UIPageControl.appearance().pageIndicatorTintColor =
        UIColor.systemGray5
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        allControllers = imageUrlStrings.map({ imageName in
            let hostingController = UIHostingController(
                rootView:
                    ZStack {
                        Color.black
                        KFImage(URL(string: imageName))
                            .resizable()
                            .scaledToFit()
                     }
               )
            hostingController.view.clipsToBounds = true
            return hostingController
        })
        
        if let first = allControllers.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

