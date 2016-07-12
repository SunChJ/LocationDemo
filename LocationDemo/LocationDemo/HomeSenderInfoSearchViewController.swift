//
//  HomeSenderInfoSearchViewController.swift
//  WindThunder
//
//  Created by 孙超杰 on 16/7/4.
//  Copyright © 2016年 Gezbox Inc. All rights reserved.
//

import Foundation

class HomeSenderInfoSearchViewController: BaseViewController{
    
    private var searchController: UISearchController!
    private var searchKey = ""
    private var tableView: MWDTableView!
    private var pageMenu: PageMenu?
    //  百度SDK所需成员
    private var mapView: BMKMapView?
    private var locService: BMKLocationService?
    private var geoSearch: BMKGeoCodeSearch?
    private var poiSearch: BMKPoiSearch?
    private let annotation = BMKPointAnnotation()
    private var loc = CLLocationCoordinate2D()
    private var isFirst = true
    
    private var maskView: HomeSearchNoResultView?
    
    private var VCArrary = [HomeSenderInfoTableViewController]()
    
    private var poiDataArr = [AnyObject]()
    
    private var shouldShowTableView = false {
        willSet {
            tableView.hidden = !newValue
            mapView?.hidden = newValue
            pageMenu?.view.hidden = newValue
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instance = SenderOrderModel.sharedInstance
        self.searchKey = instance.getAddressName() ?? ""
        self.loc = instance.getLoc()
        
        maskView = HomeSearchNoResultView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        maskView?.setText("请输入正确地址")
        
        setMapView()
        startLocServer()
        setPoiSearch()
        setGeoSearch()

        buildSearchController()
        setSearchBar()
        
        buildTable()
        addPinIconImage()
        buildPageMenu()
        
        shouldShowTableView = (searchKey != "")
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        stopLocServer()
        stopPoiSearch()
        stopGeoSearch()
        stopMapView()
        
        searchController.searchBar.removeFromSuperview()
//        navigationItem.title = nil
    }
    
    private func addPinIconImage() {
        let pinIconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        pinIconImageView.image = UIImage(named: "map_pin")
        pinIconImageView.contentMode = .ScaleAspectFill
        pinIconImageView.center = mapView!.center
        mapView?.addSubview(pinIconImageView)
    }
    
    
    
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
//    func setData(data: BMKPoiInfo) {
//        
//        self.searchKey = data.name
//        self.loc = data.pt
//        
//    }
}


extension HomeSenderInfoSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func buildTable() {
        tableView = MWDTableView(frame: ScreenBoundsWithNav)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        view.addSubview(tableView)
        tableView.hidden = true
        tableView.keyboardDismissMode = .OnDrag
//        tableView
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poiDataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard poiDataArr.count != 0 else { return UITableViewCell()}
        let index = indexPath.row
        let info = poiDataArr[index] as! BMKPoiInfo
        let addr = info.address
        let name = info.name
        let isShowIcon = (index == 0)
        let isShowLine = (index < (poiDataArr.count - 1))
        
        let cell = HomeSenderInfoTableCell.cellFor(tableView,address: addr,name: name,isShowIcon: isShowIcon, isShowLine: isShowLine)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let index = indexPath.row
        let data = poiDataArr[index] as! BMKPoiInfo
        let locale = [data.pt.longitude, data.pt.latitude]
        print("[locale: \(locale)]")
        
        let instance = SenderOrderModel.sharedInstance
        instance.setLocation(data.pt.longitude, lat: data.pt.latitude)
        self.navigationController?.popViewControllerAnimated(true)
        NSNotificationCenter.defaultCenter().postNotificationName(AppNotifications.HomeSenderInfoSearchResultTableCellClick, object: data)

    }
}

//  MARK: - 配置SearchController
extension HomeSenderInfoSearchViewController: UISearchControllerDelegate {
    
