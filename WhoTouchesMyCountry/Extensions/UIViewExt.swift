//
//  UIViewExt.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 07/08/2021.
//

import UIKit

public extension UIView {
    func popIn() {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func popOut(completion : ((Bool) -> Void)? = { _ in }) {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: completion)
    }
}
