//
//  DetailViewController.swift
//  iContact
//
//  Created by ANI on 1/18/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentContact  :Contact!
    var allowChanges1    :Bool!
    var allowChanges2    :Bool!
    
    @IBOutlet var firstNameTextField    :UITextField!
    @IBOutlet var lastNameTextField     :UITextField!
    @IBOutlet var phoneNumTextField     :UITextField!
    @IBOutlet var emailTextField        :UITextField!
    @IBOutlet var confirmChangesButton  :UIButton!
    
    //MARK: - Interactivity Methods
    
    @IBAction func pressed(button: UIButton) {
        guard let firstName = firstNameTextField.text else {
            return
        }
        guard let lastName = lastNameTextField.text else {
            return
        }
        guard let phoneNum = phoneNumTextField.text else {
            return
        }
        guard let email = emailTextField.text else {
            return
        }
        currentContact.firstName = firstName
        currentContact.lastName = lastName
        if isValidEmail(email: email) {
            currentContact.email = email
            allowChanges1 = true
        } else {
            emailTextField.text = "Please enter valid email."
            allowChanges1 = false
        }
        if isValidPhoneNum(phoneNum: phoneNum) {
            currentContact.phoneNum = phoneNum
            allowChanges2 = true
        } else {
            phoneNumTextField.text = "Please enter valid phone number."
            allowChanges2 = false
        }
        if allowChanges1 && allowChanges2 {
        let alert = UIAlertController(title: "Changes Confirmed", message: "Contact information has been updated.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - Validation Methods
    
    func isValidPhoneNum(phoneNum: String) -> Bool {
        let phoneNumRegEx = "^(\\([0-9]{3}\\)|[0-9]{3}-)[0-9]{3}-[0-9]{4}$"
        
        let phoneNumTest = NSPredicate(format: "SELF MATCHES %@", phoneNumRegEx)
        return phoneNumTest.evaluate(with: phoneNum)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = currentContact else {
            self.navigationController!.popViewController(animated: true)
            return
        }
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneNumTextField.text = contact.phoneNum
        emailTextField.text = contact.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
