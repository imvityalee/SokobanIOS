//
//  LevelsConverter.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/9/20.
//

import Foundation
// This class takes the leves of 2D Array of Strings and Converts them into 2D Array of Int

public class LevelsConverter: NSObject  {
    
    private let remotFiles: LevelsFromServer
    private var level7 = [[Int]]()
    private var level8 = [[Int]]()
    private var level9 = [[Int]]()

    override init() {
            remotFiles = LevelsFromServer.shared
            super.init()
            getFromServers()
           
        }

    /// Menu of leves of files from text document

    public func menuOfLevels(_ level: Int) -> [[Int]]{
        var desktop: [[Int]] = []
        switch level {
        case 4:
            desktop = selectLevel4()
        case 5:
            desktop = selectLevel5()
        case 6:
            desktop = selectLevel6()
        case 7:
            desktop = level7
        case 8:
            desktop = level8
        case 9:
            desktop = level9
            
        default:
            return desktop
        }
        return desktop
    }
    
    private func selectLevel4() -> [[Int]]  {
        
        var desktop: [[Int]]
        desktop = try! readFromFile(fileName: "level4", type: "txt")
        return desktop
    }
    
    private func selectLevel5() -> [[Int]]  {
        
        var desktop: [[Int]]
        desktop = try! readFromFile(fileName: "level5", type: "txt")
        return desktop
    }
    
    private func selectLevel6() -> [[Int]]  {
        
        var desktop: [[Int]]
        desktop = try! readFromFile(fileName: "level6", type: "txt")
        return desktop
    }
    
    
    /// Method reads From file
    /// - Parameters:
    ///   - fileName: the name of file that we want to read and convert
    ///   - type: type of file that we want to read and convert
    /// - Returns: 2D Array of Int
    /// - Throws: Throws an Error if bundle path  is nil
    func readFromFile(fileName: String, type: String) throws -> [[Int]]  {
       
        let bundlePath = Bundle.main.path(forResource: fileName, ofType: type)
        let desktop: [[Int]]
        let mapInString: String!
        
        
        guard bundlePath != nil else { throw LevelsError.bundlePathIsNil}
        do {
            mapInString = try String(contentsOfFile: bundlePath!)
            
        } catch {
            print(error.localizedDescription)
            
            throw LevelsError.unableOpenTheMap
        }
        desktop = getStringFromFile(path: mapInString)
        return desktop
    }
    
    /// Methods get th string from file that takes only Int  values from string and returns 2d Array
    func getStringFromFile(path: String) -> [[Int]] {
        
        var desktop: [[Int]] = [[]]
        var row = 0
        var mapRead = false
        
        for map in path {
            if map.isNumber {
                mapRead = true
                desktop[row].append(map.wholeNumberValue!)
            }
            if mapRead && map.isNewline {
                
                desktop.append([])
                row += 1
            }
        }
        desktop.removeAll { row -> Bool in
            
            return row.count == 0
        }
        return desktop
    }
    
    /// Runs levels in server with timeLimit
    /// - Parameters:
    ///   - seconds: 1
    /// - Returns: Closure
    private func run(after seconds: Int, completion: @escaping () -> ()) {
        let timeLimit = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: timeLimit) {
            completion()
        }
    }
    
    /// getsLevelsFromServer and converts them into 2dArray
    private func getFromServers() {
        remotFiles.getLevel(levelName: "7")
        run(after: 1) {
            self.level7 = self.getStringFromFile(path: self.remotFiles.getMap())
            self.remotFiles.getLevel(levelName: "8")

            self.run(after: 1) {
                self.level8 = self.getStringFromFile(path: self.remotFiles.getMap())
                self.remotFiles.getLevel(levelName: "9")

                self.run(after: 1) {
                    self.level9 = self.getStringFromFile(path: self.remotFiles.getMap())

                }
            }
        }
    }
    
}
enum LevelsError: Error {
    case bundlePathIsNil, unableOpenTheMap
}




