//
//  SortPopUp.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 05/08/2021.
//

import UIKit


// I tried to do a separate data source but picker delegates are wired
class SortPopUpView: UIView {
    
    // halper const
    private let titleText = "Sort by"
    private let btnText = "OK"
    
    // MARK: variables
    var onBtnClicked: ((SortPopUpOptions) -> Void)?
    private var padding: CGFloat = 10
    
    // MARK: Views
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        lbl.text = titleText
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .largeTitle)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var okBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(btnText, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        return btn
    }()
    
    // MARK: life Cycle
    
    init() {
        super.init(frame: .zero)
        setupSelf()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func setupSelf() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1).cgColor
    }
    
    
    
    private func addViews() {
        addSubview(title)
        addSubview(picker)
        addSubview(okBtn)
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            picker.topAnchor.constraint(equalTo: title.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            picker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            okBtn.topAnchor.constraint(equalTo: picker.bottomAnchor),
            okBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            okBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            okBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
        ])
    }
    
    @objc private func btnClicked() {
        let index = picker.selectedRow(inComponent: 0)
        onBtnClicked?(SortPopUpOptions.allCases[index])
    }
    
}

// MARK: UIPicker View Delegate

extension SortPopUpView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        SortPopUpOptions.allCases[row].view
    }
    
}


// MARK: UIPicker View DataSource

extension SortPopUpView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        SortPopUpOptions.allCases.count
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    
}
