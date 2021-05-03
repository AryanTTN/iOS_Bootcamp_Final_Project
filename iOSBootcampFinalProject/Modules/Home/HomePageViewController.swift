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
              employeeController.view.isHidden = true
          case .location:
              employeeController.view.isHidden = true
          case .movies:
              employeeController.view.isHidden = true
          case .notification:
              employeeController.view.isHidden = true
          case .employee:
              employeeController.view.isHidden = true
          case .country:
              employeeController.view.isHidden = true
          case .language:
              employeeController.view.isHidden = true
          case .aboutus:
              employeeController.view.isHidden = true
          case .faq:
              employeeController.view.isHidden = true
          case .changetheme:
              employeeController.view.isHidden = true
          case .logout:
              employeeController.view.isHidden = true
             
          }
          
      }
    
    private func addChildControllers() {
           addChild(employeeController)
           view.addSubview(employeeController.view)
           employeeController.view.frame = view.bounds
           employeeController.didMove(toParent: self)
           employeeController.view.isHidden = true

       }
    
    @objc func fetchHomeScreenData(){
        homeVM.fetchHomeApiData { (success, message) in
            self.refreshControl.endRefreshing()
            if success {
                self.homePageTableView.reloadData()
            } else {
                print(message)
            }
        }
    }

   
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeVM.homeApiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        } else {
            let cell = homePageTableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
            cell.configure(homeVM.homeApiData[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return homePageTableView.frame.width * (9/16)
        } else {
            return UITableView.automaticDimension
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let cell = homePageTableView.cellForRow(at: indexPath) as! CustomTableViewCell
////        cell.buttonAction()
//        homePageTableView.reloadRows(at: [indexPath], with: .middle)
//
//    }
    
}
