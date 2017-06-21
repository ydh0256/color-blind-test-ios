//
//  AppInfo.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 29..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AppInfo {
    static let AD_UINIT_ID = "ca-app-pub-3037898101085814/5164999883"
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
    
    static func loadAD(bannerView:GADBannerView, viewController:UIViewController){
        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID];
        bannerView.adSize = kGADAdSizeSmartBannerPortrait
        bannerView.adUnitID = AD_UINIT_ID
        bannerView.rootViewController = viewController
        bannerView.load(request)
    }
}
