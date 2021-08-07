//
//  ContryListVM.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 04/08/2021.
//

import Foundation

class CountryListVM: ObservableObject {
    private var sortOption: SortPopUpOptions = .none
    private let countryProvider = CountryProvider()
    private var originalArray = [Country]()
    @Published var countriesArray = [Country]()
    @Published var errorString: String?
    
    init() {
        countryProvider.getAllCountries { result in
            switch result {
            case .failure(let error):
                self.errorString = error.localizedDescription
            case.success(let countriesArray):
                self.countriesArray = countriesArray
                self.originalArray = countriesArray
            }
        }
    }
    
    func buildCountryBorderVC(for index: IndexPath) -> CountryBorderListVC {
        let viewModel = CountryBorderListVM(countryList: countriesArray, selectedCountry: countriesArray[index.row])
        let vc = CountryBorderListVC(viewModel)
        return vc
    }
    
    func sortCountries(for sortOption: SortPopUpOptions) {
        if self.sortOption == sortOption { return }
        switch sortOption {
        case .none:
            self.countriesArray = originalArray
        case .nameAscending:
            self.countriesArray = originalArray.sorted { $0.name ?? "" > $1.name ?? "" }
        case .nameDescending:
            self.countriesArray = originalArray.sorted { $0.name ?? "" < $1.name ?? "" }
        case.sizeAscending:
            self.countriesArray = originalArray.sorted { $0.area ?? 0 > $1.area ?? 0 }
        case .sizeDescending:
            self.countriesArray = originalArray.sorted { $0.area ?? 0 < $1.area ?? 0 }
        }
    }
}
