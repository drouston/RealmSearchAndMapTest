//
//  EventCell.swift
//  EventListPrgm
//
//  Created by Drew Collier on 3/10/20.
//  Copyright © 2020 Drew Collier. All rights reserved.
//

import UIKit
import EventKit

class EventCell: UITableViewCell {
    
    let eventImage: UIImageView = UIImageView()
    let titleLabel: UILabel = UILabel()
    let detailsLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    let timeLabel: UILabel = UILabel()
    let calColorView: UIView = UIView()
    
    lazy var dateStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [dateLabel, timeLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.contentMode = .scaleToFill
        stack.alignment = .fill
        stack.distribution = .fill
        timeLabel.textAlignment = .right
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = titleLabel.font.withSize(14)
        dateLabel.textAlignment = .right
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = detailsLabel.font.withSize(16)
        return stack
    }()
    
    lazy var detailStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, detailsLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.contentMode = .scaleToFill
        stack.alignment = .fill
        stack.distribution = .fill
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = titleLabel.font.withSize(18)
        detailsLabel.textAlignment = .left
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.font = detailsLabel.font.withSize(14)
        return stack
    }()
    
    lazy var cellStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [calColorView, eventImage, detailStack, dateStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        calColorView.translatesAutoresizingMaskIntoConstraints = false
        
        eventImage.contentMode = .scaleAspectFit
        eventImage.clipsToBounds = true
        eventImage.layer.masksToBounds = true
        eventImage.widthAnchor.constraint(equalTo: eventImage.heightAnchor).isActive = true
        eventImage.leadingAnchor.constraint(equalTo: calColorView.trailingAnchor, constant: 0).isActive = true
        eventImage.layer.cornerRadius = ((self.bounds.height/2) + 3)
        calColorView.widthAnchor.constraint(equalToConstant: 6).isActive = true
        calColorView.heightAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
        calColorView.clipsToBounds = true
        calColorView.backgroundColor = .clear
        calColorView.heightAnchor.constraint(equalTo: stack.heightAnchor).isActive = true
        detailStack.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor).isActive = true
        dateStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor).isActive = true
        dateStack.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return stack
    }()
    
    //MARK: Initializing properties
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: setupViews()
    
    func setupViews() {
        
        addSubview(cellStack)
        cellStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cellStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
