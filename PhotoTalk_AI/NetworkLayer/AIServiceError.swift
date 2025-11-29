//
//  AIServiceError.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 29.11.2025.
//

import Foundation

enum AIServiceError: Error {
    case noTextResponse
    case decodingError(Error)
    case underlyingError(Error)
    
    var localizedDescription: String {
        switch self {
        case .noTextResponse:
            return "A text response from the AI ​​model was not received."
        case .decodingError(let error):
            return "Model response could not be understood (JSON parse error): \(error.localizedDescription)"
        case .underlyingError(let error):
            return "Model error: \(error.localizedDescription)"
        }
    }
}
