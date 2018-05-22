//
//  AddViewControllerDelegate.swift
//  ContactList
//
//  Created by Alan Chen on 5/22/18.
//  Copyright © 2018 Alphie. All rights reserved.
//

import Foundation

protocol AddViewControllerDelegate: class {
    func addItem(by controller: AddViewController, with firstName: String, with lastName: String, with number: String, at indexPath: IndexPath?)
}
