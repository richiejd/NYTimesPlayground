//
//  ApiEndpoint.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

enum HTTPMethod {
  case get, post, put, delete

  var string: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    case .put:
      return "PUT"
    case .delete:
      return "DELETE"
    }
  }
}

enum ApiEndpoint {
  case getMovieReviews

  var path: String {
    switch self {
    case .getMovieReviews:
      return "/svc/movies/v2/reviews/search.json"
    }
  }

  var method: String {
    switch self {
    case .getMovieReviews:
      return HTTPMethod.get.string
    }
  }
}
