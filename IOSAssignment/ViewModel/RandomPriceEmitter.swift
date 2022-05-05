//
//  RandomPriceEmitter.swift
//  IOSAssignment
//
//  Created by Abdul Razzak on 30/04/2022.
//

import Foundation

protocol RandomPriceModifier {
    func price()
}

class RandomPriceEmitter {
    
    private var timer: Timer!
    var delegate: RandomPriceModifier?
    
    init() {
        setupTimer()
    }
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1000, target: self, selector: #selector(notifyDelegate), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc
    func notifyDelegate() {
        delegate?.price()
    }
}
