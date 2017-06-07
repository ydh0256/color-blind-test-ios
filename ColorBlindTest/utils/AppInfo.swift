//
//  AppInfo.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 29..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import Foundation

class AppInfo {
    public enum GameMode: Int{
        case Infinite, SixtySec, ColorBlindTest
        func getName() -> String {
            switch self {
            case .Infinite:
                return NSLocalizedString("Infinite Mode", comment: "")
            case .SixtySec:
                return NSLocalizedString("60sec Mode", comment: "")
            case .ColorBlindTest:
                return NSLocalizedString("Color blind Test", comment: "")
            }
        }
    }
}
