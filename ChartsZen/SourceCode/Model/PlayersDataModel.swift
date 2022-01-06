//
//  PlayersDataModel.swift
//  SampleProject
//
//  Created by ELORCE INDUSTRIES PRIVATE LIMITED on 20/12/21.
//

import Foundation

struct PlayersDataModel: Codable {
    let status: Bool?
    let players: [Player]?
    let message: String?
}

struct Player: Codable {
    let name: String?
    let nationality: String?
    let status: String?
    let history: [History]?
    
    init(_name: String, _nationality: String? = nil, _status: String? = nil, _history: [History]? = nil) {
        name = _name
        nationality = _nationality
        status = _status
        history = _history
    }
}

struct History: Codable {
    let modified: String?
    let score: Int?
}
