//
//  ChartsViewModel.swift
//  ChartsZen
//
//  Created by SaanviSpace on 05/01/22.
//

import Foundation

class ChartsViewModel {
    var receivedJsonData:((_ players: [Player])->())?
    
    func getChartsData() {
        if let localData = self.readLocalFile(forFileName:"ChartsJsonData") {
            self.parse(jsonData: localData)
        }
    }
    
    private func readLocalFile(forFileName fileName: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName,
                                                 ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decoder = JSONDecoder()
            let responseModel = try decoder.decode(PlayersDataModel.self, from: jsonData)
            
            if responseModel.status == true, let _players = responseModel.players {
                receivedJsonData?(_players)
            }
        } catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
    }
}
