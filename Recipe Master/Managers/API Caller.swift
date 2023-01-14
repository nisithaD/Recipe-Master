//
//  API Caller.swift
//  Recipe Master
//
//  Created by Nisitha on 1/8/23.
//

import Foundation

struct Constants {
    static let baseURL = "http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api"
}

enum APIError: Error {
    case faildToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getAllRecipes(completion: @escaping (Result<[Recipe],Error>)->Void){
        guard let url = URL(string: "\(Constants.baseURL)/food-recipe")else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, _, error in
            guard let data = data, error == nil else {
                return
                }
            do {
                let results = try JSONDecoder().decode(RecipesListResponse.self, from: data)
                completion(.success(results.data))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
