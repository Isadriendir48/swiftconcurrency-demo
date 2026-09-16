//
//  PokemonListItem+DTOMapping.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

extension PokemonListItem {
    init?(dto: PokemonListItemDTO) {
        guard let id = Int(dto.url.lastPathComponent) else {
            return nil
        }
        
        let sprite = URL(
            string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        )
        
        self.init(
            id: id,
            name: dto.name,
            detailURL: dto.url,
            spriteURL: sprite
        )
    }
}
