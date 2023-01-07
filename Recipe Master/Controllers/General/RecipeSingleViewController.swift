//
//  RecipeSingleViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/6/23.
//

import UIKit

class RecipeSingleViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 22,weight: .bold)
        label.text = "Polos Curry"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a traditional srilankan polos curry."
        label.numberOfLines = 0
        return label
    }()
    

    
    private let addToFavouriteButon: UIButton = {
        let newImage = UIImage(named: "heart-icon")?.withTintColor(.white)
        let addToFavoritesButton = UIButton()
//        addToFavoritesButton.setImage(UIImage(named: "heart-icon"), for: .normal)
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.setImage(newImage, for: .normal)
        return addToFavoritesButton
    }()


    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        imageView.image = UIImage(named: "polos")
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = imageView.bounds
        gradientLayer.opacity = 1
        imageView.layer.addSublayer(gradientLayer)

        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(overViewLabel)
        view.addSubview(addToFavouriteButon)
        
        configureConstraints()
        
        navigationItem.hidesBackButton = false
//        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    func configureConstraints() {
        let imageViewConstraints = [
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3),
        ]

        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]

        let addToFavouriteButtonConstraints = [
            addToFavouriteButon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addToFavouriteButon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addToFavouriteButon.widthAnchor.constraint(equalToConstant: 25),
            addToFavouriteButon.heightAnchor.constraint(equalToConstant: 25)
        ]


        let overViewLabelConstraints = [
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            overViewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
        ]
        
  
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(addToFavouriteButtonConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
    }

}
