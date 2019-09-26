//
//  MPVolumeView+Volume.swift
//  TestApp
//
//  Created by Nikita Teplyakov on 28/05/2019.
//  Copyright © 2019 VZLET. All rights reserved.
//

import Foundation
import MediaPlayer

extension MPVolumeView {
    func setVolume(_ volume: Float) {
        // Search for the slider
        let slider = subviews.first(where: { $0 is UISlider }) as? UISlider
        // Update the slider value with the desired volume.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            slider?.value = volume
        }
    }
}
