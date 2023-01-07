//
//  Food CardCell.swift
//  Recipe Master
//
//  Created by Nisitha on 1/2/23.
//

import UIKit

class FoodCardCell: UITableViewCell {
    static let identifier = "FoodCardCell"
    static let height: CGFloat = 250
    
   let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        return view
    }()
    
    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "polos")
        return imageView
    }()
    
    var recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            contentView.addSubview(cardView)
            cardView.addSubview(recipeImageView)
            cardView.addSubview(recipeTitleLabel)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            recipeImageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.75),
            
            recipeTitleLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            
        ])
    }
    
    func configure(with recipe: String) {
        recipeTitleLabel.text = recipe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
