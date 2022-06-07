//
//  WebViewModel.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 30/05/22.
//

import Foundation

class WebViewModel {
    
    var htmlString = ""
    var cssString = ""
    var jsString = ""
    
    //MARK: Helper Methods to handle web content
    // Adding CSS from local file to HTML string.
    func getHtmlWithStyle() -> String {
        let path = Bundle.main.path(forResource: "styles", ofType: "css")
        do {
            cssString = try String(contentsOfFile: path ?? "")
            // CSS Not being applied if newline is present in css String.
            cssString = cssString.replacingOccurrences(of: "\n", with: "")
        } catch {
            print("Error reading Css String!")
        }
        // Adding CSS String to head of Html String
        jsString = "var style = document.createElement('style'); style.innerHTML = '\(cssString)'; document.head.appendChild(style);"
        return jsString
    }
    
    // Adding Header to handle the font issue.
    func addHeaderToHtml() {
        // WKWebView shrinks down font, does not occur in UIWebView.
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        htmlString = headerString + htmlString
    }
    
    // Replacing Image Urls to display images.
    func replaceImageUrls() {
        // Body_HTML contains incorrect URLs for images to be displayed in WebView.
        htmlString = htmlString.replacingOccurrences(of: "src=\"//", with: "src=\"https://")
    }
    
    
}
