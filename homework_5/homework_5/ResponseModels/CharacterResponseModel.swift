//
//  CharacterResponseModel.swift
//  hw4_new
//
//  Created by Liubov on 13.07.2023.
//

import Foundation

struct ResultsResponseModel: Codable{
    let characters: [CharacterResponseModel]

    enum CodingKeys: String, CodingKey{
        case characters = "results"
    }
}

struct LocationResponseModel: Codable {
    let location: String
    
    enum CodingKeys: String, CodingKey {
        case location = "name"
    }
}

struct CharacterResponseModel: Codable {
    
    let id: Int
    var name: String
    let species: String
    let image: String
    let status: String
    let gender: String
    var location: LocationResponseModel
}
