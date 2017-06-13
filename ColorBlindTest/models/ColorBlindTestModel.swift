//
//  ColorBlindTestModel.swift
//  ColorBlindTest
//
//  Created by joins on 2017. 6. 9..
//  Copyright © 2017년 DuckKite. All rights reserved.
//

import Foundation

class ColorBlindTestModel {
    // 최대 스텝수
    let MAX_STEP = 10
    // 현재 스텝
    var curStep = 0
    // 정답 갯수
    var corectAnswer = 0
    
    var baseContainer = [String:Int]()
    var gameContainer = [String:Int]()
    
    var testState:TestState
    
    var testImage: String?
    var correctNumber: Int?
    
    init(_ testState:TestState) {
        // 프로젝트의 colorblindimage 폴더의 png 파일로 이미지를 메모리화 한다
        // img_정답숫자(0~9)_중복방지의 파일명으로 생서
        let imageArray = Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: "colorblindimage")
        for imageName in imageArray! {
            var temp = imageName.lastPathComponent.components(separatedBy: "_")
            if temp.count == 3, let value = Int(temp[1]){
                print( String(value) + " : " + imageName.lastPathComponent)
                baseContainer.updateValue(value, forKey: imageName.lastPathComponent)
            }
        }
        self.testState = testState
    }
    
    // 테스트 초기화
    public func prepare() {
        gameContainer.removeAll()
        gameContainer.addAll(other: baseContainer)
        curStep = 0
        corectAnswer = 0
        setData()
    }
    
    // 테스트 데이터 세팅
    private func setData() {
        curStep += 1
        let index: Int = Int(arc4random_uniform(UInt32(gameContainer.count)))
        let randomKey = Array(gameContainer.keys)[index]
        testImage = "colorblindimage/" + randomKey
        correctNumber = gameContainer.removeValue(forKey: randomKey)
        
        testState.setUI()
    }
    
    
    public func hitNumber(_ number:Int) {
        if number == correctNumber {
            corectAnswer += 1
        }
        if curStep == MAX_STEP {
            testState.finishTest()
        } else  {
            setData()
        }
    }
    
    public func getProgress() -> Float {
        return Float(curStep) / Float(MAX_STEP)
    }

    
}

protocol TestState {
    func setUI()
    func finishTest()
}

// Dictionary 복사
extension Dictionary {
    mutating func addAll(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
