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
        // Görseli yeniden boyutlandır
        let targetSize = CGSize(width: 1024, height: 1024) // API'nin önerdiği boyut olabilir
        guard let resizedImage = image.resized(to: targetSize) else {
            completion(.failure(NSError(domain: "GeminiManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Image resizing failed."])))
            return
        }
        
        Task {
            do {
                // Yeniden boyutlandırılmış görsel ile API'yi çağır
                let response = try await model.generateContent(prompt, resizedImage)
                
                if let generatedText = response.text {
                    completion(.success(generatedText))
                } else {
                    completion(.failure(NSError(domain: "GeminiManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No text generated in the response."])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
