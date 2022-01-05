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
}

struct History: Codable {
    let modified: String?
    let score: Int?
}
