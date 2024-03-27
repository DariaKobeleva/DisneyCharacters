////
////  TableViewCell.swift
////  DisneyCharacters
////
////  Created by Дарья Кобелева on 23.03.2024.
////
//
//import UIKit
//
//class TableViewCell: UITableViewCell {
//    
//    // MARK: IBOutlets
//    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var characterImageView: UIImageView!{
//        didSet {
//            characterImageView.contentMode = .scaleAspectFill
//            characterImageView.clipsToBounds = true
//            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
//        }
//    }
//    
//    //MARK: - Private Methods
//    private let networkManager = NetworkManager.shared
//    
//        
//    // MARK: - Public methods
//    func configure(with character: Character?) {
//        guard let character else { return }
//        nameLabel.text = character.name
//        
//        networkManager.fetchData(from: character.imageUrl) { [unowned self] result in
//            switch result {
//            case .success(let imageData):
//                characterImageView.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//}
