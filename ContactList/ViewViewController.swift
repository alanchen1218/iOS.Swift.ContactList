//
//  ViewViewController.swift
//  ContactList
//
//  Created by Alan Chen on 5/22/18.
//  Copyright © 2018 Alphie. All rights reserved.
//

import UIKit

class ViewViewController: UIViewController {

    var item: List!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = item.firstName! + " " + item.lastName!
        numberLabel.text = item.number
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
