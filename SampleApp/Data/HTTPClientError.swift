//
//  HTTPClientError.swift
//  Sample App
//
//  Created by Andres Olguin on 23/08/2026.
//

import Foundation

enum HTTPClientError: Error {
    case invalidResponse
    case unsuccessfulResponse(statusCode: Int, data: Data)
    case transportError(error: Error)
    case decodingError(error: Error)
}
