//
//  CameraCell.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import UIKit
import SnapKit

class CameraCell: UICollectionViewCell {
    static let identifeier = "CameraCell"
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(ipAddressLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(contentView.frame.width)
            make.height.equalTo(30)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.bottom.equalTo(ipAddressLabel.snp.top)
            make.left.right.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(contentView.frame.width)
        }
        ipAddressLabel.snp.makeConstraints { make in
            make.bottom.left.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(contentView.frame.width)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
