//
//  TableViewModel.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 30/05/22.
//

import Foundation
import UIKit

class TableViewModel {
    
    // HTML String converted to attributed String.
    func getAttributedStringFor(html: String) -> NSMutableAttributedString {
        guard let data = html.data(using: .utf8) else { return NSMutableAttributedString(string: html) }
        do {
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attributedString
        } catch {
            let attributedString = NSMutableAttributedString(string: html)
            return attributedString
        }
                
    }
}
