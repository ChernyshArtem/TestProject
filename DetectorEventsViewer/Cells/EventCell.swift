//
//  EventCell.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 14.12.23.
//

import UIKit
import SnapKit
class EventCell: UICollectionViewCell {
    static let identifeier = "EventCell"
    
    private let duration: UILabel = {
        let duration = UILabel()
        duration.numberOfLines = 2
        duration.textAlignment = .center
        return duration
    }()
    
    private let type: UILabel = {
        let type = UILabel()
        type.numberOfLines = 2
        type.textAlignment = .left
        return type
    }()
    
    private let date: UILabel = {
        let date = UILabel()
        date.numberOfLines = 3
        date.textAlignment = .center
        return date
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(duration)
        contentView.addSubview(type)
        contentView.addSubview(date)
        type.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.left.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(120)
        }
        date.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalTo(duration.snp.left).inset(-16)
            make.left.equalTo(type.snp.right).offset(16)
        }
        duration.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.right.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(70)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(event: Event) {
        duration.text = "Duration:\n"+String(Double(event.duration ?? "0.0") ?? 0.0)
        type.text = "Type:\n" + event.type
        date.text = configureDate(timestamp: event.timestamp)
    }
    
    private func configureDate(timestamp: String) -> String {
        let dataString: NSMutableString = NSMutableString(string: "\(timestamp.split(separator: "T")[0])")
        dataString.insert(".", at: 4)
        dataString.insert(".", at: 7)
        var actualData = "\(dataString)"
        let splitedData = actualData.split(separator: ".")
        actualData = "\(splitedData[2]).\(splitedData[1]).\(splitedData[0])"
        
        let timeString: NSMutableString = NSMutableString(string: "\(timestamp.split(separator: "T")[1])")
        timeString.insert(":", at: 2)
        timeString.insert(":", at: 5)
        var actualTime: String = "\(timeString)"
        actualTime = "\(actualTime.split(separator: ".")[0])"
        return "Date and time:\n\(actualData)\n\(actualTime)"
    }
}
