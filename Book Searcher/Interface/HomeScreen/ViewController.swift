//
//  ViewController.swift
//  Book Searcher
//
//  Created by Mustafo on 15/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BookCell", bundle: .main), forCellReuseIdentifier: BookCell.identifier)
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func moveToDetail(book: Book) {
        //Navigate to DetailViewController
        let vc = DetailViewController(book: book)
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Throttle,
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)
    }
    
    @objc private func reload() {
        guard let text = searchBar.text else {
            print("Couldn't get search text.")
            return
        }
        //Make a request
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return count of books
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        //cell.book = books[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigate to detail screen
        //moveToDetail(book: books[indexPath.row])
    }
            
}

