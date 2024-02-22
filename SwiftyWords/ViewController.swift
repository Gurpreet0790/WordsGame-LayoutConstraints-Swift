//
//  ViewController.swift
//  SwiftyWords
//
//  Created by ReetDhillon on 2024-02-21.
//

import UIKit

class ViewController: UIViewController {
    
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var answerLabel: UILabel!
    var clueLabel: UILabel!
    var letterButtons = [UIButton]()
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0
    var level = 1
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        
        //MARK: - Create Views
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.font =  UIFont(name: "PlayfairDisplay-Bold", size:40)
        scoreLabel.text = "Score : 0"
        
        view.addSubview(scoreLabel)
        
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.textAlignment = .right
        answerLabel.font =  UIFont(name: "PlayfairDisplay-Regular", size: 25)
        answerLabel.text = "Answers"
        answerLabel.numberOfLines = 0
        view.addSubview(answerLabel)
        
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        clueLabel.textAlignment = .left
        clueLabel.font =  UIFont(name: "PlayfairDisplay-Regular", size: 25)
        clueLabel.text = "Clues"
        clueLabel.numberOfLines = 0
        view.addSubview(clueLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont(name: "PlayfairDisplay-Bold", size: 35)
        currentAnswer.backgroundColor =  UIColor(red: 246/255, green: 233/255, blue: 242/255, alpha: 1.0)
        
        currentAnswer.layer.cornerRadius = 10
        currentAnswer.placeholder = "Tap button to guess answer"
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let clearButton = UIButton(type: .custom)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearBtnTapped), for: .touchUpInside)
        addButtonFeatures(clearButton)
        view.addSubview(clearButton)
        
        let submitButton = UIButton(type: .custom)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        
        addButtonFeatures(submitButton)
        submitButton.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        
        view.addSubview(submitButton)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.cornerRadius = 20
        buttonsView.layer.backgroundColor =  UIColor(red: 246/255, green: 235/255, blue: 243/255, alpha: 1.0).cgColor
        view.addSubview(buttonsView)
        
        
        
        let buttonWidth = 150
        let buttonHeight = 50
        
        for row in 0..<4 {
            for coloumn in 0..<5 {
                let letterButton = UIButton(type: .custom)
                letterButton.setTitleColor(.black, for: .normal)
                letterButton.titleLabel?.font =  UIFont(name: "PlayfairDisplay-Bold", size: 30)
                letterButton.setTitle("Reet", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpOutside)
                
                
                let frame = CGRect(x: coloumn * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        
        
        //MARK: - Apply Constraints
        
        NSLayoutConstraint.activate([scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
                                     scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                                     
                                     clueLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                                     clueLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
                                     clueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
                                     
                                     answerLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
                                     answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
                                     answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
                                     answerLabel.heightAnchor.constraint(equalTo: clueLabel.heightAnchor),
                                     
                                     currentAnswer.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 30),
                                     currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
                                     
                                     clearButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 30),
                                     clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
                                     clearButton.heightAnchor.constraint(equalToConstant: 80),
                                     clearButton.widthAnchor.constraint(equalToConstant: 150),
                                     
                                     submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 30),
                                     submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
                                     submitButton.heightAnchor.constraint(equalTo: clearButton.heightAnchor),
                                     submitButton.widthAnchor.constraint(equalToConstant: 150),
                                     
                                     buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 40),
                                     buttonsView.heightAnchor.constraint(equalToConstant: 280),
                                     buttonsView.widthAnchor.constraint(equalToConstant: 730),
                                     buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50)
                                     
                                     
                                     
                                    ])
        
        loadlevel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Create Views
    func addButtonFeatures(_ button: UIButton){
        button.titleLabel?.font =  UIFont(name: "PlayfairDisplay-Bold", size: 25)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 210/255, green: 167/255, blue: 213/255, alpha: 1.0)
    }
    
    //MARK: - Button Actions
    @objc func clearBtnTapped(_ sender: UIButton){
        
    }
    @objc func submitBtnTapped(_ sender: UIButton){
        
    }
    @objc func letterTapped(_ sender: UIButton){
        
    }
    
    
    //MARK: - Load Game Level
    func loadlevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        if let fileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            if let levelContents = try? String(contentsOf: fileURL) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        clueLabel.text =  clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answerLabel.text =  solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count{
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
}
