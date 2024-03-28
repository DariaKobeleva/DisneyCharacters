//
//  TableViewCell.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import UIKit
import Kingfisher

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
    
    // MARK: - Public methods
    func configure(with character: Character?) {
        guard let character else { return }
        nameLabel.text = character.name
        
        let imageUrl = URL(string: character.imageUrl)
        
        if character.imageUrl.isEmpty {
            characterImageView.image = UIImage(named: "defaultImage")
        } else {
            characterImageView.kf.setImage(with: imageUrl)
        }
    }
}
