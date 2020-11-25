//
//  Model.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/5/20.
//

import Foundation


///Mark:  Model  manages the Sokoban game logic.
/*
 * Model sends data to viewer directly
 * Model initilzes with viewr instances
 * By default games starts with the "default level"
 
 
 */
public class Model  {
    
    private var levelsMain: LevelMain
    private let viewer: ViewController
   
    
    // Array of Sokoban Map
    private var desktop: [[Int]]
    
    //Array to count target points
    private var targetPoints: [[Int]]?
    // variables of the players and targets  indexs
    private var indexX: Int
    private var indexY: Int
    
    
    
    init(viewer: ViewController) {
        self.viewer = viewer
        targetPoints = []
        desktop = []
        levelsMain = LevelMain(viewer: viewer)
        indexX = 0
        indexY = 0
    }
    
    /// This function needs to start the game
    private func startGame() {
        var index = 0
        var countPlayer = 0
        var countTarget = 0
        var countBox = 0
        
        for rows in 0..<desktop.count {
            for columns in 0..<desktop[rows].count {
                if desktop[rows][columns] == Helper.character {
                    indexX = rows
                    indexY = columns
                    countPlayer += 1
                } else if desktop[rows][columns] == Helper.goal {
                    countTarget += 1
                } else if desktop[rows][columns] == Helper.box {
                    countBox += 1
                }
            }
        }
        if (countBox != countTarget) && (countPlayer != 1) {
            defaultMap()
            return
        }
        targetPoints = Array(repeating: [0,countTarget], count: 2)
        
        for i in 0..<desktop.count {
            for j in 0..<desktop[i].count {
                if desktop[i][j] == Helper.goal {
                    targetPoints![index] = [i, j]
                    index += 1
                }
            }
        }
        if levelsMain.getCurrentLevel() == 0 {
            viewer.levelLabel.text = "Default Level"
        } else {
            viewer.levelLabel.text = "Level: \(levelsMain.getCurrentLevel().description)"
        }
        viewer.update()
        
    }
    
    private func defaultMap(){
        desktop = []
        desktop = levelsMain.selectTheLevel(level: 0)
        startGame()
    }
    
    /// This functions liestens the move of the direction, updates the viewer and cheks for targets and if player wins
    /// - Parameter direction: direction takes a direction from Helper File,
    public func move(direction: String) {
        switch direction {
        case Helper.left:
            if checkCollision(direction: Helper.left) {
                moveLeft()
            }else if checkBoxInDirection(direction: Helper.left) {
                moveBoxToLeft()
            }
        case Helper.right:
            if checkCollision(direction: Helper.right) {
                moveRight()
                
            }else if checkBoxInDirection(direction: Helper.right) {
                moveBoxToRight()
            }
        case Helper.up:
            if checkCollision(direction: Helper.up) {
                moveUp()
            }else if checkBoxInDirection(direction: Helper.up) {
                moveBoxToUp()
            }
        case Helper.down:
            if checkCollision(direction: Helper.down) {
                moveDown()
            }else if checkBoxInDirection(direction: Helper.down) {
                moveBoxToDown()
            }
        default:
            
            return
        }
        viewer.update()
        checkForTargets()
        checkForWin()
    }
    
    ///Moving Right by coordinates
    public func moveRight() {
        desktop[indexX][indexY] = Helper.floor
        indexY = indexY + 1
        desktop[indexX][indexY] = Helper.character
        
    }
    ///Moving Left by coordinates
    public func moveLeft() {
        desktop[indexX][indexY] = Helper.floor
        indexY = indexY - 1
        desktop[indexX][indexY] = Helper.character
        
    }
    ///Moving Up by coordinates
    public func moveUp() {
        desktop[indexX][indexY] = Helper.floor
        indexX = indexX - 1
        desktop[indexX][indexY] = Helper.character
        
    }
    ///Moving Down by coordinates
    public func moveDown() {
        desktop[indexX][indexY] = Helper.floor
        indexX = indexX + 1
        desktop[indexX][indexY] = Helper.character
        
    }
    ///Moving box and character Left by coordinates
    private func moveBoxToLeft() {
        desktop[indexX][indexY] = Helper.floor
        indexY = indexY - 1
        desktop[indexX][indexY] = Helper.character
        desktop[indexX][indexY - 1] = Helper.box
    }
    
