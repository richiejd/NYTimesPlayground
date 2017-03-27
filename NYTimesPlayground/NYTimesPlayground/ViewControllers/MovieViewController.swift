//
//  MovieViewController.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var openingDateLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  @IBOutlet weak var bylineLabel: UILabel!
  @IBOutlet weak var articleButton: UIButton!
  @IBOutlet weak var movieImageView: ImageView!

  var movie: MovieReview

  // MARK: Init

  init(movie: MovieReview) {
    self.movie = movie
    super.init(nibName: "MovieViewController", bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Movie"
    syncWithReview()
  }

  // MARK: Model Sync

  func syncWithReview() {
    movieImageView?.imageModel = movie.image
    movieTitleLabel?.text = movie.title
    openingDateLabel?.text = movie.openingDate
    ratingLabel?.text = movie.rating
    summaryLabel?.text = movie.summary
    bylineLabel?.text = "By: \(movie.byline)"
    articleButton?.setTitle(movie.headline, for: .normal)
    articleButton?.titleLabel?.textAlignment = .center
  }

  // MARK: Actions

  @IBAction func didTapArticle(_ sender: Any) {
    if let url = URL(string: movie.link) {
      let modal = MovieArticleWebViewController(url: url)
      modal.modalPresentationStyle = .overCurrentContext
      present(modal, animated: true, completion: nil)
    } else {
      // should show an error for bad link, will leave out of demo
    }
  }
  
}
