//
//  AccountViewController.swift
//  Recipe Master
//
//  Created by Nisitha on 1/2/23.
//

import UIKit

class AccountViewController: UIViewController {


    let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "user")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let logoutButton: UIButton = {
           let button = UIButton()
           button.setTitle("Log Out", for: .normal)
           button.setTitleColor(.white, for: .normal)
           button.backgroundColor = .systemRed
           button.layer.cornerRadius = 5
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
        
        setupLayout()
        getUserDetails()
    }


    private func setupLayout() {
            view.addSubview(userNameLabel)
            view.addSubview(emailLabel)
            view.addSubview(userImageView)
            view.addSubview(logoutButton)

        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),

            emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            userImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userImageView.heightAnchor.constraint(equalToConstant: 40),
            userImageView.widthAnchor.constraint(equalToConstant: 40),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func logoutButtonTapped() {
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let url = URL(string: "http://iosrecipeapp-env.eba-mensumeb.us-east-1.elasticbeanstalk.com/api/logout") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            UserDefaults.standard.removeObject(forKey: "token")
            DispatchQueue.main.async {
                let mainTabBarViewController = MainTabBarViewController()
                UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                      UIApplication.shared.windows.first?.rootViewController = mainTabBarViewController
                  }, completion: nil)
            }
        }.resume()
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
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                DispatchQueue.main.async {
                    self.emailLabel.text = userResponse.user.email
                    self.userNameLabel.text = userResponse.user.name
                }
                
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
    
    
}
