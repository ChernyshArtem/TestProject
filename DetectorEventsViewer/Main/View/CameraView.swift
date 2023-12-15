//
//  CameraView.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import UIKit
import SnapKit

class CameraView: UIViewController {

    var camera: Camera?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .orange
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        return nameLabel
    }()
    
    private let ipAddressLabel: UILabel = {
        let ipAddressLabel = UILabel()
        ipAddressLabel.backgroundColor = .orange
        return ipAddressLabel
    }()
    
    private let imageView: UIView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(nameLabel)
        view.addSubview(imageView)
        view.addSubview(ipAddressLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(50)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(ipAddressLabel.snp.top)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width)
        }
        ipAddressLabel.snp.makeConstraints { make in
            make.bottom.left.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(50)
        }
    }

    func configure(camera: Camera) {
        self.camera = camera
        nameLabel.text = "\(camera.displayId).\(camera.displayName)"
        ipAddressLabel.text = " IP: " + camera.ipAddress
        if camera.isActivated {
            imageView.backgroundColor = .gray
        } else {
            imageView.backgroundColor = .red
        }
    }
    
}
