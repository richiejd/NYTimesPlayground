//
//  ApiClient.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/27/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

// this would be a part of UI I would think, but hardcoded as an external variable so it's clear
// we can also do non-critic picks and that flag is easy to change
fileprivate let useCriticsPicks = true

typealias ApiCompletionBlock = ((Data?, URLResponse?, Error?) -> Void)
typealias MovieCompletionBlock = ((_ result: [MovieReview]?, _ moreResultsAvailable: Bool, _ error: Error?) -> Void)

class ApiClient: NSObject {

  fileprivate func execute(endpoint: ApiEndpoint, params: [String: String], completion: @escaping ApiCompletionBlock) {
    let urlString = generateUrlString(endpoint: .getMovieReviews, params: params)
    if let url = URL(string: urlString) {
      let session = URLSession.shared
      let request = NSMutableURLRequest(url: url)
      request.httpMethod = endpoint.method

      let task = session.dataTask(with: url, completionHandler: { (data, res, error) in
        DispatchQueue.main.async {
          completion(data, res, error)
        }
      })
      task.resume()
    } else {
      DispatchQueue.main.async {
        completion(nil, nil, nil)
      }
    }
  }

  func getMovieReviews(searchParam: String?, offset: Int, completion: @escaping MovieCompletionBlock) {
    var params = ["critics-pick": (useCriticsPicks ? "Y": "N")]
    if searchParam?.characters.count ?? 0 > 0 {
      params["query"] = searchParam!
    }
    if offset > 0 {
      if offset % 20 == 0 {
        params["offset"] = "\(offset)"
      } else {
        NSLog("WARNING: An offset was provided that was not a multiple of 20, ignoring the input offset.")
      }
    }

    execute(endpoint: .getMovieReviews, params: params) { (data, response, error) in
      if let responseData = data  {
        do {
          // would like to externalize some of the json object unwrapping as we would normally have additional endpoints
          // but for simplicity not worrying about that here.
          if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? NSDictionary {
            if let hits = json["results"] as? [NSDictionary] {
              if let moreResults = json["has_more"] as? Bool {
                completion(hits.map({MovieReview(data: $0)}), moreResults, error)
              } else {
                completion(hits.map({MovieReview(data: $0)}), false, error)
              }
            } else {
              completion(nil, true, error)
            }
          } else {
            completion(nil, true, error)
          }
        } catch  {
          completion(nil, true, error)
        }
      } else {
        completion(nil, true, error)
      }
    }
  }

  // MARK: Url Construction

  fileprivate func generateUrlString(endpoint: ApiEndpoint, params: [String: String]) -> String {
    // ideally we'd use join here to prevent multi or lack of /'s but doing it this way to save time for demo
    let baseString = "\(Constants.Api.host)\(endpoint.path)?api-key=\(PrivateKeys.nyTimesApiKey)"
    let query = params.map({"&\($0)=\($1)"})
    return "\(baseString)\(query.joined())"
  }

}
