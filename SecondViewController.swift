//
//  SecondViewController.swift
//  Test
//
//  Created by Minglu LIU on 12/11/16.
//  Copyright © 2016 Minglu LIU. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController {
    @IBOutlet weak var gradeLabel: UILabel!
    var grade=Int()
    var pressed = Bool()
    
    @IBAction func btnHome(_ sender: UIButton) {
        pressed = true
        viewDidAppear(true)
    }
    override func viewDidLoad() {
        gradeLabel.text = "final Grade is " + String(grade)
        pressed = false
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if pressed {
            self.performSegue(withIdentifier: "zeroSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let zeroVC = segue.destination as! ZeroViewController
        zeroVC.operation = ""
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
