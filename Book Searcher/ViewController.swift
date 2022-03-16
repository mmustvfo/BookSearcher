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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    private func moveToDetail() {
        let vc = DetailViewController()
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
            return
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return count of books
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        
        //Add a tap gesture recognizer
        return UITableViewCell()
    }
        
}


class BookTapGestureRecognizer: UITapGestureRecognizer {
    
    init(target: Any?,action: Selector, book: Any) {
        super.init(target: target, action: action)
    }
    
}
