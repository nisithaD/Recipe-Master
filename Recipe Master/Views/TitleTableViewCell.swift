//
//  TitleTableViewCell.swift
//  Recipe Master
//
//  Created by Nisitha on 1/5/23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

   static let identifier = "TitleTableViewCell"
    
    let titleRecipeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleRecipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleRecipeImageView)
        contentView.addSubview(titleRecipeLabel)
        
        applyConstraints()
    }
    
    private func applyConstraints(){
        let titleRecipeImageViewConstraints = [
            titleRecipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            titleRecipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titleRecipeImageView.widthAnchor.constraint(equalToConstant: 100)
        ]

        let titleRecipeLableConstraints = [
            titleRecipeLabel.leadingAnchor.constraint(equalTo: titleRecipeImageView.trailingAnchor, constant: 20),
            titleRecipeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]

        
        NSLayoutConstraint.activate(titleRecipeImageViewConstraints)
        NSLayoutConstraint.activate(titleRecipeLableConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
