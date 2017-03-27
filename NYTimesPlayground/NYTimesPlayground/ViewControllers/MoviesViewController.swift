//
//  MoviesViewController.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MoviesViewControllerMovieReviewCell"

class MoviesViewController: ViewController {

  var tableView: UITableView!
  var searchBar: UISearchBar!
  var searchBarRightConstraint: NSLayoutConstraint!
  var cancelButton: UIButton!

  let searchController = UISearchController(searchResultsController: nil)
  var search = ""

  var offset = 0
  var movieList = [MovieReview]()
  // idea is if we are fetching the next results, then we should wait for new results to come
  // in rather than triggering a duplicate (or future) fetch (product should decide how eagerly
  // we want to fetch), however if a new search is triggered while fetching new results for a different set
  // when the new set comes back we should perform the search anyways
  var hasNextSearchQueued = false
  var isFetchingNewItems = false
  var hasMoreResultsForActiveQuery = true
  var activeSearchQuery = ""

  // MARK: UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.isTranslucent = false

    title = "Movies"

    let bg = UIView(backgroundColor: .greyBackground, translatesARMIC: false)
    view.addSubview(bg)

    cancelButton = UIButton(title: "Cancel", titleColor: .greyDark, titleFont: .regular, titleFontSize: 13, translatesARMIC: false)
    cancelButton.addTarget(self, action: #selector(MoviesViewController.cancelSearch(sender:)), for: .touchUpInside)
    cancelButton.alpha = 0.0
    view.addSubview(cancelButton)

    searchBar = UISearchBar(frame: .zero)
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.delegate = self
    view.addSubview(searchBar)

    let div = UIView(backgroundColor: .greyDivider, translatesARMIC: false)
    view.addSubview(div)

    tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)

    view.visualConstraints(
      ["H:|[search]", "H:|[div]|", "H:|[t]|", "H:[cancel(80)]|", "V:|[search][div(0.5)][t]|", "H:|[bg]|"],
      metrics: nil,
      views: ["t": tableView!, "div": div, "search": searchBar, "cancel": cancelButton, "bg": bg]
    )
    view.matchAttributes(views: [searchBar, cancelButton, bg], attributes: [.centerY, .height])
    searchBarRightConstraint = NSLayoutConstraint(view1: searchBar, view2: view, attribute: .right)
    view.addConstraint(searchBarRightConstraint)

    tableView?.register(MovieTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView?.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.ScreenSize.width, height: 16))

    fetchResultsIfNeeded(isNewSearch: true)
  }

  // MARK: Actions

  func cancelSearch(sender: UIButton) {
    searchBar?.text = ""
    search = ""
    fetchResultsIfNeeded(isNewSearch: true)
    dismissKeyboard()
  }

  // MARK: Data Load

  func fetchResultsIfNeeded(isNewSearch: Bool) {
    if !isFetchingNewItems && (hasMoreResultsForActiveQuery || isNewSearch) {
      isFetchingNewItems = true
      activeSearchQuery = search
      if isNewSearch {
        offset = 0
      }
      apiClient.getMovieReviews(searchParam: activeSearchQuery, offset: offset, completion: { [weak self](reviews, hasMore, error) in
        if let arr = reviews {
          self?.offset = (self?.offset ?? 0) + arr.count
          if isNewSearch {
            self?.movieList = arr
          } else {
            self?.movieList.append(contentsOf: arr)
          }
          self?.tableView?.reloadData()
        } else if let _ = error {
          // should handle error and show something, not handling for demo
        }
        self?.hasMoreResultsForActiveQuery = hasMore

        self?.isFetchingNewItems = false
        if self?.hasNextSearchQueued ?? false {
          self?.hasNextSearchQueued = false
          self?.fetchResultsIfNeeded(isNewSearch: true)
        }
      })
    } else if isNewSearch && activeSearchQuery != search {
      hasNextSearchQueued = true
    }
  }

}

// MARK: UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? MovieTableViewCell {
      cell.prepare(review: movieList[indexPath.row])
      if movieList.count - indexPath.row < 10 {
        fetchResultsIfNeeded(isNewSearch: false)
      }
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return MovieTableViewCell.requiredHeight
  }

}

// MARK: UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    let movie = movieList[indexPath.row]
    let vc = MovieViewController(movie: movie)
    navigationController?.pushViewController(vc, animated: true)

    return nil
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    searchBar?.resignFirstResponder()
  }

}

// MARK: UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }

  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    if let field = searchBar.value(forKey: "searchField") as? UITextField {
      field.tintColor = UIColor.clear
      DispatchQueue.main.asyncFromNow(delayInSeconds: 0.5) {
        field.tintColor = Color.greyDark.ui
      }
    }
    return true
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    UIView.animate(withDuration: 0.35) {
      self.cancelButton?.alpha = 1.0
      self.searchBarRightConstraint?.constant = -80
      self.view.layoutIfNeeded()
    }
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    UIView.animate(withDuration: 0.3) {
      self.cancelButton?.alpha = 0.0
      self.searchBarRightConstraint?.constant = 0
      self.view.layoutIfNeeded()
    }
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    search = searchText
    fetchResultsIfNeeded(isNewSearch: true)
  }

}
