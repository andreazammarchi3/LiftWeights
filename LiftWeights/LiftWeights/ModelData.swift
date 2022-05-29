//
//  ModelData.swift
//  LiftWeights
//
//  Created by Andrea on 29/05/22.
//

import Foundation

struct ModelData<DataType> where DataType: Decodable {
    var list: [DataType]
    
    init(fileName: String) {
        list = [DataType]()
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: ".json")
        else {fatalError("File \(fileName) not found")}
        let data: Data
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("\(fileName) not loaded:\n\(error)")
        }
        
        let decoder = JSONDecoder()
        do {
            list = try decoder.decode([DataType].self, from: data)
        } catch {
            fatalError("Error parsing \(fileName) as \([DataType].self):\n\(error)")
        }
    }
}
