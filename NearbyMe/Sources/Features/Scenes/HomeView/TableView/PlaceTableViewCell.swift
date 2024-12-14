//
//  PlaceTableViewCell.swift
//  NearbyMe
//
//  Created by Juliany Savazzi on 13/12/24.
//

import Foundation
import UIKit

//lista de elementos visual
class PlaceTableViewCell: UITableViewCell {
    static let identifier = "PlaceTableCell"
    
    let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleSM
        label.numberOfLines = 0
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let description = UILabel()
        description.font = Typography.textSM
        description.numberOfLines = 0
        description.textColor = Colors.gray600
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    let ticketIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.redBase
        imageView.image = UIImage(named: "ticketIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let ticketLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textXS
        label.numberOfLines = 0
        label.textColor = Colors.gray300
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //ContainerView -> vai conter todos os elementos do nosso componente TableCell
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.gray200.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: <#T##UITableViewCell.CellStyle#>, reuseIdentifier: <#T##String?#>)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        //adicionando as subviews ao container view
        containerView.addSubview(itemImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(ticketIcon)
        containerView.addSubview(ticketLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        //podemos usar no constraint equalTo -> contentView. ou self. ou colocar apenas a direção (topAnchor, leadingAnchor etc)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 116),
            itemImageView.heightAnchor.constraint(equalToConstant: 104),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ticketIcon.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 8),
            ticketIcon.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            ticketIcon.widthAnchor.constraint(equalToConstant: 13),
            ticketIcon.heightAnchor.constraint(equalToConstant: 11),
            
            ticketLabel.centerYAnchor.constraint(equalTo: ticketIcon.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: ticketIcon.trailingAnchor, constant: 4),
        ])
    }
    
    //configurar o componente TableCell utilizando a model Place
    func configure(with place: Place) {
        itemImageView.image = UIImage(named: place.imageName)
        titleLabel.text = place.title
        descriptionLabel.text = "cupons disponíveis"
    }
}
