//
//  TreeChartRenderer.swift
//  RenderTree
//
//  Created by David Rogers on 4/16/24.
//

import UIKit

class TreeChartRenderer {
  
  /// Renders a tree chart within a specified view, creating subviews where the area represents the value of the corresponding integer.
  /// - Parameters:
  ///   - parent: The parent view in which to render the tree chart.
  ///   - array: An array of integers where each integer represents the area of a subview.
  ///   - rect: The rectangle within the parent view where the tree chart should be rendered.
  static func renderTreeChartIn(_ parent: UIView, array: [Int], rect: CGRect) {
    guard !array.isEmpty else { return }
    
    let totalSum = array.reduce(0, +)
    partitionAndRender(in: parent, array: array, rect: rect, totalSum: totalSum)
  }
  
  /// Recursively partitions the array and renders the tree chart by creating subviews within the given rectangle.
  /// - Parameters:
  ///   - parent: The parent UIView in which subviews will be added.
  ///   - array: The current segment of the array being processed.
  ///   - rect: The current rectangle area where the subviews should be placed.
  ///   - totalSum: The total sum of the values in the current array segment.
  private static func partitionAndRender(in parent: UIView, array: [Int], rect: CGRect, totalSum: Int) {
    if array.count == 1 {
      let subView = createSubView(for: rect, color: .random())
      parent.addSubview(subView)
      return
    }
    
    let (firstGroup, secondGroup, firstGroupSum) = dynamicPartition(array: array) 
    let splitRatio = CGFloat(firstGroupSum) / CGFloat(totalSum)  // Calculate the split ratio based on sums
    
    let (firstRect, secondRect) = calculateRects(rect: rect, splitRatio: splitRatio, splitVertically: shouldSplitVertically(rect))
    
    // Recursively render the tree chart in the calculated rectangles
    partitionAndRender(in: parent, array: firstGroup, rect: firstRect, totalSum: firstGroupSum)
    partitionAndRender(in: parent, array: secondGroup, rect: secondRect, totalSum: totalSum - firstGroupSum)
  }
  
  /// Dynamically partitions the given array into two groups with approximately equal sums.
  /// - Parameter array: The array to partition.
  /// - Returns: A tuple containing the two groups and the sum of the first group.
  private static func dynamicPartition(array: [Int]) -> ([Int], [Int], Int) {
    var firstGroup: [Int] = []
    var secondGroup: [Int] = []
    var firstGroupSum = 0
    var secondGroupSum = 0
    
    for value in array {
      if firstGroupSum < secondGroupSum {
        firstGroup.append(value)
        firstGroupSum += value
      } else {
        secondGroup.append(value)
        secondGroupSum += value
      }
    }
    
    return (firstGroup, secondGroup, firstGroupSum)
  }
  
  /// Calculates the rectangles for the subviews based on the split ratio and orientation.
  /// - Parameters:
  ///   - rect: The current rectangle where the split is to occur.
  ///   - splitRatio: The ratio based on the sums of the groups.
  ///   - splitVertically: A flag indicating whether to split vertically or horizontally.
  /// - Returns: A tuple of two CGRects representing the areas for the subviews.
  private static func calculateRects(rect: CGRect, splitRatio: CGFloat, splitVertically: Bool) -> (CGRect, CGRect) {
    if splitVertically {
      let width = rect.width * splitRatio  // Calculate the width for the vertical split
      return (CGRect(x: rect.minX, y: rect.minY, width: width, height: rect.height),
              CGRect(x: rect.minX + width, y: rect.minY, width: rect.width - width, height: rect.height))
    } else {
      let height = rect.height * splitRatio  // Calculate the height for the horizontal split
      return (CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: height),
              CGRect(x: rect.minX, y: rect.minY + height, width: rect.width, height: rect.height - height))
    }
  }
  
  /// Determines whether to split the given rectangle vertically based on its aspect ratio.
  /// - Parameter rect: The rectangle to evaluate.
  /// - Returns: True if the rectangle should be split vertically, otherwise false.
  private static func shouldSplitVertically(_ rect: CGRect) -> Bool {
    return rect.width > rect.height
  }
  
  /// Creates a UIView with the specified rectangle and color.
  /// - Parameters:
  ///   - rect: The rectangle defining the frame of the UIView.
  ///   - color: The background color of the UIView.
  /// - Returns: A configured UIView.
  private static func createSubView(for rect: CGRect, color: UIColor) -> UIView {
    let subView = UIView(frame: rect)
    subView.backgroundColor = color
    return subView
  }
}
