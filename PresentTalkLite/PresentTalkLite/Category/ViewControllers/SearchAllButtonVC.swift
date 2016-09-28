//
//  SearchAllButtonVC.swift
//  PresentTalkLite
//
//  Created by qianfeng on 2016/09/27.
//  Copyright © 2016年 NXT. All rights reserved.
//

import UIKit

class SearchAllButtonVC: UIViewController {
    private var dataArrayX = [allCategoriesTableViewCellModel]() ;
    @IBOutlet weak var tableViewX: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareDataForPage() ;
        self.settingUpUI() ;
    }
    private func settingUpUI() {
        self.navigationItem.title = "全部专题" ;
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()] ;
        let nibX = UINib(nibName: "CSLPVCTableViewCell", bundle: nil) ;
        self.tableViewX.registerNib(nibX, forCellReuseIdentifier: "CSLPVCTableViewCell") ;
        self.tableViewX.rowHeight = 184 ;
        self.tableViewX.delegate = self ;
        self.tableViewX.dataSource = self ;
        self.tableViewX.header = MJRefreshNormalHeader(refreshingBlock: { 
            pageNumber = 0 ;
            self.dataArrayX.removeAll() ;
            self.prepareDataForPage() ;
        }) ;
        self.tableViewX.footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            pageNumber += 20 ;
            self.prepareDataForPage() ;
        }) ;
    }
    
    private func prepareDataForPage() {
        HDManager.startLoading() ;
        allCategoriesTableViewCellModel.requestAllSearchPageData(pageNumber) { (dataArray, error) in
            if error == nil {
                self.dataArrayX.appendContentsOf(dataArray!) ;
                self.stopLoading() ;
            }
            else
            {
                print(error!) ;
                self.stopLoading() ;
            }
        }
    }
    private func stopLoading() {
        self.tableViewX.reloadData() ;
        HDManager.stopLoading() ;
        self.tableViewX.header.endRefreshing() ;
        self.tableViewX.footer.endRefreshing() ;
    }
}
extension SearchAllButtonVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArrayX.count ;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true) ;
        let modelY = self.dataArrayX[indexPath.row] ;
        TableViewCellModel.requestCollectionCellsData(modelY.id) { (title, dataArray, error) in
            if error == nil {
                let dcVC = DetialCollection() ;
                let mutableArr = NSMutableArray(array: dataArray!) ;
                dcVC.dataArrayX = mutableArr ;
                dcVC.title = title! ;
                self.navigationController?.pushViewController(dcVC, animated: true) ;
            }
            else
            {
                print(error!) ;
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellX = tableView.dequeueReusableCellWithIdentifier("CSLPVCTableViewCell", forIndexPath: indexPath) as! CSLPVCTableViewCell ;
        if cellX.contentView.subviews.last == cellX.contentView.subviews.last!.viewWithTag(678) {
            cellX.contentView.subviews.last?.removeFromSuperview() ;
        }
        let modelX = self.dataArrayX[indexPath.row] ;
        cellX.backImageViewX.sd_setImageWithURL(NSURL(string: modelX.coverImageUrl), placeholderImage: UIImage(named: "image_placeholder")) ;
        cellX.subTitleLabelX.text = modelX.subtitle ;
        cellX.titleLabelX.text = modelX.title ;
        let subtitleWidth = ToolsX.calculateStringBounds(modelX.subtitle, strAreaSize: CGSizeMake(ToolsX.screenWidth - 20 , cellX.subTitleLabelX.bounds.height), strFont: cellX.subTitleLabelX.font).width ;
        let viewSubX = UIView(frame: CGRectMake((ToolsX.screenWidth - 20 - subtitleWidth) / 2, cellX.bounds.height / 2 - 1, subtitleWidth + 20 , 2)) ;
        viewSubX.tag = 678 ;
        viewSubX.layer.borderWidth = 1 ;
        viewSubX.layer.borderColor = UIColor.lightGrayColor().CGColor ;
        cellX.contentView.addSubview(viewSubX) ;
        return cellX ;
    }
}
