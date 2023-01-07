import UIKit

class SignUpViewController: UIViewController {

    let mainTabBarViewController = MainTabBarViewController()

    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        textField.layer.cornerRadius = 5
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()
    private let passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.backgroundColor = UIColor.systemBackground.cgColor
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = true
        return textField
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Master"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .systemBackground
        return label
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        self.view.addSubview(titleLabel)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(passwordConfirmTextField)
        self.view.addSubview(signUpButton)
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordConfirmTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
    

        NSLayoutConstraint.activate([
   
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 44),

            usernameTextField.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 200),
            usernameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),

            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        
            
            signUpButton.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 10),
            signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        signUpButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        let mainTabBarViewController = MainTabBarViewController()
        UIView.transition(with: UIApplication.shared.windows.first!, duration: 0.5, options: .transitionFlipFromLeft, animations: {
              UIApplication.shared.windows.first?.rootViewController = mainTabBarViewController
          }, completion: nil)
    }
}



