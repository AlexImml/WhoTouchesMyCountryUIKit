//
//  CountryTableCell.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 06/08/2021.
//

import UIKit

class CountryTableCell: UITableViewCell {
    
    // halper const
    private let missingText = "missing name"
    private let cornerRadius: CGFloat = 5

    @IBOutlet weak var labelsStack: UIStackView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var NativeNameLbl: UILabel!
    

    func setupCell(with country : Country) {
        nameLbl.text = "Name: \(country.name ?? missingText)"
        NativeNameLbl.text = "Native Name: \(country.nativeName ?? missingText)"
    }
}
