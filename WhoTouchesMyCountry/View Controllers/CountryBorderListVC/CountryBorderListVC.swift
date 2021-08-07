//
//  qwe.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 05/08/2021.
//

import UIKit
import Combine

class CountryBorderListVC: UIViewController {
    
    // halper const
    private let viewsPadding: CGFloat = 10
    private let noCellsText = "No one !"
    
    // MARK: UI
    
    
    private lazy var titleLbl: UILabel = {
        let lbl             = UILabel()
        lbl.text            = "Who touches \(countryBorderListVM.selectedCountry.name ?? "unknown") borders ?!"
        lbl.font            = .preferredFont(forTextStyle: .largeTitle)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment   = .center
        lbl.numberOfLines   = 0
        return lbl
    }()
    
    private lazy var tableView  : UITableView = {
        let table               = UITableView()
        table.backgroundColor   = .white
        table.separatorStyle    = .none
        table.backgroundView    = tableViewBackgroundView
        table.dataSource        = dataSource
        table.backgroundView?.isHidden = false
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CountryTableCell.self,
                       forCellReuseIdentifier: CountryTableCell.description())
        let cellName            = String(describing: CountryTableCell.self)
        table.register(
            UINib(nibName: cellName, bundle: nil),
            forCellReuseIdentifier: cellName)
        return table
    }()
    
    private lazy var tableViewBackgroundView: UIView = {
        let lbl = UILabel()
        lbl.text = noCellsText
        lbl.font = .preferredFont(forTextStyle: .largeTitle)
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: variables
    
    private var countryBorderListVM: CountryBorderListVM
    private var bindings = Set<AnyCancellable>()
    private var dataSource : TableDataSource<CountryTableCell, Country>?
    
    
    
    // MARK: life cycle
    
    init(_ countryBorderListVM :CountryBorderListVM) {
        self.countryBorderListVM = countryBorderListVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataSource()
        addViews()
        bindViewModel()
        addConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: setup funcs
    
    private func setupDataSource() {
        dataSource = TableDataSource(configureCell: { (cell, item) in
            cell.setupCell(with: item)
        })
    }

    private func addViews() {
        view.addSubview(titleLbl)
        view.addSubview(tableView)
    }
    
    private func bindViewModel() {
        countryBorderListVM.$filteredCountries.sink { [weak self] countryArr in
            guard let self = self else { return }
            self.dataSource?.update(items: countryArr)
            DispatchQueue.main.async {
                if !countryArr.isEmpty {
                    self.tableView.backgroundView?.isHidden = true
                }
                self.tableView.reloadData()
                
            }
        }.store(in: &bindings)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: viewsPadding),
            titleLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewsPadding),
            titleLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewsPadding),
            
            
            tableView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: viewsPadding),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -viewsPadding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: viewsPadding),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -viewsPadding),
        ])
    }


}

