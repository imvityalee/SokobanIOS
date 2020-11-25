//
//  ViewController.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var controller: Controller?
    private var canvasSokoban: CanvasSokoban?
    
    @IBOutlet weak var levelLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
        controller = Controller(viewer: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasSokoban = CanvasSokoban()
        controller?.startGame()
        setupView()
        setConstraints()
        swipeAdd()
        
        
    }
    ///Methods create swipes
    @IBAction func swipeMade(_ sender: UISwipeGestureRecognizer) {
        let model = controller!.getModel()
        
        if sender.direction == .right {
            model.move(direction: Helper.right)
        
        }
        if sender.direction == .left {
            model.move(direction: Helper.left)
            
        }
        if sender.direction ==  .down {
            model.move(direction: Helper.down)
            
        }
        if sender.direction == .up {
            model.move(direction: Helper.up)
            
        }
        
    }
    /// Method for menu Button
    @IBAction func menuButtonTapped(_ sender: Any) {
        controller?.winAlert()
        controller?.alertWin.message = "Пожалуйста выберите уровень!"
        self.present(controller!.alertWin, animated: true)
    }
    /// Method for restart Button
    @IBAction func restartLevelTapped(_ sender: Any) {
        controller?.restartGame()
    }
    
    public func update() {
        canvasSokoban!.update()
    }
    
    ///Method for Win Alert
    public func winAlert() {
        controller?.winAlert()
        self.present(controller!.alertWin, animated: true)
    }
    
    
    
    /// Method for Adding swipes to the View
    private func swipeAdd() {
        
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        let downRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        let upRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        
        leftRecognizer.direction = .left
        rightRecognizer.direction = .right
        downRecognizer.direction = .down
        upRecognizer.direction = .up
        view.addGestureRecognizer(leftRecognizer)
        view.addGestureRecognizer(rightRecognizer)
        view.addGestureRecognizer(downRecognizer)
        view.addGestureRecognizer(upRecognizer)
    }
    /// Method for setting the View
    private func setupView() {
        
        let model = controller!.getModel()
        canvasSokoban!.connectToModel(model: model)
        canvasSokoban!.backgroundColor = UIColor.black
        view.addSubview(canvasSokoban!)
        view.backgroundColor = UIColor.darkGray
        canvasSokoban!.translatesAutoresizingMaskIntoConstraints = false
        canvasSokoban?.layer.cornerRadius = 15
        canvasSokoban?.layer.masksToBounds = true
    }
    /// Method for setting UIView Constraints
    private func setConstraints() {
    
        var constraints = [NSLayoutConstraint]()
        
        constraints.append((canvasSokoban?.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25))!)
        constraints.append((canvasSokoban?.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25))!)
        constraints.append((canvasSokoban?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50))!)
        constraints.append((canvasSokoban?.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70))!)
        
        
        NSLayoutConstraint.activate(constraints)
    }
}


