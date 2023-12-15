//
//  File.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import UIKit

class DetectorTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarItems()
        tabBar.barStyle = .default
        self.selectedIndex = 1
    }
    private func setupTabBarItems() {
        let eventsVC = createVC(nameVC: EventsView(), title: "Events", image: UIImage(systemName: "list.clipboard"))
        let videosVC = createVC(nameVC: VideosView(), title: "Videos", image: UIImage(systemName: "video"))
        let profileVC = createVC(nameVC: ProfileView(), title: "Profile", image: UIImage(systemName: "person.circle.fill"))

        setViewControllers([eventsVC, videosVC, profileVC], animated: true)
    }
    private func createVC(nameVC: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let vc = UINavigationController(rootViewController: nameVC)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        vc.viewControllers.first?.navigationItem.title = title
        return vc
    }
}
