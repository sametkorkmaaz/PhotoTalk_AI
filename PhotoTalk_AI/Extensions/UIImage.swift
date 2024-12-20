//
//  UIImage.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 20.12.2024.
//

import UIKit

extension UIImage {
    /// Görseli yeniden boyutlandırır ve en-boy oranını korur.
    func resized(to targetSize: CGSize) -> UIImage? {
        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: rect)
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
