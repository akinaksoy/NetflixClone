//
//  ViewController.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 19.04.2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let upComVC = UINavigationController(rootViewController: UpComingViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let downloadVC = UINavigationController(rootViewController: DownloadViewController())
        
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        upComVC.tabBarItem.image = UIImage(systemName: "play.circle")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeVC.title = "Home"
        upComVC.title = "Coming Soon"
        searchVC.title = "Top Search"
        downloadVC.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC,upComVC,searchVC,downloadVC], animated: true)
    }


}

