//
//  SelectQuestionViewController.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 27/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import UIKit

class SelectQuestionViewController: OutputListenerViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var questions: [String]!
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performAnimation()
    }
    
    private func performAnimation() {
        
        guard self.isEqual(navigationController?.viewControllers.last) else {
            return
        }
        
        label.isHidden = true
        label.text = questions[currentIndex]
        view.layoutIfNeeded()
        
        label.center = CGPoint(x: self.view.center.x + label.bounds.width / 2 + 50,
                               y: self.label.center.y)
        label.isHidden = false
        
        let questionsCount = questions.count
        
        let animationDuration = TimeInterval(label.bounds.width / 10)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveLinear], animations: {
            let x = self.view.center.x - self.label.bounds.width / 2 - 50
            self.label.center = CGPoint(x: x, y: self.label.center.y)
        }) { [weak self] _ in
            
            guard let currentIndex = self?.currentIndex else {
                return
            }
            
            let nextIndex = currentIndex + 1
            
            self?.currentIndex = nextIndex < questionsCount ? nextIndex : 0
            self?.performAnimation()
        }
    }
    
    override func plusButtonPressed() {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "AnswerViewController") as! AnswerViewController
        viewController.sentences = TicketRepository().allTickets
            .first { $0.question == questions[currentIndex] }!
            .sentences
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    override func minusButtonPressed() {
        navigationController?.popToRootViewController(animated: false)
    }
}
