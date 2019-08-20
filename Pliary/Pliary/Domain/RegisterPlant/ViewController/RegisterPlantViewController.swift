//
//  RegisterPlantViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class RegisterPlantViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    private var headerView: RegisterPlantHeaderView?
    private var headerOriginY: CGFloat = 0
    private var rows: [(String, RegisterRowType)] = []
    private var selectedPlant: Plant?
    
    @IBAction func tabCloseButton(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let registerLabelNib = UINib(nibName: RegisterPlantLabelTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerLabelNib, forCellReuseIdentifier: RegisterPlantLabelTableViewCell.reuseIdentifier)
        
        let registerNameNib = UINib(nibName: RegisterPlantNameTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerNameNib, forCellReuseIdentifier: RegisterPlantNameTableViewCell.reuseIdentifier)
        
        let registerImageNib = UINib(nibName: RegisterPlantImageTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerImageNib, forCellReuseIdentifier: RegisterPlantImageTableViewCell.reuseIdentifier)
        
        let registerDateNib = UINib(nibName: RegisterPlantDateTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerDateNib, forCellReuseIdentifier: RegisterPlantDateTableViewCell.reuseIdentifier)
        
        let registerPeriodNib = UINib(nibName: RegisterPlantPeriodTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerPeriodNib, forCellReuseIdentifier: RegisterPlantPeriodTableViewCell.reuseIdentifier)
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        tableView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc func endEdit(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

extension RegisterPlantViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        completeButton.clipsToBounds = true
        completeButton.layer.cornerRadius = 6
    }
}

extension RegisterPlantViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return RegisterPlantHeaderView.height
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if headerOriginY == 0, let minY = headerView?.frame.minY {
            headerOriginY = minY
        }
        
        if headerView?.frame.minY != headerOriginY {
            headerView?.headerFixed(bool: true)
        } else {
            headerView?.headerFixed(bool: false)
        }
    }
}

extension RegisterPlantViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = RegisterPlantHeaderView.instance()
            headerView.delegate = self
            
            if let plant = selectedPlant {
                if plant.type == .userPlants {
                    headerView.plantNameLabel.text = "Your plant"
                    headerView.plantNameLabel.textColor = Color.gray1
                } else {
                    headerView.plantNameLabel.text = plant.englishName
                    headerView.plantNameLabel.textColor = Color.gray1
                }
            }
            
            self.headerView = headerView
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: RegisterPlantLabelTableViewCell.identifier) as? RegisterPlantLabelTableViewCell {
            return cell
        }
        
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.0)
        
        if let typeCell = cell as? RegisterCell, let plant = selectedPlant {
            typeCell.setUp(with: plant, type: row.1)
        }
        
        if let dateCell = cell as? RegisterPlantDateTableViewCell {
            dateCell.delegate = self
        }
        
        return cell ?? UITableViewCell()
    }
    
}

extension RegisterPlantViewController: RegisterEventDelegate {
    func registerEvent(event: RegisterEvent) {
        switch event {
        case .selectPlant:
            let selectPlantPopup = SelectPlantPopupView.instance()
            selectPlantPopup.frame = view.frame
            selectPlantPopup.delegate = self
            selectPlantPopup.currentPlant = selectedPlant
            view.addSubview(selectPlantPopup)
            
        case .selectDate:
            let datePopup = DatePickerPopupView.instance()
            datePopup.frame = view.frame
            view.addSubview(datePopup)
            
        case .plantSelected(let selectedPlant):
            self.selectedPlant = selectedPlant
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            tableView.isScrollEnabled = true
            
            rows = []
            
            if selectedPlant.type == .userPlants {
                // Custom plant (영어이름 / 한글이름 설정 추가)
                rows.append((RegisterPlantNameTableViewCell.identifier, .englishName))
                rows.append((RegisterPlantNameTableViewCell.identifier, .koreanName))
            }
            
            rows.append((RegisterPlantImageTableViewCell.identifier, .image))
            rows.append((RegisterPlantNameTableViewCell.identifier, .customName))
            rows.append((RegisterPlantDateTableViewCell.identifier, .startDate))
            rows.append((RegisterPlantDateTableViewCell.identifier, .lastWaterDate))
            rows.append((RegisterPlantPeriodTableViewCell.identifier, .period))
            
            tableView.reloadData()
            
        case .setEnglishName(let name):
            selectedPlant?.englishName = name
            
        case .setKoreanName(let name):
            selectedPlant?.koreanName = name
            
        case .setNickName(let name):
            selectedPlant?.nickName = name
            
        case .setPeriod(let interval):
            selectedPlant?.wateringInterval = interval
        }
    }
    
}
