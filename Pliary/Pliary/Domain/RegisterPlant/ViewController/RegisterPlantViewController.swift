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
    
    private var headerView: RegisterPlantHeaderView?
    private var rows: [String] = []
    
    @IBAction func tabCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let registerLabelNib = UINib(nibName: RegisterPlantLabelTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(registerLabelNib, forCellReuseIdentifier: RegisterPlantLabelTableViewCell.reuseIdentifier)
    }

}

extension RegisterPlantViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
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
            self.headerView = headerView
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0, let cell = tableView.dequeueReusableCell(withIdentifier: RegisterPlantLabelTableViewCell.identifier) as? RegisterPlantLabelTableViewCell {
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension RegisterPlantViewController: RegisterEventDelegate {
    func registerEvent(event: RegisterEvent) {
        switch event {
        case .selectPlant:
            let selectPlantPopup = SelectPlantPopupView.instance()
            selectPlantPopup.frame = view.frame
            view.addSubview(selectPlantPopup)
        case .selectDate:
            ()
        }
    }
    
    
}
