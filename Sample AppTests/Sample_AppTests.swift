//
//  Sample_AppTests.swift
//  Sample AppTests
//
//  Created by Andres Olguin on 24/08/2026.
//

@testable import Sample_App
import Testing
import Foundation

struct Sample_AppTests {
    @Test("Maps DTOs to domain models with nextOffset parsed")
    func getsPokemonsAndParsesOffset() async throws {
        let payload = """
        {
            "count": 3,
            "next": "https://fake.link?limit=3&offset=3",
            "previous": null,
            "results": [
                {
                    "name": "item-1",
                    "url": "https://fake.link/item/1/"
                },
                {
                    "name": "item-2",
                    "url": "https://fake.link/item/2/"
                },
                {
                    "name": "item-3",
                    "url": "https://fake.link/item/3/"
                }
            ]
        }
        """.data(using: .utf8)
        
        let client = FakeHTTPClient(payload: payload, error: nil)
        
        let repository = PokeAPIPokemonRepository(
            client: client
        )
        
        let result = try await repository.getPokemons(
            limit: 3,
            offset: 0
        )
        
        guard let lastItem = result.items.last else {
            fatalError("Should return a list of items")
        }
        
        #expect(result.nextOffset == 3)
        #expect(result.items.count == 3)
        #expect(lastItem.id == 3)
        #expect(lastItem.name == "item-3")
    }
    
    @Test("Shows no offset when reaching the end of the list")
    func lastPageHasNoNext() async throws {
        let payload = """
        {
            "count": 3,
            "next": null,
            "previous": "https://fake.link?limit=3&offset=3",
            "results": [
                {
                    "name": "item-1",
                    "url": "https://fake.link/item/1/"
                },
                {
                    "name": "item-2",
                    "url": "https://fake.link/item/2/"
                },
                {
                    "name": "item-3",
                    "url": "https://fake.link/item/3/"
                }
            ]
        }
        """.data(using: .utf8)
        
        let client = FakeHTTPClient(payload: payload, error: nil)
        
        let repository = PokeAPIPokemonRepository(
            client: client
        )
        
        let result = try await repository.getPokemons(
            limit: 3,
            offset: 6
        )
        
        #expect(result.nextOffset == nil)
    }
}
