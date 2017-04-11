//
//  GalleryViewLayout.swift
//  buynothing
//
//  Created by Jake Romer on 4/11/17.
//  Copyright © 2017 Jake Romer. All rights reserved.
//

import UIKit

class GalleryViewLayout: UICollectionViewFlowLayout {
  var columns: Int
  let spacing: CGFloat = 1.0

  var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
  }

  var itemWidth: CGFloat {
    let cols = CGFloat(columns)
    let availableScreen = screenWidth - (cols * spacing)
    return availableScreen / cols
  }

  init(columns: Int = 3) {
    self.columns = columns

    super.init()
    self.minimumLineSpacing = spacing
    self.minimumInteritemSpacing = spacing
    self.itemSize = CGSize(width: itemWidth, height: itemWidth)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
