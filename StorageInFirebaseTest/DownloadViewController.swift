//
//  DownloadViewController.swift
//  StorageInFirebaseTest
//
//  Created by ALEXANDRE GROSSON on 08/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import Firebase


class DownloadViewController: UIViewController {

    var download:StorageDownloadTask!
    
    @IBOutlet weak var imageViewDownload: UIImageView!
    
    @IBAction func getImageButtonPressed(_ sender: Any) {
        print("let's download")
        let storageRef = Storage.storage().reference().child("cover").child("MyTestImage.jpg")
        print(storageRef.description)
        DispatchQueue.main.async {
            print("let's be inside")
            self.download = storageRef.getData(maxSize: 1024*1024*5, completion:  { [weak self] (data, error) in
                print("let's be inside download")
                guard let data = data else {
                    print("no data here")
                    return
                }
                if error != nil {
                    print("error here : \(error.debugDescription)")
                }
                print("download succeeded !")
                self!.imageViewDownload.image = UIImage(data: data)
                self!.download.resume()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
