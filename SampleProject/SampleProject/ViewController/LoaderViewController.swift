//
//  LoaderViewController.swift
//  SampleProject
//
//  Created by benjamin.chrysostom on 30/05/22.
//

import UIKit
import AVKit
import AVFoundation

protocol LoaderDelegate {
    var isDataLoaded: Bool { get set }
}

class LoaderViewController: AVPlayerViewController, AVPlayerViewControllerDelegate, LoaderDelegate {
    
    var isDataLoaded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        entersFullScreenWhenPlaybackBegins = true // Player does not enter full screen despite this.
        view.backgroundColor = UIColor(red: 35.0 / 255.0, green: 31.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
        addLoaderAnimation()
        delegate = self
    }
    
    // Adding Loader animation
    func addLoaderAnimation() {
        guard let url = Bundle.main.url(forResource: "loader-animation", withExtension: "mp4") else { return }
        player = AVPlayer(url: url)
        player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        navigationController?.navigationBar.isHidden = true
    }
    
    // Looping Animation till data finishes loading
    @objc func playerDidFinishPlaying() {
        if !isDataLoaded {
            // Playing Loader Video Animation
            player?.seek(to: .zero)
            player?.play()
        } else {
            // Removing Observer and Loader Screen
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
            navigationController?.popViewController(animated: true)
            navigationController?.navigationBar.isHidden = false
        }
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
