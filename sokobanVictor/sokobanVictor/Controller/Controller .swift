//
//  Controller .swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/5/20.
//

import Foundation
import UIKit

public class Controller {
    
    private let model: Model
    public var alertWin = UIAlertController()
    
    init(viewer: ViewController) {
        model = Model(viewer: viewer)
    }
    
    public func getModel() -> Model {
        return model
    }
    
    public func startGame() {
        model.setInitialLevel()
    }
    
    public func restartGame() {
        model.getRestartLevel()
    }
    /// Method that process Win Alert Menu
    public func winAlert() {
        
        alertWin = UIAlertController(title: nil, message: "Вы победили! \nПожалуйста выберите уровень!", preferredStyle: .actionSheet)
        alertWin.addAction(UIAlertAction(title: "Назад", style: .cancel, handler: { (action) in
            print("tapped dismiss")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-1", style: .default, handler: { (action) in
            self.model.actionMade(action: "level1")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-2", style: .default, handler: { (action) in
            self.model.actionMade(action: "level2")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-3", style: .default, handler: { (action) in
            self.model.actionMade(action: "level3")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-4", style: .default, handler: { (action) in
            self.model.actionMade(action: "level4")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-5", style: .default, handler: { (action) in
            self.model.actionMade(action: "level5")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-6", style: .default, handler: { (action) in
            self.model.actionMade(action: "level6")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-7", style: .default, handler: { (action) in
            self.model.actionMade(action: "level7")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-8", style: .default, handler: { (action) in
            self.model.actionMade(action: "level8")
        }))
        alertWin.addAction(UIAlertAction(title: "Level-9", style: .default, handler: { (action) in
            self.model.actionMade(action: "level9")
        }))
        
    }
    
}
