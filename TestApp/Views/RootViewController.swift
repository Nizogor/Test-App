//
//  RootViewController.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 30/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        let viewController = storyboard!.instantiateViewController(withIdentifier: "SelectFirstLetterViewController") as! SelectFirstLetterViewController
        navigationController?.pushViewController(viewController, animated: false)
    }
}
