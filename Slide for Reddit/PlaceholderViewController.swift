//
//  PlaceholderViewController.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 11/12/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//

import Anchorage
import Then
import UIKit

class PlaceholderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ColorUtil.backgroundColor

        let image = UIImage(named: "roundicon")!.convertToGrayScale()

        let imageView = UIImageView().then {
            $0.image = image
            $0.contentMode = .scaleAspectFit
        }

        let label = UILabel().then {
            $0.text = "SELECT A POST"
            $0.textColor = ColorUtil.fontColor
            $0.font = UIFont.boldSystemFont(ofSize: 12)
            $0.textAlignment = .center
        }

        self.view.addSubview(imageView)
        self.view.addSubview(label)

        imageView.centerAnchors == view.centerAnchors
        imageView.sizeAnchors == .square(size: 125)
        label.centerXAnchor == view.centerXAnchor
        label.topAnchor == imageView.bottomAnchor + 12
    }
}
extension UIImage {
    func convertToGrayScale() -> UIImage {
        let filter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        filter.setDefaults()
        filter.setValue(CoreImage.CIImage(image: self)!, forKey: kCIInputImageKey)

        return UIImage(cgImage: CIContext(options: nil).createCGImage(filter.outputImage!, from: filter.outputImage!.extent)!)
    }
}
