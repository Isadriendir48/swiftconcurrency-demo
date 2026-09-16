//
//  PokemonSprites.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

struct PokemonSprites: Decodable {
    let other: OtherSprites
}

struct OtherSprites: Decodable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Decodable {
    let frontDefault: URL?
    let frontShiny: URL?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
