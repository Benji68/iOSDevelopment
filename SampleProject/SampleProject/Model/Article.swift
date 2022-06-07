//
//  Article.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 27/05/22.
//

import Foundation

enum ArticleKeys: String, CodingKey {
    case id
    case title
    case created_at
    case body_html
    case blog_id
    case author
    case user_id
    case published_at
    case updated_at
    case summary_html
    case template_suffix
    case handle
    case tags
    case admin_graphql_api_id
    case image
}

class Article: Codable {
    var id: Int = 0
    var title: String = ""
    var created_at: String = ""
    var body_html: String = ""
    var blog_id: Int = 0
    var author: String = ""
    var user_id: Int = 0
    var published_at: String = ""
    var updated_at: String = ""
    var summary_html: String = ""
    var template_suffix: String = ""
    var handle: String = ""
    var tags: String = ""
    var admin_graphql_api_id: String = ""
    var image: ArticleImage?
    
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ArticleKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at) ?? ""
        body_html = try values.decodeIfPresent(String.self, forKey: .body_html) ?? ""
        blog_id = try values.decodeIfPresent(Int.self, forKey: .blog_id) ?? 0
        author = try values.decodeIfPresent(String.self, forKey: .author) ?? ""
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id) ?? 0
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at) ?? ""
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at) ?? ""
        summary_html = try values.decodeIfPresent(String.self, forKey: .summary_html) ?? ""
        template_suffix = try values.decodeIfPresent(String.self, forKey: .template_suffix) ?? ""
        handle = try values.decodeIfPresent(String.self, forKey: .handle) ?? ""
        tags = try values.decodeIfPresent(String.self, forKey: .tags) ?? ""
        admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id) ?? ""
        image = try values.decodeIfPresent(ArticleImage.self, forKey: .image) ?? ArticleImage(from: decoder)
        
    }
    
}
