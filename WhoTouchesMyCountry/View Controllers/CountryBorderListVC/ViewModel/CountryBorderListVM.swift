//
//  CountryBorderListVM.swift
//  WhoTouchesMyCountrySUI
//
//  Created by Alex on 05/08/2021.
//

import Foundation


class CountryBorderListVM: ObservableObject {
    
    
    var selectedCountry: Country
    @Published var filteredCountries = [Country]()

    
    init(countryList: [Country], selectedCountry: Country) {
        self.selectedCountry = selectedCountry
        filterCountries(in: countryList, for: selectedCountry)
    }
    
    
    
    private func filterCountries(in countryList: [Country], for selectedCountry: Country) {
        DispatchQueue.global().async { // to make UI run easier
            var filteredCountries = [Country]()
            var selectedCountryBorders = Set(selectedCountry.borders) //it easier to remove from set (no need for index)
            for country in countryList {
                if selectedCountryBorders.contains(country.cioc) {
                    filteredCountries.append(country)
                    selectedCountryBorders.remove(country.cioc)
                    if selectedCountryBorders.isEmpty { break }
                }
            }
            DispatchQueue.main.async {
                self.filteredCountries = filteredCountries
            }
        }
    }
}
