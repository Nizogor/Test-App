//
//  OutputListenerViewController.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 28/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class OutputListenerViewController: UIViewController {

    private let volumeView = MPVolumeView()
    private let kOutputVolumeKeyPath = "outputVolume"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Deinitialization
    
    deinit {
        AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: kOutputVolumeKeyPath)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        listenVolumeChanges()
        setupVolumeView()
    }
    
    private func listenVolumeChanges() {
        AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: [.old, .new], context: nil)
    }
    
    private func setupVolumeView() {
        
        view.addSubview(volumeView)
        
        volumeView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: volumeView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: volumeView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 3, constant: 0)
            ])
    }
    
    // MARK: - Observing
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard self.isEqual(navigationController?.viewControllers.last) else {
            return
        }
        
        guard let newValue = change?[.newKey] as? NSNumber else {
            return
        }
        
        guard let oldValue = change?[.oldKey] as? NSNumber else {
            return
        }
        
        guard abs(newValue.floatValue - oldValue.floatValue) < 0.1 else {
            return
        }
        
        if newValue.floatValue > oldValue.floatValue {
            plusButtonPressed()
        } else {
            minusButtonPressed()
        }
        
        if newValue.floatValue > 0.8 || newValue.floatValue < 0.2 {
            volumeView.setVolume(0.5)
        }
    }
    
    func plusButtonPressed() {
        print("+")
    }
    
    func minusButtonPressed() {
        print("-")
    }
}
