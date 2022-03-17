//
//  DetailViewController.swift
//  Book Searcher
//
//  Created by Mustafo on 17/03/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var bigImageView: UIImageView!
    
    @IBOutlet var smallImageView: UIImageView!
    
    @IBOutlet var bookNameLabel: UILabel!
    
    @IBOutlet var authorLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    var book: Book? {
        didSet {
//            configure()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigImageView.layer.cornerRadius = 10
        let darkBlur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.frame = bigImageView.bounds
        
        bigImageView.addSubview(blurView)
        
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        configure()
        // Do any additional setup after loading the view.
    }

    private func configure() {
        guard let book = book else {
            return
        }
        bigImageView.kf.setImage(with: book.volumeInfo.bigImageLink, placeholder: UIImage(systemName: "slowmo"), options:  [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        smallImageView.kf.setImage(with: book.volumeInfo.smallImageLink, placeholder: UIImage(systemName: "slowmo"), options:  [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ])
        bookNameLabel.text = book.volumeInfo.title
        authorLabel.text = book.volumeInfo.authors?.joined(separator: ",")
        descriptionLabel.text = book.volumeInfo.volumeInfoDescription ?? "--"
    }
    

}
