//
//  PreflightVideoPlayerViewController.swift
//  T38
//
//  Created by elmo on 6/8/18.
//  Copyright © 2018 elmo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PreflightVideoPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let filepath: String? = Bundle.main.path(forResource: "Preflight", ofType: "mp4")
        let fileURL = URL.init(fileURLWithPath: filepath!)
        avPlayer = AVPlayer(url: fileURL)
        let avPlayerController = AVPlayerViewController()
        avPlayerController.player = avPlayer
        avPlayerController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        //  hide show control
        avPlayerController.showsPlaybackControls = false
        // play video
        avPlayerController.player?.play()
        self.view.addSubview(avPlayerController.view)
        print("Complete")

    }
    
    var avPlayer: AVPlayer!


}
