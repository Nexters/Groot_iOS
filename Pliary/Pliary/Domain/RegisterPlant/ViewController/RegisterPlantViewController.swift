//
//  RegisterPlantViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 07/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import UserNotifications

class RegisterPlantViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    private var headerView: RegisterPlantHeaderView?
    private var headerOriginY: CGFloat = 0
    private var rows: [(String, RegisterRowType)] = []
    private var selectedPlant: Plant?
    
    private var englishNamePassed: Bool = true
    private var koreanNamePassed: Bool = true
    private var nickNamePassed: Bool = true
    
    @IBAction func tabCloseButton(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tabCompleteButton(_ sender: Any) {
        guard var plant = selectedPlant else {
            return
        }
        
        plant.nextWaterDate = plant.recalculateNextWaterDate()
        
        var plantArray = Global.shared.plants
        plantArray.append(plant)
        plantArray = plantArray.sorted(by: { $0.nextWaterDate < $1.nextWaterDate })
        Global.shared.plants = plantArray
        
        // Add watering record
        Global.shared.waterRecordDict[plant.id] = [plant.lastWaterDate.getMonth():[plant.lastWaterDate]]
        
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
        UserNotification.watering.registerNotification()
    }
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
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
        completeButton.isEnabled = false
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
        
        if let nameCell = cell as? RegisterPlantNameTableViewCell {
            nameCell.delegate = self
        }
        
        if let periodCell = cell as? RegisterPlantPeriodTableViewCell {
            periodCell.delegate = self
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
            
        case .selectDate(let type):
            let datePopup = DatePickerPopupView.instance(type: type)
            datePopup.frame = view.frame
            datePopup.delegate = self
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
            rows.append((RegisterPlantDateTableViewCell.identifier, .firstDate))
            rows.append((RegisterPlantDateTableViewCell.identifier, .lastWaterDate))
            rows.append((RegisterPlantPeriodTableViewCell.identifier, .period))
            
            tableView.reloadData()
            
        case .setEnglishName(let name, let enabled):
            selectedPlant?.englishName = name
            englishNamePassed = enabled
            
        case .setKoreanName(let name, let enabled):
            selectedPlant?.koreanName = name
            koreanNamePassed = enabled
            
        case .setNickName(let name, let enabled):
            selectedPlant?.nickName = name
            nickNamePassed = enabled
            
        case .setPeriod(let interval):
            selectedPlant?.wateringInterval = interval
            
        case .dateSelected(let type, let date):
            switch type {
            case .firstDate:
                selectedPlant?.firstDate = date
            case .lastWaterDate:
                selectedPlant?.lastWaterDate = date
                let dateStr = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
//                Global.shared.waterRecordDict
//                selectedPlant?. = dateStr
            default:
                ()
            }
            
            let offset = tableView.contentOffset
            tableView.reloadData()
            tableView.layoutIfNeeded()
            tableView.setContentOffset(offset, animated: false)
        }
        
        if checkPlantComplete() {
            completeButton.isEnabled = true
            completeButton.backgroundColor = Color.green
            completeButton.setTitleColor(.white, for: .normal)
        } else {
            completeButton.isEnabled = false
            completeButton.backgroundColor = Color.gray5
            completeButton.setTitleColor(.white, for: .normal)
        }
    }
    
    func checkPlantComplete() -> Bool {
        guard let plant = selectedPlant else {
            return false
        }
        
        guard plant.englishName != "" else {
            return false
        }
        
        guard plant.nickName != "" else {
            return false
        }
        
        guard plant.firstDate != 0 else {
            return false
        }
        
        guard plant.lastWaterDate != 0 else {
            return false
        }
        
        guard (englishNamePassed && koreanNamePassed && nickNamePassed) else {
            return false
        }
        
        return true
    }


}
