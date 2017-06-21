//
//  ColorBlindViewController.swift
//  ColorBlindTest
//
//  Created by joins on 2017. 6. 9..
//  Copyright © 2017년 DuckKite. All rights reserved.
//

import UIKit
import SCLAlertView
import GoogleMobileAds

class ColorBlindViewController: UIViewController, TestState {

    
    
    @IBOutlet weak var colorBlindImage: UIImageView!
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var stepProgress: UIProgressView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    var colorBlindTestModel: ColorBlindTestModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppInfo.loadAD(bannerView: bannerView, viewController: self)
        colorBlindTestModel = ColorBlindTestModel(self)
        colorBlindTestModel.prepare()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func setUI() {
        colorBlindImage.image = UIImage(named: colorBlindTestModel.testImage!)
        stepProgress.progress = colorBlindTestModel.getProgress()
        step.text = String(colorBlindTestModel.curStep) + "/" + String(colorBlindTestModel.MAX_STEP)
    }
    public func finishTest() {
        SCLAlertView().showSuccess(String(colorBlindTestModel.corectAnswer) + "/" + String(colorBlindTestModel.MAX_STEP), subTitle: NSLocalizedString("It is your record.", comment: ""))
        colorBlindTestModel.prepare()
    }
    
    @IBAction func numberClick(_ sender: UIButton) {
        colorBlindTestModel.hitNumber(sender.tag)
    }

    @IBAction func backToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
