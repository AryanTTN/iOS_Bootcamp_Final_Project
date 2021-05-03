//
//  SideMenuDrawer.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(menuOption: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case home = "Home"
    case location = "Location"
    case movies = "Movies"
    case notification = "Notifications"
    case employee = "Employee"
    case country = "Country"
    case language = "Language"
    case aboutus = "About Us"
    case faq = "FAQ"
    case changetheme = "Change Theme"
    case logout = "Logout"
}

class MenuController: UITableViewController {

    public var delegate: MenuControllerDelegate?

    private let menuItems: [SideMenuItem]
//    private let color = UIColor(red: 33/255.0,
//                                green: 33/255.0,
//                                blue: 33/255.0,
//                                alpha: 1)
     

    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Theme.current.background
        tableView.rowHeight = 80
        view.backgroundColor = Theme.current.background
    }

    // Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = Theme.current.background
        cell.contentView.backgroundColor = Theme.current.background
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(menuOption: selectedItem)
    }

}





