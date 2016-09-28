//
//  DetailPicturesFlowLayout.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/24.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class DetailPicturesFlowLayout: UICollectionViewFlowLayout {
    var colHeight : CGFloat = 0 ;
    var layoutInformationDictionary = [NSIndexPath : String]() ;
    override func prepareLayout() {
        let cellCount = self.collectionView!.numberOfItemsInSection(0) ;
        for itemNumber in 0 ..< cellCount {
            self.layoutConfiguration(NSIndexPath(forItem: itemNumber , inSection: 0)) ;
        }
    }
    func layoutConfiguration(indexPathX : NSIndexPath) {
        let delegateX = self.collectionView!.delegate as! UICollectionViewDelegateFlowLayout ;
        let cellSize = delegateX.collectionView!(self.collectionView!, layout: self, sizeForItemAtIndexPath: indexPathX) ;
        let cellFrame = CGRectMake(0, self.colHeight, ToolsX.screenWidth, cellSize.height) ;
        self.layoutInformationDictionary[indexPathX] = NSStringFromCGRect(cellFrame) ;
        self.colHeight += cellFrame.height ;
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var tmpArr = [UICollectionViewLayoutAttributes]() ;
        let indeXPathArray = self.rangeBetweenViewFrameAndCell(rect) ;
        for indeXPathZ in indeXPathArray {
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indeXPathZ) ;
            attributes.frame = CGRectFromString(self.layoutInformationDictionary[indeXPathZ]!) ;
            tmpArr.append(attributes) ;
        }
        return tmpArr ;
    }
    func rangeBetweenViewFrameAndCell(rect : CGRect) -> [NSIndexPath] {
        var tmpArray = [NSIndexPath]() ;
        for (key , value) in self.layoutInformationDictionary {
            let viewFrame = CGRectFromString(value) ;
            if viewFrame.intersects(rect) {
                tmpArray.append(key) ;
            }
        }
        return tmpArray ;
    }
    override func collectionViewContentSize() -> CGSize {
        var contentSizeX = self.collectionView!.bounds.size ;
        contentSizeX.height = self.colHeight ;
        return contentSizeX ;
    }
}
