//
//  ViewController.swift
//  StorageInFirebaseTest
//
//  Created by ALEXANDRE GROSSON on 08/06/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    @IBAction func getPictureButtonPressed(_ sender: Any) {
        let urlString = "https://images.gr-assets.com/books/1558299964m/45887634.jpg"
        var imageToGet : UIImage?
        let url = URL(string: urlString )
        guard let data = try? Data(contentsOf: url!) else {return}
        imageToGet = UIImage(data: data)
        image.image = imageToGet
    }
    
    @IBAction func storeInFirebaseStrorageButtonPressed(_ sender: Any) {
        // store in DataBase
        let urlString = "https://images.gr-assets.com/books/1558299964m/45887634.jpg"
        let ref = Database.database().reference()
        ref.child("UlrImage").setValue(urlString)
        // store in Storage
        guard let url = URL(string: urlString) else {return}
        // get data from url
        guard let data = try? Data(contentsOf: url) else {return}
        // create a UIImage from the data
        guard let dataasImage = UIImage(data: data) else {return}
        // create an data in jpg format from a UIImage
        guard let imageData = dataasImage.jpegData(compressionQuality: 1) else {return}
        // Create a Storage reference with the bookId
        let storageRef = Storage.storage().reference().child("cover").child("MyTestImage.jpg")
        // Create a Storage Metadata
        let uploadMetadata = StorageMetadata()
        // Describe the type of image stored in FireStorage
        uploadMetadata.contentType = "image/jpeg"
        // Create the uopload task
        let uploadTask = storageRef.putData(imageData, metadata: uploadMetadata) { (metada, error) in
            if error != nil {
                print("i received an error \(error?.localizedDescription ?? "error but no description")")
            }   else {
                print("up load complete, here some metadata \(String(describing: metada))")
            }
        }
        uploadTask.observe(.progress) { (snapshot) in
            guard let progress = snapshot.progress else {
                print("No progress for the snapshot")
                return}
            print("end of progress?? ")
            print(progress.fractionCompleted)
        }
        uploadTask.resume()
        infoLabel.text = "url in storage:\n\(storageRef.description)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}

