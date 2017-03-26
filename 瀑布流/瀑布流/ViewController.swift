//
//  ViewController.swift
//  瀑布流
//
//  Created by 晓梦影 on 2017/3/26.
//  Copyright © 2017年 黄金星. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var itemCount = 30
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = JXWaterFallLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.dataSource = self
        layout.cols = 2
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI();
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController {
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
    
   
}



extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.contentView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0, green: CGFloat(arc4random_uniform(256)) / 255.0, blue: CGFloat(arc4random_uniform(256)) / 255.0, alpha: 1)
        
    
        
        return cell
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 上拉加载更多
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            itemCount += 30
            collectionView.reloadData()
        }
    }
}


extension ViewController : JXWaterFallLayoutDataSource{
    func waterFallLayoout(_ layout: JXWaterFallLayout, itemIndex: Int) -> CGFloat {
        
        let screenW = UIScreen.main.bounds.width
        return itemIndex % 2 == 0 ? screenW * 2 / 3 : screenW * 0.5
    }
}
