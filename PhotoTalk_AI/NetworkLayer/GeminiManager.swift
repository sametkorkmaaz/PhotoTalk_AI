//
//  GeminiManager.swift
//  PhotoTalk_AI
//

import Foundation
import UIKit
import GoogleGenerativeAI

class GeminiManager {
    
    static let shared = GeminiManager()
    private init() {}
    
    private let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyAQzUIQPnfrB6YyZMetZkdDLrRasqRLwos")
    
    /// Gemini API'ye görsel ve prompt gönderir ve yanıt alır.
    /// - Parameters:
    ///   - image: Kullanıcının seçtiği görsel (galeri veya kamera).
    ///   - prompt: Kullanıcı tarafından belirtilen metin girdisi.
    ///   - completion: Başarı veya hata durumunda geri döndürülecek closure.
    func fetchGemini(image: UIImage, prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                // Görsel ve prompt ile API'yi çağır
                let response = try await model.generateContent(prompt, image)
                
                // Yanıtı kontrol et
                if let generatedText = response.text {
                    completion(.success(generatedText))
                } else {
                    completion(.failure(NSError(domain: "GeminiManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No text generated in the response."])))
                }
            } catch {
                // Hata durumunda geri döndür
                completion(.failure(error))
            }
        }
    }
}
