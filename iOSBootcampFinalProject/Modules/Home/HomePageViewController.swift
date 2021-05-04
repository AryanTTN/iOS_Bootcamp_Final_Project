//
//  HomePageViewController.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 22/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import SideMenu

class HomePageViewController: UIViewController, MenuControllerDelegate {
    
    
    @IBOutlet weak var homePageTableView: UITableView!
    let homeVM = HomeViewModel()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchHomeScreenData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    private var sideMenu: SideMenuNavigationController?
    private let employeeController = EmployeeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePageTableView.addSubview(self.refreshControl)
        homePageTableView.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        homePageTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: BannerTableViewCell.identifier)
        homePageTableView.delegate = self
        homePageTableView.dataSource = self
        homePageTableView.estimatedRowHeight = UITableView.automaticDimension
        homePageTableView.rowHeight = UITableView.automaticDimension
        fetchHomeScreenData()
        
        // Do any additional setup for adding the side menu .
        let menu = MenuController(with: SideMenuItem.allCases)
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.current.background
        homePageTableView.backgroundColor = Theme.current.background
    }
    
    @IBAction func menuBarButtonTouchUpInside(_ sender: Any) {
        
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(menuOption: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        
        switch menuOption {
        case .home:
            openAlert(title: "Alert", message: "Home Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .location:
            openAlert(title: "Alert", message: "Location Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .movies:
            openAlert(title: "Alert", message: "Movies Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .notification:
            openAlert(title: "Alert", message: "Notification Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .employee:
            openAlert(title: "Alert", message: "Employee Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .country:
            openAlert(title: "Alert", message: "Country Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .language:
            openAlert(title: "Alert", message: "Language Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .aboutus:
            openAlert(title: "Alert", message: "About us Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .faq:
            openAlert(title: "Alert", message: "FAQ Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .changetheme:
            openAlert(title: "Alert", message: "Theme Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .logout:
            openAlert(title: "Alert", message: "Logout Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
        
    }
    
    private func addChildControllers() {
        addChild(employeeController)
        view.addSubview(employeeController.view)
        employeeController.view.frame = view.bounds
        employeeController.didMove(toParent: self)
        employeeController.view.isHidden = true
        
    }
    
    @objc func fetchHomeScreenData() {
        homeVM.fetchHomeApiData { (success, message) in
            self.refreshControl.endRefreshing()
            if success {
                self.homePageTableView.reloadData()
            } else {
                print(message)
            }
        }
    }
    
    func openDetailScreen(_ sectionIndex: Int, _ itemIndex: Int) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailScreenViewController") as! DetailScreenViewController
        vc.data = homeVM.homeApiData[sectionIndex].movieData?[itemIndex]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeVM.homeApiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.cellIndex = indexPath.row
            cell.delegate = self
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        } else {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
            cell.cellIndex = indexPath.row
            cell.delegate = self
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        }
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        cell.contentView.backgroundColor = Theme.current.tint
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return homePageTableView.frame.width * (9/16)
        } else {
            return UITableView.automaticDimension
        }
    }
    
}

extension HomePageViewController: CustomTableCellProtocol, BannerTableCellProtocol {
    func bannerTapped(sectionIndex: Int, itemIndex: Int) {
        openDetailScreen(sectionIndex, itemIndex)
    }
    
    func cellTapped(sectionIndex: Int, itemIndex: Int) {
        openDetailScreen(sectionIndex, itemIndex)
    }
    
}
