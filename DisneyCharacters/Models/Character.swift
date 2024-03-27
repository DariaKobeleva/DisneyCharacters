//
//  Character.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import Foundation

//MARK: - Character
struct Character {
    let name: String
    let films: [String]?
    let imageUrl: String
    
    func filmsList() -> String {
        films?.joined(separator: ", ") ?? "No films"
    }
    
    init(characterDetails: [String: Any]) {
        name = characterDetails["name"] as? String ?? ""
        films = characterDetails["films"] as? [String] ?? []
        imageUrl = characterDetails["imageUrl"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let value = value as? [String : Any] else { return [] }
        guard let charactersDetails = value["data"] as? [[String: Any]] else { return [] }
        return charactersDetails.map { Character(characterDetails: $0)}
    }
}
