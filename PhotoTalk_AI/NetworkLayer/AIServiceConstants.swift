//
//  AIServiceConstants.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 29.11.2025.
//

import Foundation

enum AIServiceConstants {
    
    static let modelName = "gemini-2.5-flash"
    
    static let imageToTextPrompt = "Bu fotoğrafı anlamlı ve kısa metin şekilde bir görme engelli bireye anlat. Görme engelli bireyin fotoğrafı kafasında canlandıra bileceği şekilde anlat. Görme engelli bireyin yürürken dikkat etmesi gereken veya ona tehlike oluşturabilecek bir durum var ise bunu metinde belirt. Yürürken ona engel olabilecek bir şey görürsen onu uyar. Dönüş olarak sadece fotoğrafı anlattığın metni ver. Başka hiçbir şey yazma. Devrik cümleler kurma. Fotoğrafı güzel betimle."
}
