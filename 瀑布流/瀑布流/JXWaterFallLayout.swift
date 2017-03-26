//
//  JXWaterFallLayout.swift
//  瀑布流
//
//  Created by 晓梦影 on 2017/3/26.
//  Copyright © 2017年 黄金星. All rights reserved.
//

import UIKit

//  MARK: - 数据源
protocol JXWaterFallLayoutDataSource : class{
    
    func waterFallLayoout(_ layout : JXWaterFallLayout, itemIndex : Int) -> CGFloat
}



class JXWaterFallLayout: UICollectionViewFlowLayout {

    // 列数
    var cols = 2 // 默认两列

    weak var dataSource : JXWaterFallLayoutDataSource?
    
    fileprivate lazy var attributes:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var maxHeight : CGFloat = self.sectionInset.top + self.sectionInset.bottom
    
    fileprivate lazy var heights :[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}

//  MARK: - 准备所有cell的布局
extension JXWaterFallLayout{
    
    override func prepare() {
        super.prepare()
        
        
        // 1.校验collectionView有没有值
        guard let collectionView = collectionView else {
            return
        }
        
        // 2.获取cell的个数
        let count = collectionView.numberOfItems(inSection: 0)
        
        // 3.计算cell的位置
        
        
        let itemW = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)

        
        
        for  i in attributes.count..<count {
         
            // 3.1创建 UICollectionViewLayoutAttributes 并且传入indexpath
            
            let indexpath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexpath)

            // 3.2 给UICollectionViewLayoutAttributes设置frame
            guard  let itemH  = dataSource?.waterFallLayoout(self, itemIndex: i) else {
                fatalError("请设置数据源，再使用我的waterFallLayoout")
            }
            
            // 如果没有值就是100
//           let itemH  = dataSource?.waterFallLayoout(self, itemIndex: i) ?? 100
            
            let minH = heights.min()!
            let minIndex = heights.index(of: minH)!
            
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(minIndex)
            
            let itemY = minH
            
            
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            

            // 3.3 将Attribute添加到数组
            attributes.append(attribute)
            
            // 3.4 改变minindex的高度
            heights[minIndex] = attribute.frame.maxY + minimumLineSpacing
        }
        
        
        // 4.获取最大高度
        maxHeight = heights.max()!
        
    }

    
}

//  MARK: - 告诉系统准备好的布局
extension JXWaterFallLayout{
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

//  MARK: - 告诉系统滚动范围
extension JXWaterFallLayout{
    override var collectionViewContentSize: CGSize{

        return CGSize(width:0,height:maxHeight)
    }
    
}



