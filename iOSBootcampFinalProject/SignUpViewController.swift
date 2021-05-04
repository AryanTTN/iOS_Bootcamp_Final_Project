//
//  SignUpViewController.swift
//  iOSBootcampFinalProject
//
//  Created by TTN on 22/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var newUserData = [NewUserData?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let conPassword = confirmPasswordTextField.text{
            if firstName == ""{
                openAlert(title: "Alert", message: "Please enter your First Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your First Name")
                
            }else if lastName == ""{
                openAlert(title: "Alert", message: "Please enter your Last Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your Last Name")
                
            }else if !email.validateEmailId(){
                openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("email is not valid")
                
            }else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Password is not valid")
                
            } else{
                if conPassword == ""{
                    openAlert(title: "Alert", message: "Please confirm your password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("Please confirm password")
                }else{
                    if password == conPassword{
                        // navigation code
                        newUserData = [CoreDataManager.shared.createUserDetails(firstName: firstNameTextField!.text ?? "", lastName: lastNameTextField!.text ?? "", email: emailTextField!.text ?? "", password: confirmPasswordTextField!.text ?? "", dateOfBirth: datePicker!.date)]
                        //        print("usedata = \(String(describing: userData[0]))")
                        //        print("\(UserData.self)")
                        
                        self.dismiss(animated: true, completion: nil)
                        print("Navigation code Yeah!")
                    }else{
                        openAlert(title: "Alert", message: "Password and Confirm Password fields do not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        print("password does not match")
                    }
                }
            }
        }else{
            print("Please check your details")
        }
    }
    
    
}