    private func buildSearchController(){
        //        let searchResultsVC = HomeSenderInfoSearchResultController()
        //
        //        searchResultsVC.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        
    }

    
    func willPresentSearchController(searchController: UISearchController) {
        
    }
    
}

//  MARK: - 配置SearchBar
extension HomeSenderInfoSearchViewController: UISearchBarDelegate {
    
    private func setSearchBar() {
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: ScreenWidth * 300 / 375, height: 44)
        searchController.searchBar.delegate = self
        
        searchController.searchBar.barTintColor = MWDLineColor
        searchController.searchBar.searchBarStyle = .Default
        searchController.searchBar.translucent = false
        
        searchController.searchBar.sizeToFit()
        searchController.searchBar.setValue("取消", forKey: "_cancelButtonText")
//        searchController.searchBar.spellCheckingType = .Yes
        searchController.searchBar.text = searchKey
//        if searchKey.characters.count > 0 {
//            searchController.searchResultsController?.view.hidden = false
//        }
        
        searchController.searchBar.placeholder = "小区/写字楼/学校等"
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.backgroundImage = UIImage()   //去掉灰色边框
        searchController.searchBar.backgroundColor = UIColor.clearColor()
        
        let text = searchController.searchBar.text ?? ""
        if text != "" {
            searchController.searchBar.setShowsCancelButton(true, animated: true)
        }
        
        navigationItem.titleView = searchController.searchBar
    }
    

    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        poiDataArr.removeAll()
        tableView.reloadData()
        shouldShowTableView = true
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        let status = self.mapView!.getMapStatus()
        let geo = BMKReverseGeoCodeOption()
        geo.reverseGeoPoint = status.targetGeoPt
        geoSearch?.reverseGeoCode(geo)
        shouldShowTableView = false
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            poiDataArr.removeAll()
            tableView.reloadData()
        }
    }
    

}

extension HomeSenderInfoSearchViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let key = searchController.searchBar.text ?? ""
//        guard key != "" else { return }
        poiDataArr.removeAll()
        startPoiSearch(key)
    }
}

//  MARK: - 配置 百度MapView
extension HomeSenderInfoSearchViewController: BMKMapViewDelegate {
    
    private func setMapView() {
        
        mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 300))
        mapView?.delegate = self
        mapView?.showsUserLocation = false
        
        // zoomLevel 3最大俯视高度 21最小俯视高度
        mapView?.zoomLevel = 18
        view.addSubview(mapView!)
    }
    
    private func stopMapView() {
        mapView?.viewWillDisappear()
        mapView?.delegate = nil
        mapView = nil
    }

    
    func mapStatusDidChanged(mapView: BMKMapView!) {
        let status = mapView.getMapStatus()
        let geo = BMKReverseGeoCodeOption()
        geo.reverseGeoPoint = status.targetGeoPt
        geoSearch?.reverseGeoCode(geo)
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation.isKindOfClass(BMKPointAnnotation.classForCoder()) {
            let newAnnotaionView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
            newAnnotaionView.image = UIImage(named: "map_point")
            newAnnotaionView.animatesDrop = true
            newAnnotaionView.draggable = true
            return newAnnotaionView
        }
        return nil
    }
}

// MARK: - 配置 百度Location


extension HomeSenderInfoSearchViewController: BMKLocationServiceDelegate {
    
    private func startLocServer() {
        locService = BMKLocationService()
        locService!.delegate = self
        locService!.desiredAccuracy = kCLLocationAccuracyBest
        locService!.distanceFilter = 10
        locService!.startUserLocationService()
        
    }
    
    private func stopLocServer() {
        locService?.stopUserLocationService()
        locService?.delegate = nil
        locService = nil
    }
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
//        print(userLocation.location)
//        print(mapView == nil ? "nil" : "not nil")
        
        
        if mapView?.annotations.count == 0 {
            mapView?.centerCoordinate = userLocation.location.coordinate
            annotation.coordinate = userLocation.location.coordinate
            mapView?.addAnnotation(annotation)
            
        }
        self.loc = userLocation.location.coordinate
        mapView?.updateLocationData(userLocation)
    }
}

