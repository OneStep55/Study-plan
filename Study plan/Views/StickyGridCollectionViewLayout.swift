//
//  StickyGridCollectionViewLayout.swift
//  Study plan
//
//  Created by Самат Танкеев on 26.08.2023.
//

import UIKit

class StickyGridCollectionViewLayout: UICollectionViewLayout {
//
    var stickyRowsCount = 0 {
        didSet {
            invalidateLayout()
        }
    }

    var stickyColumnsCount = 0 {
        didSet {
            invalidateLayout()
        }
    }
    
    private var rowHeights: [CGFloat] = []
    



    private var rowsCount: Int {
        return collectionView!.numberOfSections
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func isItemSticky(at indexPath: IndexPath) -> Bool {
        return indexPath.item < stickyColumnsCount
    }

    private func columnsCount(in row: Int) -> Int {
        return collectionView!.numberOfItems(inSection: row)
    }

    private func size(forRow row: Int, column: Int) -> CGSize {
        guard let delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout,
            let size = delegate.collectionView?(collectionView!, layout: self, sizeForItemAt: IndexPath(row: row, column: column)) else {
            assertionFailure("Implement collectionView(_,layout:,sizeForItemAt: in UICollectionViewDelegateFlowLayout")
            return .zero
        }

        return size
    }
    
    private var allAttributes: [[UICollectionViewLayoutAttributes]] = []
    
    override var collectionViewContentSize: CGSize {
          

            var contentSize = CGSize.zero

            for (row, rowHeight) in rowHeights.enumerated() {
                var rowContentHeight: CGFloat = 0

                for col in 0..<columnsCount(in: row) {
                    let indexPath = IndexPath(row: row, column: col)
                    let cellSize = size(forRow: row, column: col)
                    rowContentHeight = max(rowContentHeight, cellSize.height)
                }

                contentSize.height += max(rowHeight, rowContentHeight)
            }

            contentSize.width = 450

            return contentSize
        }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for rowAttrs in allAttributes {
            for itemAttrs in rowAttrs where rect.intersects(itemAttrs.frame) {
                layoutAttributes.append(itemAttrs)
            }
        }
        
        return layoutAttributes
    }
    
    
    
    override func prepare() {
        setupAttributes()
        updateStickyItemsPositions()
        calculateRowHeights()
    }
    
    private func calculateRowHeights() {
           rowHeights.removeAll()

           for rowAttrs in allAttributes {
               guard let firstCellAttributes = rowAttrs.first else {
                   rowHeights.append(0)
                   continue
               }
               
               let firstCellSize = size(forRow: firstCellAttributes.indexPath.section, column: firstCellAttributes.indexPath.item)
               rowHeights.append(firstCellSize.height)
           }
       }

    private func setupAttributes() {
        // 1
        allAttributes = []

        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0

        // 2
        for row in 0..<rowsCount {
            // 3
            var rowAttrs: [UICollectionViewLayoutAttributes] = []
            xOffset = 0

            // 4
            for col in 0..<columnsCount(in: row) {
                // 5
                let itemSize = size(forRow: row, column: col)
                let indexPath = IndexPath(row: row, column: col)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height).integral

                rowAttrs.append(attributes)

                xOffset += itemSize.width
            }

            // 6
            yOffset += rowAttrs.last?.frame.height ?? 0.0
            allAttributes.append(rowAttrs)
        }
    }
    
    private func updateStickyItemsPositions() {
        // 2
        for row in 0..<rowsCount {
            for col in 0..<columnsCount(in: row) {
                // 3
                let attributes = allAttributes[row][col]

                if row < stickyRowsCount {
                    var frame = attributes.frame
                    frame.origin.y += collectionView!.contentOffset.y
                    attributes.frame = frame
                }

                if col < stickyColumnsCount {
                    var frame = attributes.frame
                    frame.origin.x += collectionView!.contentOffset.x
                    attributes.frame = frame
                }

                // 5
                attributes.zIndex = zIndex(forRow: row, column: col)
            }
        }
    }
    
    private func zIndex(forRow row: Int, column col: Int) -> Int {
      
        if col < stickyColumnsCount {
            return ZOrder.staticStickyItem
        } else {
            return ZOrder.commonItem
        }
    }

    // MARK: - ZOrder

    private enum ZOrder {
        static let commonItem = 0
        static let stickyItem = 1
        static let staticStickyItem = 2
    }
}

private extension IndexPath {
    init(row: Int, column: Int) {
        self = IndexPath(item: column, section: row)
    }
}


