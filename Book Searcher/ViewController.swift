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
        
        searchBar.delegate = self
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
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        
        //Add a tap gesture recognizer
        return UITableViewCell()
    }
        
}


class BookTapGestureRecognizer: UITapGestureRecognizer {
    
    init(target: Any?,action: Selector, book: QueryResult) {
        super.init(target: target, action: action)
    }
    
}
