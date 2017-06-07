//
//  ViewController.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 22..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import UIKit
import Lottie
import SCLAlertView

class MainController: UIViewController {

    @IBOutlet weak var testColorInfinite: UIButton!
    @IBOutlet weak var testColor60: UIButton!
    @IBOutlet weak var testColorBlindness: UIButton!
    @IBOutlet weak var titleContainer: UIView!
    
    
    
    let movingEye = LOTAnimationView(name: "moving_eye")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initVariable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func infoButtonClick(_ sender: UIButton) {
        switch sender.tag {
        case AppInfo.GameMode.Infinite.rawValue:
            SCLAlertView().showInfo(NSLocalizedString("Infinite Mode", comment: ""), subTitle: NSLocalizedString("Click on a square with a different color.", comment: ""))
        case AppInfo.GameMode.SixtySec.rawValue:
            SCLAlertView().showInfo(NSLocalizedString("60sec Mode", comment: ""), subTitle: NSLocalizedString("Click on a square with a different color for 60 seconds.", comment: ""))
        default:
            break;
        }
    }
    func initVariable() {
        movingEye?.frame = CGRect(x: 0, y: 0, width: self.titleContainer.frame.size.width, height: self.titleContainer.frame.size.height)
        movingEye?.contentMode = .scaleAspectFit
        movingEye?.loopAnimation = true
        self.titleContainer.addSubview(movingEye!)
        movingEye?.play()
        
        // 버튼의 배경과 모양을 설정한다.
        let backGroundColor = UIColor(rgb: 0x2c3e50)
        UIUtils.makeRadius(button: testColorInfinite, cornerRadius: 10, backGroundColor: backGroundColor);
        UIUtils.makeRadius(button: testColor60, cornerRadius: 10, backGroundColor: backGroundColor);
        UIUtils.makeRadius(button: testColorBlindness, cornerRadius: 10, backGroundColor: backGroundColor);
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var gameMode = AppInfo.GameMode.Infinite
        if segue.identifier == "infinite" {
            gameMode = AppInfo.GameMode.Infinite
        } else if segue.identifier == "60sec" {
            gameMode = AppInfo.GameMode.SixtySec
        }
        if let toViewControlller = segue.destination as? ColorGameController {
            toViewControlller.gameMode = gameMode
        }
    }
}

