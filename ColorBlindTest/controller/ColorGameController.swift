//
//  ColorGameController.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 22..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import UIKit
import Lottie
import SCLAlertView

class ColorGameController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout ,ColorGameState {
    
    @IBOutlet weak var gameTable: UICollectionView!
    @IBOutlet weak var stage: UILabel!
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var infoIcon: UIView!
    @IBOutlet weak var modeIconContainer: UIView!
    var colorGameBrain: ColorGameBrain!
    
    @IBOutlet weak var titleName: UINavigationItem!
    @IBOutlet weak var timer: UILabel!
    
    let startButton = LOTAnimationView(name: "play_and_like_it")
    var gameMode: AppInfo.GameMode!
    var gameTimer:Timer?
    var count = 60
    var isSetLottie = false
    var bestPoint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorGameBrain = ColorGameBrain(self)
        gameTable.dataSource = self
        gameTable.delegate = self
        bestPoint = UserDefaults.standard.integer(forKey: gameMode.getName() + "Best")
        prepare()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isSetLottie {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {_ in
                self.setLotties()
            })
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.gameTimer?.invalidate();
    }
    
    private func setLotties() {
        isSetLottie = true;
        
        self.infoIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ColorGameController.infoIconTapped(sender:))))
        startButton?.frame = CGRect(x: 0, y: 0, width: self.infoIcon.bounds.size.width, height: self.infoIcon.bounds.size.height)
        startButton?.contentMode = .scaleAspectFit
        startButton?.loopAnimation = false
        startButton?.play()
        startButton?.pause()
        self.infoIcon.addSubview(startButton!)
        
        self.titleName.title = gameMode?.getName()
        
        var gameModeIcon: LOTAnimationView
        if gameMode == AppInfo.GameMode.Infinite {
            gameModeIcon = LOTAnimationView(name: "infinite_rainbow")
        } else {
            gameModeIcon = LOTAnimationView(name: "clock")
        }
        
        gameModeIcon.frame = CGRect(x: 0, y: 0, width: self.modeIconContainer.frame.size.width, height: self.modeIconContainer.frame.size.height)
        gameModeIcon.contentMode = .scaleAspectFit
        gameModeIcon.loopAnimation = true
        self.modeIconContainer.insertSubview(gameModeIcon, belowSubview: timer)
        gameModeIcon.play()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     * 뒤로가기
     */
    @IBAction func backToMain(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorGameBrain.getCellCount();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorGameCell
        cell.backGroundView.backgroundColor = UIColor.init(rgb: indexPath.row == colorGameBrain.differantIndex ? colorGameBrain.differanceColor : colorGameBrain.curColor)
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (collectionView.frame.width / CGFloat(colorGameBrain.gameValue.size))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        colorGameBrain.hitColor(index: indexPath.row)
    }
    
    
    func setGameData() {
        NSLog("setGameData")
        stage.text = "Stage : \(colorGameBrain.curStage)\nBest : \(bestPoint)"
        gameTable.reloadData()
    }
    
    public func prepare() {
        NSLog("Prepare!!!")
        if infoContainer.isHidden {
            infoContainer.isHidden = false
        }
    }
    
    public func idle() {
        setGameData()
        if !infoContainer.isHidden {
            infoContainer.isHidden = true
        }
    }
    public func correct() {
        NSLog("Corrent!!!")
    }
    public func gameOver(score: Int) {
        NSLog("gameOver!!!")
        if score > bestPoint {
            SCLAlertView().showSuccess(NSLocalizedString("Congratulations!!", comment: ""), subTitle: NSLocalizedString("You have updated your record.", comment: ""))
            bestPoint = score
            UserDefaults.standard.set(bestPoint, forKey: gameMode.getName() + "Best")
        }
        
        self.gameTimer?.invalidate();
        self.prepare()
        self.count = 60
        self.timer.text = ""
        self.gameTimer = nil
        stage.text = ""
    }
    
    func infoIconTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            startButton?.play(completion: { finished in
                self.colorGameBrain.nextGame()
                if self.gameMode == AppInfo.GameMode.SixtySec {
                    self.timer.text = String(self.count)
                    self.gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in
                        if self.count == 0 {
                            self.colorGameBrain.hitColor(index: -1)
                        } else {
                            self.count -= 1
                            self.timer.text = String(self.count)
                        }
                        
                    })
                }
            })
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
