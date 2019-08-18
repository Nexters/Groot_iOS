//
//  SelectPlantPopupView.swift
//  Pliary
//
//  Created by jeewoong.han on 18/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit

class SelectPlantPopupView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: RegisterEventDelegate?
    private var list = PlantList.getAllPlants()
    var currentPlant: Plant?
    
    static func instance() -> SelectPlantPopupView {
        let view: SelectPlantPopupView = UIView.createViewFromNib(nibName: SelectPlantPopupView.identifier)
        view.backgroundView.clipsToBounds = true
        view.backgroundView.layer.cornerRadius = 6
        view.setUpTableView()
        return view
    }
    
    @IBAction func tapCloseButton(_ sender: Any) {
        removeFromSuperview()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: SelectPlantTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SelectPlantTableViewCell.reuseIdentifier)
    }

}

extension SelectPlantPopupView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectPlantTableViewCell {
            guard let plant = cell.plant else {
                return
            }
            
            cell.selected()
            delegate?.registerEvent(event: .plantSelected(plant: plant))
            removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectPlantTableViewCell {
            cell.deselected()
        }
    }
}

extension SelectPlantPopupView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectPlantTableViewCell.identifier) as? SelectPlantTableViewCell {
            
            let plant = list[indexPath.row]
            
            if currentPlant?.englishName == plant.englishName {
                cell.setUp(with: plant, selected: true)
            } else {
                cell.setUp(with: plant)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
