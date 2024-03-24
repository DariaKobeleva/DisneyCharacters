//
//  TableViewCell.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView!{
        didSet {
            characterImageView.contentMode = .scaleAspectFill
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        }
    }
    
    private let networkManager = NetworkManager.shared
        
    // MARK: - Public methods
    func configure(with character: Character?) {
        guard let character else { return }
        nameLabel.text = character.name
        
        guard let imageUrl = character.imageUrl ?? URL(string: Character.defaultImage) else { return }
        networkManager.fetchImage(from: imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
