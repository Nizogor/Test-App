//
//  SelectFirstLetterViewController.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 30/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import UIKit

class SelectFirstLetterViewController: OutputListenerViewController {

    @IBOutlet weak var label: UILabel!
    
    private lazy var letters: [String] = {
        let array = TicketRepository().allTickets.map { $0.questionFirstLetter }
        let set = Set(array)
        return Array(set).sorted()
    }()
    
    private var currentIndex = 0 {
        didSet {
            label.text = letters[currentIndex]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = letters.first
        scheduleTimer()
    }
    
    private func scheduleTimer() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            let nextIndex = self.currentIndex + 1
            self.currentIndex = nextIndex < self.letters.count ? nextIndex : 0
        }
    }
    
    override func plusButtonPressed() {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "SelectQuestionViewController") as! SelectQuestionViewController
        viewController.questions = TicketRepository().allTickets.map { $0.question }
            .filter { $0.starts(with: letters[currentIndex]) }
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    override func minusButtonPressed() {
        if letters.count > 0 {
            currentIndex = 0
        }
    }
}
