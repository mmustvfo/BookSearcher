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
    
    var books: [Book] = [] {
        didSet {
            print(books.count)
            tableView.reloadData()
        }
    }
    
    var alertIsSHown = false
    
    private let booksAPIManager = BooksAPIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "BookCell", bundle: .main), forCellReuseIdentifier: BookCell.identifier)
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func moveToDetail(book: Book) {
        //Navigate to DetailViewController
        print("Navigatin to DetailVC")
        let vc = DetailViewController()
        vc.book = book
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //Throttle,
        self.perform(#selector(reload), with: nil, afterDelay: 0.5)
    }
    
    @objc private func reload() {
        guard let text = searchBar.text, !text.isEmpty else {
            print("Couldn't get search text.")
            return
        }
        //Make a request
        booksAPIManager.makeRequest(for: text) { [weak self] result in
            DispatchQueue.main.async {
                if let result = result {
                    self?.books = result.items
                }
            }
        }
    }
    
    private func showErrorAlert(error: Error) {
        guard !alertIsSHown else {
            return
        }
        let alertVC = UIAlertController(title: "Ooops", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.alertIsSHown = false
        }))
        self.present(alertVC, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Return count of books
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        cell.book = books[indexPath.row]
        print("CELL INIT")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Navigate to detail screen
        moveToDetail(book: books[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

