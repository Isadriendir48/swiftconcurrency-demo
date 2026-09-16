//
//  SampleAppTests.swift
//  Sample AppTests
//
//  Created by Andres Olguin on 24/08/2026.
//

@testable import Sample_App
import Testing
import Foundation

struct SampleAppTests {
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
        
        let client = FakeHTTPClient(payload: payload)
        
        let repository = PokeAPIPokemonRepository(
            client: client
        )
        
        // The offset passed to this call has no effect on the outcome
        // The result is parsed from the custom `payload` object
        let result = try await repository.getPokemons(
            limit: 3,
            offset: 0
        )
        
        guard let lastItem = result.items.last else {
            fatalError("Should return a list of items")
        }
        
        #expect(result.nextOffset == 3)
        #expect(result.items.count == 3)
        #expect(result.hasMore == true)
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
        
        let client = FakeHTTPClient(payload: payload)
        
        let repository = PokeAPIPokemonRepository(
            client: client
        )
        
        // The offset passed to this call has no effect on the outcome
        // The result is parsed from the custom `payload` object
        let result = try await repository.getPokemons(
            limit: 3,
            offset: 3
        )
        
        #expect(result.nextOffset == nil)
        #expect(result.hasMore == false)
    }
    
    @Test("Throws when 'next' URL has malformed offset")
    func malformedNextOffsetThrows() async {
        let payload = """
        {
            "count": 1,
            "next": "https://fake.link?limit=1",
            "previous": null,
            "results": [
                { "name": "item-1", "url": "https://fake.link/item/1/" }
            ]
        }
        """.data(using: .utf8)
        
        let client = FakeHTTPClient(payload: payload)
        let repository = PokeAPIPokemonRepository(client: client)
        
        do {
            _ = try await repository.getPokemons(limit: 1, offset: 0)
            Issue.record("Expected 'unexpectedResponseShape' to be thrown")
        } catch PokemonRepositoryError.unexpectedResponseShape {
            // Expected outcome
        } catch {
            Issue.record(
                error,
                "Wrong error type, expected 'unexpectedResponseShape'"
            )
        }
    }
}
