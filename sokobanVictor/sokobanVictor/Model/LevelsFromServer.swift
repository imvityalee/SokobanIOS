//
//  LevelsFromServer.swift
//  sokobanVictor
//
//  Created by Victor Lee on 11/10/20.
//


import Foundation

/// Class that providing access to remote levels
class LevelsFromServer {
    
    private var map = ""
    static let shared = LevelsFromServer(host: "194.152.37.7", port: 4446)
    private(set) var listOfLevels: [[String]] = []
    private(set) var connectedToServer = false
    private var serverWorker: ConnectToServer
    
    init(host: String, port: UInt32) {
        serverWorker = ConnectToServer(host: host, port: port, messageEncoding: .ascii)
        configureCallbacks()
    }
    
    //Callbacks functionallity
    private func configureCallbacks() {
        serverWorker.didRecieveMessage  = { [weak self] message in
            self?.map = message
        }
        serverWorker.connectionCompleted = { [weak self] in
            self?.connectedToServer = true
        }
    }
    
    public func getMap() -> String {
        return map
    }
    
    public func getLevel(levelName name: String)  {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.serverWorker.sendMessage(message: ServerRequests.getLevel(levelName: name).requestString)
        }
    }
}

enum ServerRequests {
    
    case getLevel(levelName: String)
    var requestString: String {
    
        switch self {
        case .getLevel(let levelName):
            return "GET_LEVEL: " + levelName
        }
    }
}

enum ServerResponse {
    
    case gotLevel
    case endOfFile
    
    var responseString: String {
        
        switch self {
        case .gotLevel:
            return "GOT_LEVEL: "
        case .endOfFile :
            return "END_OF_MESSAGE"
            
        }
    }
}
