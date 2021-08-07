//
//  ViewController.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 05/08/2021.
//

import UIKit
import Combine

class CountryListVC: UIViewController {
    
    // MARK: UI
    private let tablePadding: CGFloat = 10
    private let navTitle = "Country List"
    
    private lazy var tableView  : UITableView = {
        let table               = UITableView()
        table.backgroundColor   = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate          = self
        table.separatorStyle    = .none
        table.dataSource        = dataSource
        table.register(CountryTableCell.self,
                       forCellReuseIdentifier: CountryTableCell.description())
        let cellName            = String(describing: CountryTableCell.self)
        table.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellName)
        return table
    }()
    
    private var sortPopUp: SortPopUpView?
    
    // MARK: variables
    private let countryListVM = CountryListVM()
    private var bindings = Set<AnyCancellable>()
    private var dataSource : TableDataSource<CountryTableCell, Country>?
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        setupNavigation()
        addViews()
        bindViewModel()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: setup funcs
    
    private func setupNavigation() {
        title = navTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: ImageConstants.arrowUpArrowDown),
            style: .plain,
            target: self,
            action: #selector(sortClicked(sender:)))
    }
    
    
    private func bindViewModel() {
        countryListVM.$countriesArray.sink { [weak self] countryArr in
            guard let self = self else { return }
            self.dataSource?.update(items: countryArr)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &bindings)
    }
    
    
    private func setupDataSource() {
        dataSource = TableDataSource(configureCell: { (cell, item) in
            cell.setupCell(with: item)
        })
    }
    
    private func createSortPopUp() {
        sortPopUp = SortPopUpView()
        sortPopUp?.onBtnClicked = { [weak self] sortOption in
            self?.countryListVM.sortCountries(for: sortOption)
            self?.removePopUp()
        }
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: tablePadding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tablePadding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tablePadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -tablePadding),
        ])
    }
    //    MARK: Actions
    
    @objc private func sortClicked(sender:UIView){
        if sortPopUp == nil { createSortPopUp() } // create pop up only when needed
        
        if sortPopUp!.superview != nil {
            removePopUp()
            return
        }
        addSortPopUp()
    }
    

    
    //    MARK: helper funcs
    
    private func addSortPopUp() {
        view.addSubview(sortPopUp!)

        NSLayoutConstraint.activate([
            sortPopUp!.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            sortPopUp!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        sortPopUp!.popIn()
    }
    
    private func removePopUp() {
        sortPopUp!.popOut() { [weak self] _ in // [weak self] not necessary but just in case
            self?.sortPopUp?.removeFromSuperview()
        }
    }
}



// MARK: UITableView Delegate

extension CountryListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.countryListVM.buildCountryBorderVC(for: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}

