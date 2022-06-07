//
//  ArticleImage.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import Foundation
import UIKit

enum ArticleImageKeys: String, CodingKey {
    case created_at
    case alt
    case width
    case height
    case src
}

struct ArticleImage: Codable {
    
    var created_at: String = ""
    var alt: String = ""
    var width: Int = 0
    var height: Int = 0
    var src: String = ""
    var resizeHeight: Double = 0.0
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ArticleImageKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        alt = try values.decodeIfPresent(String.self, forKey: .alt) ?? ""
        width = try values.decodeIfPresent(Int.self, forKey: .width) ?? 0
        height = try values.decodeIfPresent(Int.self, forKey: .height) ?? 0
        resizeHeight = getImageHeightForFullWidth(imageHeight: Double(height), imageWidth: Double(width))
        src = try values.decodeIfPresent(String.self, forKey: .src) ?? ""
    }
    
    func getImageHeightForFullWidth(imageHeight: Double, imageWidth: Double) -> Double {
        var heightToBeReturned: Double = 0.0
        let screenWidth = UIScreen.main.bounds.width
        heightToBeReturned = (imageHeight / imageWidth) * Double(screenWidth)
        return heightToBeReturned
    }
    
}
