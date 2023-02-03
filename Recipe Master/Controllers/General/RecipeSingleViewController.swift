//
//  RecipeSingleViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/6/23.
//

import UIKit
import Foundation
import SDWebImage

class RecipeSingleViewController: UIViewController {
    var recipe_id: Int?
    var token: String?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 24,weight: .bold)
//        label.text = "Polos Curry"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "This is a traditional srilankan polos curry."
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 20,weight: .semibold)
        label.text = "Ingredients"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingredientsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "This is a traditional srilankan polos curry."
        label.numberOfLines = 0
        return label
    }()
    
    private let calorieCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18,weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.numberOfLines = 0
        return label
    }()
    
    private let calorieCountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calorie Info"
        label.numberOfLines = 0
        return label
    }()
    

    
    private let addToFavouriteButon: UIButton = {
        let newImage = UIImage(named: "heart-icon")?.withTintColor(.white)
        let addToFavoritesButton = UIButton()
//        addToFavoritesButton.setImage(UIImage(named: "heart-icon"), for: .normal)
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        addToFavoritesButton.setImage(newImage, for: .normal)
        addToFavoritesButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return addToFavoritesButton
    }()


    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
//        imageView.image = UIImage(named: "polos")
        
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
        view.addSubview(ingredientsTitleLabel)
        view.addSubview(ingredientsLabel)
        view.addSubview(calorieCountLabel)
        view.addSubview(calorieCountTitleLabel)
        
        configureConstraints()
        
        navigationItem.hidesBackButton = false
//        navigationController?.isNavigationBarHidden = true
        let recipeID=(self.recipe_id!)
        let url="http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api/food-recipe/\(recipeID)"
        getData(from:url)
    }
    
    private func getData(from url:String){
      let task =  URLSession.shared.dataTask(with: URL(string: url)!,completionHandler: {data, response, error in
        guard let data = data, error == nil else{
                print("Something went wrong")
                return
            }
            var result:Data?
            do{
                result = try JSONDecoder().decode(Data.self, from: data)
            }catch{
                print("faild to convert \(error.localizedDescription)")
            }
            guard let json = result else{
                return
            }
//        print(json.data.name)
            DispatchQueue.main.async {
                  self.titleLabel.text = json.data.name
                  self.overViewLabel.text = json.data.description
                  self.ingredientsLabel.text = json.data.ingredients
                  guard let url = URL(string: json.data.image) else { return }
                  self.imageView.sd_setImage(with: url, completed: nil)
                  self.calorieCountLabel.text = "100g of meal includes : \(json.data.calorie_count) cal."
            }
        })
      
      task.resume()
    }
    
    struct Data: Codable {
        let data:MyResult
    }

    struct MyResult: Codable{
        let ingredients: String
        let calorie_count: Double
        let created_at: String
        let description: String
        let id: Int
        let image: String
        let name: String
        let updated_at: String
    }
    
    
    @objc func addToFavorites() {
        let recipeID=(self.recipe_id!)
        let token = UserDefaults.standard.string(forKey: "token")
        if token == nil {
            let loginViewController = LoginViewController()
            present(loginViewController, animated: true, completion: nil)
        }else{
        let url = URL(string: "http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api/favourite/add/\(recipeID)")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let message = json?["message"] as? String
                    
                    let alert = UIAlertController(title: "Favourite", message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }catch let error{
                    print(error)
                }
            }
        }
        task.resume()
      }
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
        
        let ingredientsTitleLabelConstraints = [
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsTitleLabel.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor,constant: 20),
        ]
        
        let ingredientsLabelConstraints = [
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor),
        ]
        
        let calorieCountTitleLabelConstraints = [
            calorieCountTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calorieCountTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calorieCountTitleLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor,constant: 20),
        ]
        
        let calorieCountLabelConstraints = [
            calorieCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calorieCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calorieCountLabel.topAnchor.constraint(equalTo: calorieCountTitleLabel.bottomAnchor),
        ]
        
  
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(addToFavouriteButtonConstraints)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(ingredientsTitleLabelConstraints)
        NSLayoutConstraint.activate(ingredientsLabelConstraints)
        NSLayoutConstraint.activate(calorieCountLabelConstraints)
        NSLayoutConstraint.activate(calorieCountTitleLabelConstraints)
    }
        
}
