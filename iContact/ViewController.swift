//
//  ViewController.swift
//  iContact
//
//  Created by ANI on 1/18/17.
//  Copyright © 2017 Shane Empie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contactArray = [Contact]()
    
    @IBOutlet var contactTableView  :UITableView!
    
    //MARK: - Interactivity Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        let indexPath = contactTableView.indexPathForSelectedRow!
        let currentContact = contactArray[indexPath.row]
        destinationVC.currentContact = currentContact
    }

    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactArray = fillArray()
        contactArray = alphaSortAToZ(stringArray: contactArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contactArray = alphaSortAToZ(stringArray: contactArray)
        contactTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Sort Methods
    
    func alphaSortAToZ(stringArray: [Contact]) -> [Contact] {
        var sortedArray = [Contact]()
        sortedArray = stringArray.sorted{$0.lastName.localizedCaseInsensitiveCompare($1.lastName) == ComparisonResult.orderedAscending}
        return sortedArray
    }
    
    //MARK: - Temp Methods
    
    func fillArray() -> [Contact] {
        let contact1 = Contact(firstName: "Shane", lastName: "Empie", phoneNum: "(123)456-7890", email: "sempie@fakeemails.com")
        let contact2 = Contact(firstName: "Bob", lastName: "Bloblaw", phoneNum: "(555)555-1212", email: "bbloblaw@fakeemails.com")
        let contact3 = Contact(firstName: "Richard", lastName: "Ricardo", phoneNum: "(123)867-5309", email: "rr23@fakeemails.com")
        return [contact1, contact2, contact3]
    }



}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        let currentContact = contactArray[indexPath.row]
        cell.fullNameLabel.text = currentContact.fullNameByLast
        cell.phoneNumLabel.text = currentContact.phoneNum
        cell.phoneNumLabel.textAlignment = .right
        cell.emailLabel.text = currentContact.email
        cell.emailLabel.textAlignment = .right
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentContact = contactArray[indexPath.row]
        print("Row \(indexPath.row) \(currentContact.fullNameByLast!)")
        
    }
    //https://www.youtube.com/watch?v=ju-JF1GbTHU and https://www.andrewcbancroft.com/2015/07/16/uitableview-swipe-to-delete-workflow-in-swift/ used to inform
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contactArray.remove(at: indexPath.row)
            contactTableView.reloadData()
        }
    }

}
