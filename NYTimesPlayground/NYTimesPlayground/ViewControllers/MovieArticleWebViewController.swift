//
//  MovieArticleWebViewController.swift
//  NYTimesPlayground
//
//  Created by Richie Davis on 3/24/17.
//  Copyright © 2017 Richie Davis. All rights reserved.
//

import UIKit

fileprivate let closeHeight = CGFloat(48) // should retrieve this from the view, ... being lazy as this is an example
fileprivate let statusBarHeight = CGFloat(20)

class MovieArticleWebViewController: UIViewController {

  var articleWebView: UIWebView!
  var loadingView: UIActivityIndicatorView!
  var url: URL

  // for allowing user to have immersive web view experience
  var lastScrollOffset = CGFloat(0.0)
  var isCloseHidden = false
  var closeTopConstraint: NSLayoutConstraint!

  let closeDelta = statusBarHeight - closeHeight

  // MARK: Init

  init(url: URL) {
    self.url = url
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Color.white.ui

    let closeButton = UIButton()
    closeButton.setImage(UIImage(named: "x"), for: UIControlState())
    closeButton.translatesAutoresizingMaskIntoConstraints = false
    closeButton.addTarget(self, action: #selector(MovieArticleWebViewController.close(sender:)), for: .touchUpInside)
    view.addSubview(closeButton)

    articleWebView = UIWebView(frame: .zero)
    articleWebView.translatesAutoresizingMaskIntoConstraints = false
    articleWebView.backgroundColor = UIColor.white
    articleWebView.delegate = self
    articleWebView.scrollView.delegate = self
    view.addSubview(articleWebView)

    loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(loadingView)
    loadingView.isHidden = true

    let topView = UIView(backgroundColor: .white, translatesARMIC: false)
    view.addSubview(topView)

    view.visualConstraints(
      ["H:|[close(50)]", "H:|[webView]|", "V:[close(closeH)][webView]|", "H:|[topView]|", "V:|[topView(20)]"],
      metrics: ["closeH": closeHeight as NSNumber],
      views: ["close": closeButton, "webView": articleWebView, "topView": topView]
    )
    view.centerSubviews([loadingView])
    closeTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20)
    view.addConstraint(closeTopConstraint)

    articleWebView.loadRequest(URLRequest(url: url))
  }


  // MARK: Actions

  func close(sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  // MARK: Close UI

  func set(isCloseHidden: Bool, animated: Bool) {
    let c = closeTopConstraint?.constant ?? statusBarHeight
    if isCloseHidden != self.isCloseHidden && (c == closeDelta || c == statusBarHeight) {
      self.isCloseHidden = isCloseHidden
      UIView.animate(withDuration: 0.2, animations: {
        self.closeTopConstraint?.constant = (isCloseHidden ? self.closeDelta : statusBarHeight)
        self.view.layoutIfNeeded()
      })
    }
  }

}

// MARK: UIWebViewDelegate
extension MovieArticleWebViewController: UIWebViewDelegate {

  func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    loadingView.isHidden = false
    loadingView.startAnimating()
    return true
  }

  func webViewDidFinishLoad(_ webView: UIWebView) {
    loadingView.stopAnimating()
    loadingView.isHidden = true
  }

  func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    NSLog(error.localizedDescription)
    // should handle the error but for demo purposes will just ignore
    loadingView.stopAnimating()
    loadingView.isHidden = true
  }

}

// MARK: UIScrollViewDelegate
extension MovieArticleWebViewController: UIScrollViewDelegate {

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > lastScrollOffset && scrollView.contentOffset.y > 50 {
      set(isCloseHidden: true, animated: true)
    } else if scrollView.contentOffset.y < lastScrollOffset {
      set(isCloseHidden: false, animated: true)
    }
    lastScrollOffset = scrollView.contentOffset.y
  }

}
