//
//  ColorGameBrain.swift
//  HumanSenceTest
//
//  Created by Yoo Duckhyun on 2017. 5. 23..
//  Copyright © 2017년 Yoo Duckhyun. All rights reserved.
//

import Foundation

class ColorGameBrain {
    var curStage: Int {
        didSet {
            curDifficult = getDifficult(stage: self.curStage)
        }
    }
    var gameValue: (size: Int, distance: Int)
    private var curDifficult: Difficult! {
        didSet{
            if oldValue != self.curDifficult {
                gameValue = self.curDifficult.getGameSizeAndColorDistance()
            }
        }
    }
    var curColor: Int!
    var differanceColor: Int!
    var differantIndex: Int
    private var gameSate: ColorGameState
    private enum Difficult {
        case SuperEasy, VeryEasy, Easy, Normal, Hard, VeryHard, SuperHard, Hell, SuperHell
        func getGameSizeAndColorDistance() -> (size: Int, distance: Int) {
            switch self {
            case .SuperEasy:
                return (2, 0x202020);
            case .VeryEasy:
                return (3, 0x202020);
            case .Easy:
                return (4, 0x202020);
            case .Normal:
                return (5, 0x181818);
            case .Hard:
                return (6, 0x181818);
            case .VeryHard:
                return (7, 0x151515);
            case .SuperHard:
                return (8, 0x101010);
            case .Hell:
                return (9, 0x080808);
            case .SuperHell:
                return (9, 0x050505)
            }
        }
    }
    
    init(_ gameSate: ColorGameState) {
        self.curStage = 0
        self.gameValue = (0, 0)
        self.differantIndex = 0
        self.gameSate = gameSate
    }
    
    public func nextGame() {
        self.curStage += 1
        setData()
    }
    
    public func hitColor(index: Int) {
        NSLog("hitColor : \(index)")
        if index == differantIndex {
            self.gameSate.correct()
            self.nextGame()
        } else {
            self.gameSate.gameOver(score: self.curStage)
            self.curStage = 0
        }
    }
    
    public func getCellCount() -> Int {
        return gameValue.size * gameValue.size
    }
    
    private func setData() {
        // 기본색, 차이색, 차이를 낼 인덱스를 세팅
        self.curColor = self.getSaftyRandomBaseColor()
        self.differanceColor = arc4random_uniform(1) == 0 ? self.curColor + gameValue.distance : self.curColor - gameValue.distance
        self.differantIndex = Int(arc4random_uniform(UInt32(getCellCount()-1)))
        // 게임 준비완료
        self.gameSate.idle()
    }
    
    // 스테이지에 따라 난이도 조정
    private func getDifficult(stage: Int) -> Difficult {
        if(0 <= stage && stage < 5) {
            return Difficult.SuperEasy
        } else if(stage < 10) {
            return Difficult.VeryEasy
        } else if(stage < 15) {
            return Difficult.Easy
        } else if(stage < 20) {
            return Difficult.Normal
        } else if(stage < 25) {
            return Difficult.Hard
        }else if(stage < 35) {
            return Difficult.VeryHard
        } else if(stage < 45) {
            return Difficult.SuperHard
        } else if(stage < 100) {
            return Difficult.Hell
        } else {
            return Difficult.SuperHell
        }
    }
    
    // RGB 각각 값중에서 한가지라도 합할때 255을 넘어버리면 색의 변화폭이 너무 커서 255에 너무 가깝지 않게 조정
    private func getSaftyRandomBaseColor() -> Int {
        while(true){
            let rgb = Int(arc4random_uniform(0xdddddd))
            let red = (rgb >> 16) & 0xFF
            let green = (rgb >> 8) & 0xFF
            let blue = rgb & 0xFF
            if red < 220 && green < 220 && blue < 220 {
                return rgb 
            }
        }
        
    }
    
}

//게임 상태 프로토콜
public protocol ColorGameState {
    func prepare()
    func idle()
    func correct()
    func gameOver(score: Int)
}

