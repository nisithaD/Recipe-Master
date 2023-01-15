//
//  FavouriteViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/2/23.
//

import UIKit
import SDWebImage

class FavouriteViewController: UIViewController {
    var recipes = [Recipe]()
    var user_id = Int()
    
    private let recipeTable:UITableView = {
        let table = UITableView()
        table.register(FoodCardCell.self, forCellReuseIdentifier: FoodCardCell.identifier)
        return table
    }()
    
    private let searchController:UISearchController = {
        let controller = UISearchController(searchResultsController: BrowseResultViewController())
        controller.searchBar.placeholder = "Search Foods"
        controller.searchBar.searchBarStyle = .minimal
        controller.hidesNavigationBarDuringPresentation = false
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        getUserDetails()
        getAllFavouriteRecipes()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        
        view.addSubview(recipeTable)
        recipeTable.delegate = self
        recipeTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recipeTable.frame = view.bounds
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    
    private func getUserDetails() {
        let token = UserDefaults.standard.string(forKey: "token")
        if (token == nil) {
            let loginViewController = LoginViewController()
            present(loginViewController, animated: true, completion: nil)

        }else{
            guard let url = URL(string: "http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api/auth_user") else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        
            URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            do {
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                user_id = userResponse.user.id
            } catch let jsonError {
                print("Error decoding JSON: \(jsonError)")
            }
        }.resume()
      }
    }
    
    
    struct UserResponse: Codable {
        let status: Bool
        let message: String
        let user: UserData

        struct UserData: Codable {
            let id: Int
            let name: String
            let email: String
        }
    }
    
    private func getAllFavouriteRecipes() {
        let token = UserDefaults.standard.string(forKey: "token")
        if (token == nil) {
            let loginViewController = LoginViewController()
            present(loginViewController, animated: true, completion: nil)
        } else {
            guard let url = URL(string: "http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api/favourite/user/\(user_id)") else { return }
            print(url)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    return
                }
                do {
                   let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    for favouriteRecipeData in recipeResponse.data {
                        self.recipes.append(favouriteRecipeData.food_recipe)
                     }
                     DispatchQueue.main.async {
                        self.recipeTable.reloadData()
                    }
                } catch let jsonError {
                    print("Error decoding JSON: \(jsonError)")
                }
            }.resume()
        }
    }

    struct RecipeResponse: Codable {
        let data: [FavouriteRecipeData]
    }

    struct FavouriteRecipeData: Codable {
        let id: Int
        let user_id:Int
        let food_recipe_id:Int
        let created_at: String
        let updated_at: String
        let food_recipe: Recipe
    }

    struct Recipe: Codable {
        let id: Int
        let name: String
        let ingredients: String
        let description: String
        let image: String
        let calorie_count: Int
        let created_at: String
        let updated_at: String
    }

}

extension FavouriteViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCardCell.identifier, for: indexPath) as? FoodCardCell else {
            return UITableViewCell()
        }
        let recipe = self.recipes[indexPath.row]
        let url = URL(string: recipe.image)
        cell.recipeTitleLabel.text = recipe.name
        cell.recipeImageView.sd_setImage(with: url, completed: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeSingleViewController = RecipeSingleViewController()
        recipeSingleViewController.recipe_id = self.recipes[indexPath.row].id
        self.navigationController?.pushViewController(recipeSingleViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
