//
//  ViewController.swift
//  ISpy
//
//  Created by Дмитрий Имаев on 26.02.2023.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dragonImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        updateZoomFor(size: view.bounds.size)
    }
    
     func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return dragonImage
    }
        
    func updateZoomFor(size: CGSize){
        let widthScale = size.width / dragonImage.bounds.width
        let heightScale = size.height / dragonImage.bounds.height
        let scale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
    }
}


