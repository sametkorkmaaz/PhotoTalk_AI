//
//  GeminiManager.swift
//  PhotoTalk_AI
//

import Foundation
import UIKit
import FirebaseAI

class FirebaseAIService {
    
    private let model: GenerativeModel
    
    init() {
        let ai = FirebaseAI.firebaseAI(backend: .googleAI())
        self.model = ai.generativeModel(modelName: AIServiceConstants.modelName)
    }
    
    func imageToText(for image: UIImage) async throws -> String {
        let promt = AIServiceConstants.imageToTextPrompt
        
        let response: GenerateContentResponse
        
        do {
            response = try await model.generateContent(image, promt)
        } catch {
            throw AIServiceError.underlyingError(error)
        }
        
        guard let text = response.text else {
            throw AIServiceError.noTextResponse
        }
        
        return text
    }
}
