//
//  BookCell.swift
//  Book Searcher
//
//  Created by Mustafo on 17/03/22.
//

import UIKit

class BookCell: UITableViewCell {
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var bookName: UILabel!
    
    @IBOutlet var bookAuthor: UILabel!
    
    static let identifier = "BookCell"
    
    var book: Book? {
        didSet {
            guard let book = book else {
                return
            }
            bookName.text = book.volumeInfo.title
            bookAuthor.text = book.volumeInfo.authors.joined(separator: ",")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
