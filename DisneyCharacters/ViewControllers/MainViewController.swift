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
    private var charactersResponse: CharactersResponse?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        tableView.backgroundColor = .white
        
        fetchData(from: NetworkManager.APIEndpoint.baseURL.url)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if let detailsVC = segue.destination as? DetailsViewController {
            let character = charactersResponse?.data[indexPath.row]
            detailsVC.character = character
        }
    }
    
    // MARK: - Private Methods
    private func fetchData(from url: URL?) {
        networkManager.fetch(CharactersResponse.self, from: url) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.charactersResponse = characters
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersResponse?.data.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "characterCell",
            for: indexPath
        )
        guard let cell = cell as? TableViewCell else { return UITableViewCell() }
        let character = charactersResponse?.data[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}
