//
//  ColorBlindViewController.swift
//  ColorBlindTest
//
//  Created by joins on 2017. 6. 9..
//  Copyright © 2017년 DuckKite. All rights reserved.
//

import UIKit

class ColorBlindViewController: UIViewController {

    
    
    @IBOutlet weak var colorBlindImage: UIImageView!
    @IBOutlet weak var step: UILabel!
    @IBOutlet weak var stepProgress: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorBlindImage.image = UIImage(named: "colorblindimage/img_01_00.png")
        
        let filemanager:FileManager = FileManager()
        
        print(NSTemporaryDirectory() + "colorblindimage")
        
        let files = filemanager.enumerator(atPath: NSTemporaryDirectory() + "colorblindimage")
        for filename in files!
        {
           print(filename)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
