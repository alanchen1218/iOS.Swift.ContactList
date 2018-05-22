//
//  AddViewController.swift
//  ContactList
//
//  Created by Alan Chen on 5/22/18.
//  Copyright © 2018 Alphie. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    weak var delegate: AddViewControllerDelegate?
    weak var note: List?
    var indexPath: IndexPath?
    
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        let firstName = firstNameText.text
        let lastName = lastNameText.text
        let number = numberText.text
        delegate?.addItem(by: self, with: firstName!, with: lastName!, with: number!, at: indexPath)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let n = note {
            firstNameText.text = n.firstName
            lastNameText.text = n.lastName
            numberText.text = n.number
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
