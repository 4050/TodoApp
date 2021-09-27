//
//  UIViewController + DismissKeyboard.swift
//  NoteAppSE
//
//  Created by Stanislav on 26.09.2021.
//

import Foundation
import UIKit

extension UITableViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(UITableViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
