//
//  ViewController.swift
//  RenderTree
//
//  Created by David Rogers on 4/16/24.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    TreeChartRenderer.renderTreeChartIn(view, array: [3, 10, 15, 20, 25, 30, 12, 21, 7, 5, 14, 18, 42], rect: view.bounds)
  }
}