    ///Moving box and character  Right by coordinates
    private func moveBoxToRight() {
        desktop[indexX][indexY] = Helper.floor
        indexY = indexY + 1
        desktop[indexX][indexY] = Helper.character
        desktop[indexX][indexY + 1] = Helper.box
    }
    ///Moving box and character  Up by coordinates
    private func moveBoxToUp() {
        desktop[indexX][indexY] = Helper.floor
        indexX = indexX - 1
        desktop[indexX][indexY] = Helper.character
        desktop[indexX - 1][indexY] = Helper.box
    }
    ///Moving box and character Down by coordinates
    private func moveBoxToDown() {
        desktop[indexX][indexY] = Helper.floor
        indexX = indexX + 1
        desktop[indexX][indexY] = Helper.character
        desktop[indexX + 1][indexY] = Helper.box
    }
    
    /// Checks if there is a box in given direction
    /// - Parameter direction: all directions of swipes
    private func checkBoxInDirection(direction: String) -> Bool {
        switch direction {
        
        case Helper.right:
            if desktop[indexX][indexY + 1] == Helper.box {
                if (desktop[indexX][indexY + 2] == Helper.floor) || (desktop[indexX][indexY + 2] == Helper.goal) {
                    return true
                }
            }
        case Helper.down:
            if desktop[indexX + 1][indexY] == Helper.box {
                if desktop[indexX + 2][indexY] == Helper.floor || desktop[indexX + 2][indexY] == Helper.goal {
                    return true
                }
            }
        case Helper.left:
            if desktop[indexX][indexY - 1] == Helper.box {
                if (desktop[indexX][indexY - 2] == Helper.floor) || (desktop[indexX][indexY - 2] == Helper.goal) {
                    return true
                }
            }
            
        case Helper.up:
            if desktop[indexX - 1][indexY] == Helper.box {
                if (desktop[indexX - 2][indexY] == Helper.floor) || (desktop[indexX - 2][indexY] == Helper.goal) {
                    return true
                }
            }
        default:
            print("FatalError")
        }
        return false
    }
    
    /// Method for actions that are made in the menu
    /// - Parameter action: for all the levels
    public func actionMade(action : String) {
        
        switch action {
        case "level1":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 1)
        case "level2":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 2)
        case "level3":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 3)
        case "level4":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 4)
        case "level5":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 5)
        case "level6":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 6)
        case "level7":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 7)
        case "level8":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 8)
        case "level9":
            desktop = []
            desktop = levelsMain.selectTheLevel(level: 9)
        default:
            return
        }
        startGame()
    }
    
    
    /// Method checks the player movements
    /// - Parameter direction: chekcs if there is a free cell
    /// - Returns: returns true if there is a free cell otherwise return false
    private func checkCollision(direction: String) -> Bool {
        switch direction {
       
        case Helper.up:
            if desktop[indexX - 1][indexY] == Helper.floor || desktop[indexX - 1][indexY] == Helper.goal {
                return true
            }
        case Helper.down:
            if desktop[indexX + 1][indexY] == Helper.floor || desktop[indexX  + 1][indexY] == Helper.goal {
                return true
            }
        case Helper.right:
            if desktop[indexX][indexY + 1] == Helper.floor || desktop[indexX][indexY + 1] == Helper.goal {
                return true
            }
        case Helper.left:
            if desktop[indexX][indexY - 1] == Helper.floor || desktop[indexX][indexY - 1] == Helper.goal {
                return true
            }
        default:
            print("Fatal error")
        }
        return false
    }
    
    /// Chek if Player Wins
    private func checkForWin() {
        for index in targetPoints! {
            if (desktop[index[0]][index[1]] != Helper.box) {
                return
            }
        }
        viewer.winAlert()
    }
    /// Check for targets
    private func checkForTargets() {
        for index in targetPoints! {
            if (desktop[index[0]][index[1]] == Helper.floor) {
                desktop[index[0]][index[1]] = Helper.goal
            }
        }
    }
    
    
    /// Method that returns map and passes to Canvas
    public func getDesktop() -> [[Int]] {
        return desktop
    }
   
    
    ///  Method that will restart the level
    public func getRestartLevel() {
        desktop = []
        desktop = levelsMain.levelRestart()
        startGame()
    }
    
    public func setInitialLevel() {
        desktop = levelsMain.selectTheLevel(level: 0)
        startGame()
    }
    
    
}
