//
//  MenuBarViewController.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 23/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class MenuBarViewController: UIViewController {

    @IBOutlet weak var themeLabel: UILabel! 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyTheme()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        
    }
    
    @IBAction func themeChangingSwitch(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "Theme")
        applyTheme()
    }
    
    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        themeLabel.textColor = Theme.current.textColor
        themeLabel.font = Theme.current.mainFontName
        themeLabel.backgroundColor = Theme.current.accent
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
