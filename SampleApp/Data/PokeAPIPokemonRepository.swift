//
//  PokeAPIPokemonRepository.swift
//  Sample App
//
//  Created by Andres Olguin on 24/08/2026.
//

import Foundation

struct PokeAPIPokemonRepository: PokemonRepository {
    private let apiClient: HTTPClient
    
    init(client: HTTPClient) {
        self.apiClient = client
    }
    
    func getPokemons(limit: Int, offset: Int) async throws -> PokemonListPage {
        let items = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        
        let response: PokemonListDTO = try await apiClient.get(
            path: "pokemon",
            queryItems: items
        )
        
        let nextOffset = try getOffset(from: response.next)
        let results = response.results.compactMap(PokemonListItem.init(dto:))
        
        return PokemonListPage(
            items: results,
            nextOffset: nextOffset
        )
    }
    
    private func getOffset(from url: URL?) throws -> Int? {
        guard let url else { return nil }
        
        guard let offset = url
            .queryItemValue(for: "offset")
            .flatMap(Int.init)
        else {
            throw PokemonRepositoryError
                .unexpectedResponseShape(
                    context: "Failed to parse offset from \(url.absoluteString)"
                )
        }
        
         return offset
    }
}
