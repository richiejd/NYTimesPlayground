//
//  MovieReview.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

class MovieReview: NSObject {

  var title: String
  var byline: String
  var headline: String
  var summary: String
  var image: Image?
  var rating: String
  var link: String
  var linkText: String
  var openingDate: String

  init(data:NSDictionary) {
    title = data.convert(key: "display_title", fallback: "Untitled")
    byline = data.convert(key: "byline", fallback: "")
    headline = data.convert(key: "headline", fallback: "")
    summary = data.convert(key: "summary_short", fallback: "")
    rating = data.convert(key: "mpaa_rating", fallback: "Not Rated")
    if rating.characters.count == 0 {
      rating = "Not Rated"
    }
    link = data.convert(key: "link.url", fallback: "")
    linkText = data.convert(key: "link.suggested_link_text", fallback: "")
    if let dateString = data["opening_date"] as? String {
      if let date = DateFormat.api.date(from: dateString) {
        if let formattedString = DateFormat.monthDayYear.string(from: date) {
          openingDate = formattedString
        } else {
          openingDate = data.convert(key: "opening_date", fallback: "")
        }
      } else {
        openingDate = data.convert(key: "opening_date", fallback: "")
      }
    } else {
      openingDate = data.convert(key: "opening_date", fallback: "")
    }
    if let multimedia = data["multimedia"] as? NSDictionary {
      if let url = multimedia["src"] as? String {
        image = Image(url: url)
      }
    }

    super.init()

    if openingDate.characters.count == 0 {
      openingDate = "TBD"
    }
  }

}
