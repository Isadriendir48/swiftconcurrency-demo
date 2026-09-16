//
//  PokemonRepository.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

protocol PokemonRepository {
    func getPokemons(limit: Int, offset: Int) async throws -> PokemonListPage
}
