//
//  DetailWebViewController.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 29/05/22.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var webViewModel = WebViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webViewModel.addHeaderToHtml()
        webViewModel.replaceImageUrls()
        webView.loadHTMLString(webViewModel.htmlString, baseURL: nil)
        
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(webViewModel.getHtmlWithStyle())
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
