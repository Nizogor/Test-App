//
//  AnswerViewController.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 30/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import UIKit

class AnswerViewController: OutputListenerViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var sentences: [String]!
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performAnimation()
    }
    
    private func performAnimation() {
        
        label.isHidden = true
        label.text = sentences[currentIndex]
        view.layoutIfNeeded()
        
        label.center = CGPoint(x: self.view.center.x + label.bounds.width / 2 + 50,
                               y: self.label.center.y)
        label.isHidden = false
        
        let animationDuration = TimeInterval(label.bounds.width / 10)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveLinear, .repeat], animations: {
            let x = self.view.center.x - self.label.bounds.width / 2 - 50
            self.label.center = CGPoint(x: x, y: self.label.center.y)
        })
    }
    
    override func plusButtonPressed() {
        let nextIndex = currentIndex + 1
        if nextIndex < sentences.count {
            currentIndex = nextIndex
            performAnimation()
        } else {
            navigationController?.popToRootViewController(animated: false)
        }
    }
    
    override func minusButtonPressed() {
        navigationController?.popToRootViewController(animated: false)
    }
}
