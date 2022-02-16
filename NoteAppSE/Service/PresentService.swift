//
//  PresentService.swift
//  NoteAppSE
//
//  Created by Stanislav on 06.02.2022.
//

import Foundation
import UIKit

class PresentService {
    static let shared = PresentService()
    
    func getViewController<T: UIViewController>(storyboard: String, viewControllerType: T.Type, identifierVC: String) -> T {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = (storyBoard.instantiateViewController(withIdentifier: identifierVC) as? T)
        return vc!
    }
    
    func presentService(rootVC: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootVC)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        return navigationController
    }
}
