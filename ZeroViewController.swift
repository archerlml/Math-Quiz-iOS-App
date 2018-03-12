//
//  ZeroViewController.swift
//  Test
//
//  Created by Minglu LIU on 12/11/16.
//  Copyright © 2016 Minglu LIU. All rights reserved.
//

import UIKit
import Foundation

class ZeroViewController: UIViewController {
    var operation = ""
    
    @IBAction func divide(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func btnA(_ sender: UIButton) {
        operation = "+"
        viewDidAppear(true)
    }
    
    @IBAction func btnS(_ sender: UIButton) {
        operation = "-"
        viewDidAppear(true)
        //self.performSegue(withIdentifier: "subtractionSegue", sender: self);
    }
    
    @IBAction func btnP(_ sender: UIButton) {
        operation = "*"
        viewDidAppear(true)
        //self.performSegue(withIdentifier: "productionSegue", sender: self);
    }

    override func viewDidAppear(_ animated: Bool) {
        if operation != ""{
        self.performSegue(withIdentifier: "firstSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let DestViewController = segue.destination as!  ViewController
        DestViewController.operation = operation
//        if segue.identifier == "additionSegue" {
//            let DestViewController = segue.destination as!  ViewController
//            DestViewController.operation = "+"
//            DestViewController.oper.text = "+"
//        } else if segue.identifier == "subtractionSegue" {
//            let DestViewController = segue.destination as!  ViewController
//            DestViewController.operation = "-"
//            DestViewController.oper.text = "-"
//        } else if segue.identifier == "productionSegue" {
//            let DestViewController = segue.destination as!  ViewController
//            DestViewController.operation = "*"
//            DestViewController.oper.text = "*"
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func viewDidAppear(_ animated: Bool) {
//        self.performSegue(withIdentifier: "View", sender: self)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
