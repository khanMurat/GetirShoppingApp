//
//  BaseViewController.swift
//  GetirFinalCase
//
//  Created by Murat on 9.04.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    func showAlert(title:String,message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in}
        
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}
