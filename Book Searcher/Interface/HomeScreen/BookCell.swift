//
//  BookCell.swift
//  Book Searcher
//
//  Created by Mustafo on 17/03/22.
//

import UIKit
import Kingfisher

class BookCell: UITableViewCell {
    
    @IBOutlet var thumbnailImage: UIImageView!
    
    @IBOutlet var bookName: UILabel!
    
    @IBOutlet var authorLabel: UILabel!
    
    static let identifier = "BookCell"
    
    var book: Book? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configure() {
        guard let book = book else {
            return
        }
        thumbnailImage.kf.setImage(
            with: book.volumeInfo.smallImageLink,
            placeholder: UIImage(systemName: "slowmo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        bookName.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors?.joined(separator: ",") ?? ""
    }

}
