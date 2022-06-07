//
//  NavigationController.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 28/05/22.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loaderController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: LoaderViewControllerIdentifier)
        pushViewController(loaderController, animated: true)
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
