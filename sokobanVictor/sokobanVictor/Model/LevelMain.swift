//
//  MainLevels.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/5/20.
//

import Foundation

/// Mark: Loads Levels in the class from txt files, class objects and server


public class LevelMain   {
    
    private let viewer: ViewController
    private var setCurrentLevel: Int
    private var nextLevel: Int
    private let levelsFromFile: LevelsConverter
    private let levelsFromServer: LevelsFromServer
    
    init(viewer: ViewController) {
        self.viewer = viewer
        setCurrentLevel = 1
        nextLevel = 1
        levelsFromFile = LevelsConverter()
        levelsFromServer = LevelsFromServer(host: "194.152.37.7", port: 4446)
        
        
    }
    /// Sets the selected level
    /// - Parameter level: choosen level
    /// - Returns: 2dArray
    public func selectTheLevel(level: Int) -> [[Int]] {
        setCurrentLevel = level
        nextLevel = level
        return menuOfTheLevels(setCurrentLevel)
    }
    
    
    /// Method restarts the level
    /// - Returns: the level to its iinitial phase
    public func levelRestart() -> [[Int]] {
        return menuOfTheLevels(setCurrentLevel)
    }
    
    
    /// The methods that returns the first  Level
    /// - Returns: First Level
    private func startGameFirstlevel() -> [[Int]] {
        setCurrentLevel = 1
        nextLevel = 2
        return level1Selected()
    }
    
    ///  Method gets the current level
    /// - Returns: sets current level
    public func getCurrentLevel() -> Int {
        return setCurrentLevel
    }
    
    private func menuOfTheLevels(_ level: Int) -> [[Int]] {
        var desktop: [[Int]] = []
        switch level {
        case 0:
            desktop = defaultLevelSelected()
        case 1:
            desktop = level1Selected()
        case 2:
            desktop = level2Selected()
        case 3:
            desktop =   level3Selected()
        case 4,5,6:
            desktop = levelsFromFile.menuOfLevels(level)
        case 7,8,9:
            desktop = levelsFromFile.menuOfLevels(level)
        default:
            desktop = startGameFirstlevel()
        }
        return desktop
    }
    
    private func defaultLevelSelected() -> [[Int]]{
        var desktop: [[Int]]
        desktop =  [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 3, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 1, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 3, 0, 4, 4, 0, 2],
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
        ]
        
        return desktop
    }
    
    private func level1Selected() -> [[Int]] {
        let desktop: [[Int]]
        desktop =  [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 0, 0, 0, 0, 0, 0, 4, 0, 2],
            [2, 0, 3, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 1, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 3, 0, 2],
            [2, 0, 0, 0, 4, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
        ]
        
        return desktop
        
    }
    
    private func level2Selected() -> [[Int]] {
        let desktop: [[Int]]
        desktop =  [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 2, 0, 0, 0, 0, 0, 2, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 4, 2],
            [2, 0, 0, 0, 0, 0, 0, 2, 0, 2],
            [2, 2, 0, 0, 0, 0, 0, 2, 2, 2],
            [2, 0, 0, 0, 3, 0, 0, 2, 0, 2],
            [2, 0, 2, 0, 0, 0, 0, 2, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 3, 0, 2],
            [2, 4, 0, 0, 0, 0, 0, 2, 1, 2],
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
        ]
        
        return desktop
        
    }
    
    private func level3Selected() -> [[Int]] {
        let desktop: [[Int]]
        desktop =  [
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
            [2, 2, 2, 1, 0, 0, 0, 0, 0, 2],
            [2, 2, 2, 3, 0, 0, 0, 0, 0, 2],
            [2, 4, 2, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 0, 0, 0, 0, 0, 0, 2],
            [2, 0, 0, 2, 2, 2, 2, 2, 2, 2],
            [2, 0, 3, 0, 0, 0, 0, 0, 4, 2],
            [2, 0, 0, 2, 2, 2, 2, 2, 2, 2],
            [2, 2, 2, 2, 2, 2, 2, 2, 2, 2]
        ]
        
        return desktop        
    }
    
}




