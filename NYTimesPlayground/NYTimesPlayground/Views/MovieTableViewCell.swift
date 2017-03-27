//
//  MovieTableViewCell.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  // ~sum of vertical margins, image height, title label height, adjusted to look nice
  static var requiredHeight: CGFloat { get { return 212 } }

  var titleLabel: UILabel!
  var movieImageView: ImageView!
  var ratingLabel: UILabel!
  var openingDateLabel: UILabel!

  var review: MovieReview?

  var overlayView: UIView!

  // MARK: Init

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: UITableViewCell

  override func setHighlighted(_ highlighted: Bool, animated: Bool) {
    overlayView?.isHidden = !highlighted
  }

  // MARK: Prepare

  // should be called in will display cell to populate cell data
  func prepare(review: MovieReview) {
    self.review = review
    titleLabel.text = review.title
    movieImageView.imageModel = review.image
    ratingLabel.text = review.rating
    openingDateLabel.text = review.openingDate
  }

  // MARK: View Setup

  func setupSubviews() {
    titleLabel = UILabel(title: "", color: .greyDark, font: .bold, fontSize: 16, translatesARMIC: false)
    titleLabel.numberOfLines = 0
    addSubview(titleLabel)

    movieImageView = ImageView()
    movieImageView.backgroundColor = Color.greyBackground.ui
    movieImageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(movieImageView)

    let ratingTitleLabel = UILabel(title: "Rating", color: .greyDark, font: .bold, fontSize: 14, translatesARMIC: false)
    addSubview(ratingTitleLabel)

    ratingLabel = UILabel(title: "", color: .greyDark, font: .regular, fontSize: 14, translatesARMIC: false)
    addSubview(ratingLabel)

    let openingDateTitleLabel = UILabel(title: "Opening Date", color: .greyDark, font: .bold, fontSize: 14, translatesARMIC: false)
    addSubview(openingDateTitleLabel)

    openingDateLabel = UILabel(title: "", color: .greyDark, font: .regular, fontSize: 14, translatesARMIC: false)
    addSubview(openingDateLabel)

    overlayView = UIView()
    overlayView.translatesAutoresizingMaskIntoConstraints = false
    overlayView.backgroundColor = Color.white.ui.withAlphaComponent(0.25)
    addSubview(overlayView)
    overlayView.isHidden = true

    visualConstraints(
      [
        "H:|-16-[title]-16-|",
        "H:|-16-[img(imgW)]-12-[ratingTitle]-16-|",
        "V:|-16-[title]-16-[img(imgH)]",
        "V:[ratingTitle]-4-[rating]-16-[openingDateTitle]-4-[openingDate]",
        "V:|[overlay]|",
        "H:|[overlay]|"
      ],
      metrics: ["imgH": 140 as NSNumber, "imgW": 210 as NSNumber],
      views: [
        "title": titleLabel,
        "img": movieImageView,
        "ratingTitle": ratingTitleLabel,
        "rating": ratingLabel,
        "openingDateTitle": openingDateTitleLabel,
        "openingDate": openingDateLabel,
        "overlay": overlayView
      ]
    )
    matchAttributes(
      views: [ratingTitleLabel, ratingLabel, openingDateTitleLabel, openingDateLabel],
      attributes: [.leading, .trailing]
    )
    matchAttributes(views: [movieImageView, ratingTitleLabel], attributes: [.top])
  }

}
