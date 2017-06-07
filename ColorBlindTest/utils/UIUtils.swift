//
//  UIUtils.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 22..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import Foundation
import UIKit

class UIUtils {
    static func makeBorder(button: UIButton, borderWidth: CGFloat){
        self.makeBorder(button: button, borderWidth: borderWidth, borderColor: button.tintColor.cgColor)
    }
    static func makeBorder(button: UIButton, borderWidth: CGFloat, borderColor: CGColor){
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = borderColor
    }
    static func makeRadius(button: UIButton, cornerRadius: CGFloat){
        self.makeRadius(button: button, cornerRadius: cornerRadius, backGroundColor: UIColor.clear)
    }
    static func makeRadius(button: UIButton, cornerRadius: CGFloat, backGroundColor: UIColor){
        button.layer.cornerRadius = cornerRadius
        button.backgroundColor = backGroundColor
    }
}
