//
//  CharacterDetailsViewController.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 24.03.2024.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var filmsLabel: UILabel!
    
    // MARK: - Public properties
    var character: Character!
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterImageView.contentMode = .scaleAspectFit
        showSpinner(in: characterImageView)
        configure(with: character)
    }
    
    // MARK: - Private Methods
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = view.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    private  func configure(with character: Character?) {
        guard let character else { return }
        title = character.name
        
        nameLabel.text = "Name: \(character.name)"
        filmsLabel.text = character.filmsList().isEmpty 
        ? "No films" : "Films: \(character.filmsList())"
      
        
        networkManager.fetchData(from: character.imageUrl) { [unowned self]result in
            switch result {
            case .success(let imageData):
                characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

