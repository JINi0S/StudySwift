//
//  StationSearchViewController.swift
//  Subway
//
//  Created by 이진희 on 2022/08/13.
//

import Alamofire
import UIKit
import SnapKit

class StationSearchViewController: UIViewController {
    private var stations: [Station] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItems()
        setTableLayout()
    }
    
    private func setNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "지하철 도착 정보"
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "지하철 역을 입력해주세요."
        searchController.obscuresBackgroundDuringPresentation = false

        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func setTableLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview()}
    }

     private func requestStationName(from stationName: String) {
        let urlString = "http://openapi.seoul.go.kr:8088/sample/json/SearchInfoBySubwayNameService/1/5/\(stationName)"
        AF
            .request(urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            .responseDecodable(of: StationResponseModel.self) { [weak self] response in
                guard
                    let self = self,
                    case .success(let data) = response.result
                else { return }
                print(data.stations)
                
                self.stations = data.stations
                self.tableView.reloadData()
        }.resume()
    }
}

extension StationSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.reloadData()
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        stations = []
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        requestStationName(from: searchText)
    }
}

extension StationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stations[indexPath.row]
        let vc = StationDetailViewController(station: station)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension StationSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let station = stations[indexPath.row]
        cell.textLabel?.text = station.stationName
        
        cell.detailTextLabel?.text = station.lineNumber
        return cell
    }
}