// MARK: - 配置 百度GeoSearch
extension HomeSenderInfoSearchViewController: BMKGeoCodeSearchDelegate {
    
    private func setGeoSearch() {
        geoSearch = BMKGeoCodeSearch()
        geoSearch!.delegate = self
    }
    
    private func stopGeoSearch() {
        geoSearch?.delegate = self
        geoSearch = nil
    }
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {

            let index = pageMenu!.currentPageIndex
            VCArrary[index].dataArr = result.poiList
            if index != 0 {
                let searchOption = BMKNearbySearchOption()
                let status = mapView!.getMapStatus()
                searchOption.location = status.targetGeoPt
                searchOption.keyword = VCArrary[index].title
                poiSearch!.poiSearchNearBy(searchOption)
            }
        }
    }
}

// MARK: - 配置 百度POI
extension HomeSenderInfoSearchViewController: BMKPoiSearchDelegate {
    
    
    private func setPoiSearch() {
        poiSearch = BMKPoiSearch()
        poiSearch?.delegate = self
    }
    
    private func stopPoiSearch() {
        poiSearch?.delegate = nil
        poiSearch = nil
    }
    
    private func startPoiSearch(key: String) {
        let option = BMKNearbySearchOption()
        
        
        let coordinate = isFirst ? self.loc : locService!.userLocation.location.coordinate
        isFirst = false
        option.location = coordinate
        option.keyword = key
        
        poiSearch!.poiSearchNearBy(option)

        
    }
    
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode == BMK_SEARCH_NO_ERROR {
            let arr: [AnyObject] = poiResult.poiInfoList
            VCArrary[pageMenu!.currentPageIndex].dataArr = arr
            
            poiDataArr.removeAll()
            poiDataArr.appendContentsOf(poiResult.poiInfoList)
            tableView.reloadData()
            
            //            vc.dataArr = arr
        } else {
            poiDataArr.removeAll()
            VCArrary[pageMenu!.currentPageIndex].dataArr = []
        }
        if poiDataArr.count == 0 {
            tableView.tableHeaderView = maskView
        } else {
            tableView.tableHeaderView = nil
        }
        
    }
}

// MARK: - 配置PageMenu
extension HomeSenderInfoSearchViewController: PageMenuDelegate {
    
    private func buildPageMenu() {
        
        
        let allVC = HomeSenderInfoTableViewController()
        allVC.title = "全部"
        let housingVC = HomeSenderInfoTableViewController()
        housingVC.title = "小区"
        let officeVC = HomeSenderInfoTableViewController()
        officeVC.title = "写字楼"
        let schoolVC = HomeSenderInfoTableViewController()
        schoolVC.title = "学校"
        
        VCArrary.append(allVC)
        VCArrary.append(housingVC)
        VCArrary.append(officeVC)
        VCArrary.append(schoolVC)
        
        let parameters: [PageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(MWDGlobalBackgroundColor),
            .SelectionIndicatorColor(MWDButtonBackColor),
            //            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont.systemFontOfSize(16)),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true),
            .MenuMargin(5),
            .SelectedMenuItemLabelColor(MWDButtonBackColor),
            .UnselectedMenuItemLabelColor(MWDTextGreyXXColor)]
        pageMenu = PageMenu(viewControllers: VCArrary, frame: CGRect(x: 0, y: 300, width: ScreenWidth, height: ScreenHeight - 300), pageMenuOptions: parameters)
        pageMenu?.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
    }
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        guard index != 0 else { return }
        
        let searchOption = BMKNearbySearchOption()
        let status = mapView!.getMapStatus()
        searchOption.location = status.targetGeoPt
        searchOption.keyword = controller.title
        poiSearch!.poiSearchNearBy(searchOption)
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {

    }
}


