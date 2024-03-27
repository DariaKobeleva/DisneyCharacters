//
//  ViewController.swift
//  DisneyCharacters
//
//  Created by Дарья Кобелева on 23.03.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    //MARK: Private properties
    private let networkManager = NetworkManager.shared
    private var characters: [Character] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 70
        
        fetchData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as? DetailsViewController
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = characters[indexPath.row]
        detailVC?.character = character
        
    }
    
    // MARK: - Private Methods
    private func fetchData() {
        networkManager.fetchCharacters { [unowned self] result in
            switch result {
            case .success(let characters):
                self.characters = characters
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "characterCell",
            for: indexPath
        ) as? TableViewCell else {
            return UITableViewCell()
        }
        
        let character = characters[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}
