//
//  ViewController.swift
//  Test
//
//  Created by Minglu LIU on 12/11/16.
//  Copyright © 2016 Minglu LIU. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var arg1: UILabel!
    @IBOutlet weak var arg2: UILabel!
    @IBOutlet weak var oper: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
//    override func viewDidAppear(_ animated: Bool) {
//        if backHome {
//            self.performSegue(withIdentifier: "zeroSegue", sender: self)
//        }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        let DestVC = segue.destination as!  ZeroViewController
//        DestVC.operation = ""
//    }
    var operation = String()
    var backPressed = Bool()
    var correct = false
    var oneDigit = false
    var result = -1
    var timer5s = Timer()
    var timer1s = Timer()
    var alert = UIAlertController()
    var answer = Int()
    var counter = 5
    var count = Int()
    var tempResult = String()
    var correctCount = Int()
    
    @IBAction func btnNum(_ sender: UIButton) {
        if oneDigit == true {
            if sender.tag < 10 {
                resultLabel.text = String(sender.tag)
                result = sender.tag
                checkAnswer(result, num2: answer)
            }
        }else{
            tempResult += String(sender.tag)
            resultLabel.text = tempResult
            result = Int(tempResult)!
        }
    }
    @IBAction func btnBack(_ sender: UIButton) {
        backPressed = true
        backAlert()
    }
    func backAlert(){
        let alert = UIAlertController(title: "Alert", message: "Are you sure to start over?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            switch action.style{
            case .default:
                self.viewDidAppear(true)
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
            switch action.style{
            case .default:
                self.viewDidAppear(true)
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        checkAnswer(result, num2: answer)
    }
    override func viewDidLoad() {
        resultLabel.text=""
        correctCount = 0
        count = 0
        progressLabel.text = "Question 1 out of 10 questions"
        timerLabel.text = "Time left: 5 s"
        oper.text = operation
        initialize()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func initialize(){
        if(count >= 10){
            timer5s.invalidate()
            timer1s.invalidate()
            viewDidAppear(true)
        }
        oper.text = operation
        count += 1
        resetTimer()
        progressLabel.text = "Question " + String(count) + " out of 10 questions"
        var numA = Int(arc4random_uniform(9) + 1)
        var numB = Int(arc4random_uniform(9) + 1)
        if operation == "-" {
            while(numA <= numB){
                numA = Int(arc4random_uniform(9) + 1)
                numB = Int(arc4random_uniform(9) + 1)
            }
        }
        arg1.text = String(numA)
        arg2.text = String(numB)
        calculate(num1: numA, num2: numB)
    }
    func startTimer(){
        timer5s = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func resetTimer(){
        timer5s.invalidate()
        counter = 5
        resultLabel.text = ""
        tempResult = ""
        startTimer()
    }
    func update(){
        if counter > 0 {
            timerLabel.text = "Time left: " + String(counter) + " s"
            counter -= 1
        }else{
            if(tempResult != ""){
                checkAnswer(Int(tempResult)!, num2: answer)
                count -= 1
            }
            initialize()
        }
    }
    func showAlert(){
        if correct {
            let alertController = UIAlertController(title: "Correct!", message: "", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "Wrong!", message: "", preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func dismissAlert(){
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func calculate(num1:Int, num2:Int){
        if operation == "+" {
            answer = num1 + num2
        }
        if operation == "-" {
            answer = num1 - num2
        }
        if operation == "*" {
            answer = num1 * num2
        }
        if answer / 10 > 0 {
            oneDigit = false
        }else{
            oneDigit = true
        }
    }
    func checkAnswer(_ num1: Int, num2:Int){
        
        if num1 == num2 {
            correct = true
            correctCount += 1
        }else{
            correct = false
        }
        
        timer1s = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.showAlert), userInfo: nil, repeats: false)
        resultLabel.text = ""
        tempResult = ""
        timer1s = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.dismissAlert), userInfo: nil, repeats: false)
        if(count >= 10){
            timer5s.invalidate()
            timer1s.invalidate()
            viewDidAppear(true)
        }else{
            initialize()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if count >= 10 || backPressed {
            self.performSegue(withIdentifier: "finalSegue", sender: self)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalVC = segue.destination as! SecondViewController
        finalVC.grade = correctCount
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

