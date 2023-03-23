//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Дмитрий Имаев on 23.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
        imageView.image = UIImage(systemName: "photo.on.rectangle")
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        Task {
            do {
                let photoInfo = try await photoInfoController.fetchPhotoInfo()
                updateUI(with: photoInfo)
            } catch {
                updateUI(with: error)
            }
        }
        
        func updateUI( with photoInfo: PhotoInfo){
            Task {
                do {
                    let image = try await photoInfoController.fetchImage(from: photoInfo.url)
                    title = photoInfo.title
                    imageView.image = image
                    descriptionLabel.text = photoInfo.description
                    copyrightLabel.text = photoInfo.copyright
                } catch {
                    updateUI(with: error)
                }
            }
        }
        
        func updateUI(with error: Error) {
            title = "Error Fetching Foto"
            imageView.image = UIImage(systemName: "exlamationmark.octagon")
            descriptionLabel.text = error.localizedDescription
            copyrightLabel.text = ""
        }
    }

}

