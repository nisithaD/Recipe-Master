//
//  BrowseViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/2/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var recipes = [Recipe]()
    
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
        title = "Home"
        getRecipes()

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
    
    
    private func getRecipes() {
        APICaller.shared.getAllRecipes { result in
            switch result {
            case .success(let recipes):
                    self.recipes = recipes
                DispatchQueue.main.async {
                    self.recipeTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCardCell.identifier, for: indexPath) as? FoodCardCell else {
            return UITableViewCell()
        }
        let recipe = self.recipes[indexPath.row]
        cell.configure(with: recipe)
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
