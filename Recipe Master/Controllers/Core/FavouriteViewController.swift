//
//  FavouriteViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/2/23.
//

import UIKit

class FavouriteViewController: UIViewController {

    let recipes:[String] = ["Polos Curry","Chicken Curry","Black Pork Curry","Fruite Salad"]
    
    private let favouriteRecipeTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourites"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(favouriteRecipeTable)
        favouriteRecipeTable.delegate = self
        favouriteRecipeTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favouriteRecipeTable.frame = view.bounds
    }
}

extension FavouriteViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        cell.titleRecipeLabel.text = recipes[indexPath.row]
//        cell.titleRecipeImageView.image = UIImage(named: "polos")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
