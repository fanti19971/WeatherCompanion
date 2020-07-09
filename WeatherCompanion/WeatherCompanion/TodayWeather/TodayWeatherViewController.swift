//
//  ViewController.swift
//  WeatherCompanion
//
//  Created by Aleksandr  Babarikin  on 7/9/20.
//  Copyright © 2020 Aleksandr  Babarikin . All rights reserved.
//

import UIKit

class TodayWeatherViewController: UIViewController {

    @IBOutlet weak var todayWeatherTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let weatherInCitySearcher = UISearchController(searchResultsController: nil)
    
    let viewModel = TodayWeatherViewModel()
    var todayWeatherSections: [TodayWeatherSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.getTodayWeather()
    }
    
    private func bindViewModel() {
        viewModel.stateUpdated = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading(let loading):
                self.view.isUserInteractionEnabled = !loading
                loading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            case .todayWeatherReceived(let todayWeather):
                switch todayWeather {
                case .success(let weatherItems):
                    self.todayWeatherSections = weatherItems
                    self.todayWeatherTableView.reloadData()
                case .failure(let error):
                    let errorAlert = UIAlertController(title: "Ooops, no data available", message: "Please check your input or internet connection, error descr: \(error.localizedDescription)", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(errorAlert, animated: true)
                }
            }
        }
    }
    
    private func configureUI() {
        todayWeatherTableView.dataSource = self
        todayWeatherTableView.estimatedRowHeight = 10
        todayWeatherTableView.register(
            UINib(
                nibName: MainWeatherInfoTableViewCell.cellId(),
                  bundle: nil
            ), forCellReuseIdentifier: MainWeatherInfoTableViewCell.cellId()
        )
        todayWeatherTableView.register(
            UINib(
                nibName: TemperatureInfoTableViewCell.cellId(),
                  bundle: nil
            ), forCellReuseIdentifier: TemperatureInfoTableViewCell.cellId()
        )
        todayWeatherTableView.register(
            UINib(
                nibName: WindInfoTableViewCell.cellId(),
                  bundle: nil
            ), forCellReuseIdentifier: WindInfoTableViewCell.cellId()
        )
    
        weatherInCitySearcher.searchBar.delegate = self
        weatherInCitySearcher.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = weatherInCitySearcher
    }
}

extension TodayWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayWeatherSections[section].cells.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return todayWeatherSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return todayWeatherSections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = todayWeatherSections[indexPath.section].cells[indexPath.row]
        switch cellModel {
        case .main(let main):
            let cell = tableView.dequeueReusableCell(withIdentifier: MainWeatherInfoTableViewCell.cellId(), for: indexPath)
            guard let mainWeatherCell = cell as? MainWeatherInfoTableViewCell else {
                return cell
            }
            mainWeatherCell.fillUI(with: main)
            return mainWeatherCell
        case .temperature(let temperature):
            let cell = tableView.dequeueReusableCell(withIdentifier: TemperatureInfoTableViewCell.cellId(), for: indexPath)
            guard let temperatureInfoCell = cell as? TemperatureInfoTableViewCell else {
                return cell
            }
            temperatureInfoCell.fillUI(with: temperature)
            return temperatureInfoCell
        case .wind(let wind):
            let cell = tableView.dequeueReusableCell(withIdentifier: WindInfoTableViewCell.cellId(), for: indexPath)
            guard let windInfoCell = cell as? WindInfoTableViewCell else {
                return cell
            }
            windInfoCell.fillUI(with: wind)
            return windInfoCell
        }
    }
}


extension TodayWeatherViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text else { return }
        viewModel.searchTodayWeather(for: city)
    }
}
