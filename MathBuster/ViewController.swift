//
//  ViewController.swift
//  MathBuster
//
//  Created by Amir Umarov on 21.02.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var currentResult = 0
    var currentScore = 0
    var timer:Timer?
    var maxTime: Double = 30
    var currentStatus = "Easy"
    
    
    var name: UILabel = {
        let label = UILabel()
        label.text = "Math Buster"
        label.textColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0)
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Easy 😃", "Medium 🧐", "Hard 🥵"])
        control.selectedSegmentIndex = 0
        control.layer.borderColor = UIColor.gray.cgColor
        control.tintColor = .gray
        control.addTarget(self, action: #selector(suitDidChange), for: .valueChanged)
        return control
        
    }()
    
    var score: CustomLabel = {
        let label = CustomLabel(frame: CGRect(x: 20, y: 100, width: 200, height: 100))
        label.text = "Score: 0"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
        
    }()
    
    var avatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image1.png"))
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 2.0
        return imageView
        
    }()
    
    var task: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "7/4 ="
        textLabel.font = .systemFont(ofSize: 15, weight: .bold)
        textLabel.textColor = UIColor(red: 0, green: 128/255, blue: 0, alpha: 1.0)
        return textLabel
        
    }()
    
    //    var time: UILabel = {
    //        let textLabel = UILabel()
    //        textLabel.text = "  00 : 0"
    //        textLabel.textColor = .black
    //        textLabel.font = .systemFont(ofSize: 28, weight: .bold)
    //        textLabel.backgroundColor = UIColor(red: 0, green: 100/255, blue: 0, alpha: 1.0)
    //        return textLabel
    
    var progressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .init(UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 1))?.withAlphaComponent(0.3)
        return view
        
    }()
    
    var progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .init(UIColor(red: 79/255, green: 111/255, blue: 82/255, alpha: 1))
        view.setProgress(0.3, animated: true)
        return view
        
    }()
    
    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(run), userInfo: nil, repeats: true)
    }
    
    @objc func run() {
        self.maxTime -= 1
        print(self.maxTime)
        
        if self.maxTime == 1 {
            timer?.invalidate()
        }
        self.progressView.setProgress(Float(self.maxTime/30), animated: true)
        
    }
    
    var result: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Result"
        textField.textColor = .gray
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 15, weight: .bold)
        textField.backgroundColor = .white
        return textField
        
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0, green: 100/255, blue: 0, alpha: 1.0)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return button
        
    }()
    
    var restart: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(restartTapped), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        generateEquasion()
        startTime()
        
    }
    
    func setUI(){
        view.addSubview(name)
        view.addSubview(segmentControl)
        view.addSubview(score)
        view.addSubview(avatar)
        view.addSubview(task)
        //        view.addSubview(time)
        progressContainer.addSubview(progressView)
        view.addSubview(result)
        view.addSubview(button)
        view.addSubview(restart)
        view.addSubview(progressContainer)
        
        
        name.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.height.equalTo(40)
        }
        segmentControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        score.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(segmentControl.snp.bottom).offset(15)
            make.height.equalTo(40)
        }
        
        avatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(score.snp.bottom).offset(10)
            make.height.equalTo(45)
            make.width.equalTo(45)
            
        }
        
        task.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatar.snp.bottom).offset(20)
            
            
        }
        
        //        time.snp.makeConstraints { make in
        //            make.centerX.equalToSuperview()
        //            make.top.equalTo(task.snp.bottom).offset(20)
        //            make.leading.equalToSuperview().offset(16)
        //            make.trailing.equalToSuperview().offset(-16)
        //            make.height.equalTo(80)
        
        
        progressContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(90)
            make.top.equalTo(task.snp.bottom).offset(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(progressContainer.snp.bottom).inset(20)
            make.height.equalTo(5)
            
        }
        
        result.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressContainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
            
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(result.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            
        }
        
        restart.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(button.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
            
        }
        
        progressContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(90)
            make.top.equalTo(task.snp.bottom).offset(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(5)
            
        }
    }
        
        func generateEquasion() {
            var a = Int.random(in: 1...9)
            var b = Int.random(in: 1...9)
            var array = ["-", "+", "*", "/"]
            var symbol = array.randomElement()!
            task.text = "\(a) \(symbol) \(b) = "
            currentResult = calculateResolt(num1: a, num2: b, symbol: symbol)
            print(currentResult)
        }
        
        func easy() {
            var a = Int.random(in: 1...9)
            var b = Int.random(in: 1...9)
            var array = ["-", "+", "*", "/"]
            var symbol = array.randomElement()!
            task.text = "\(a) \(symbol) \(b) = "
            currentResult = calculateResolt(num1: a, num2: b, symbol: symbol)
            print(currentResult)
        }
        
        func medium() {
            var a = Int.random(in: 1...20)
            var b = Int.random(in: 1...9)
            var array = ["-", "+", "*", "/"]
            var symbol = array.randomElement()!
            task.text = "\(a) \(symbol) \(b) = "
            currentResult = calculateResolt(num1: a, num2: b, symbol: symbol)
            print(currentResult)
            
        }
        
        func hard() {
            var a = Int.random(in: 10...20)
            var b = Int.random(in: 10...20)
            var array = ["-", "+", "*", "/"]
            var symbol = array.randomElement()!
            task.text = "\(a) \(symbol) \(b) = "
            currentResult = calculateResolt(num1: a, num2: b, symbol: symbol)
            print(currentResult)
            
        }
        
        func calculateResolt(num1: Int, num2: Int, symbol: String) -> Int {
            var result = 0
            switch symbol {
            case "-": result = num1 - num2
            case "+": result = num1 + num2
            case "*": result = num1 * num2
            case "/": result = num1 / num2
            default: result = Int.min
            }
            return result
            
        }
        
        @objc func submitTapped() {
            guard let text = result.text, let number = Int(text) else { return }
            if number == currentResult {
                currentScore += 1
                score.text = "Score: \(currentScore)"
                
            }
            switch currentStatus {
            case "Easy": easy()
            case "Medium": medium()
            case "Hard": hard()
            default:medium()
            }
          
            result.text = ""
            
        }
        
        @objc func restartTapped() {
            generateEquasion()
            currentScore = 0
            score.text = "Score: \(0)"
        }
        
        @objc func suitDidChange(_segmentControl: UISegmentedControl) {
            switch segmentControl.selectedSegmentIndex {
            case 0:
                easy()
                currentStatus = "Easy"
            case 1:
                medium()
                currentStatus = "Medium"
            case 2:
                hard()
                currentStatus = "Hard"
            default: segmentControl
                
            }
        }
    }
    


