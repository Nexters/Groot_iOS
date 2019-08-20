//
//  DetailViewController.swift
//  Pliary
//
//  Created by jeewoong.han on 05/08/2019.
//  Copyright © 2019 groot.nexters.pliary. All rights reserved.
//

import UIKit
import Hero

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedPlant: Plant?
    var animating: Bool = true
    var headerView: DetailTableHeaderView?
    var first = true
    
    var currentSection: Section = .diaryCard {
        didSet {
            guard oldValue != currentSection else {
                return
            }
            
            headerView?.currentSection = currentSection
            for cell in tableView.visibleCells {
                if let sectionCell = cell as? SectionTableViewCell {
                    sectionCell.changeSection(to: currentSection, animated: true)
                    return
                }
            }
        }
    }
    
    func goDiaryViewController(with diaryCard: DiaryCard?) {
        let storyboard = UIStoryboard.init(name: StoryboardName.detail, bundle: nil)
        
        guard let writeDiaryVC = storyboard.instantiateViewController(withIdentifier: DiaryViewController.identifier) as? DiaryViewController else {
            return 
        }
        
        writeDiaryVC.hero.isEnabled = true
        writeDiaryVC.hero.modalAnimationType = .push(direction: .left)
        writeDiaryVC.plant = selectedPlant
        
        if diaryCard != nil {
            writeDiaryVC.currentMode = .showDiary
            writeDiaryVC.currentDiaryCard = diaryCard
        }
        
        present(writeDiaryVC, animated: true, completion: nil)
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let mainDetailNib = UINib(nibName: MainDetailTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(mainDetailNib, forCellReuseIdentifier: MainDetailTableViewCell.reuseIdentifier)
        
        let sectionNib = UINib(nibName: SectionTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(sectionNib, forCellReuseIdentifier: SectionTableViewCell.reuseIdentifier)
    }
    
    func animatePlant(_ bool: Bool) {
        for cell in tableView.visibleCells {
            if let plantCell = cell as? MainDetailTableViewCell {
                if bool {
                    plantCell.animateImage()
                    animating = true
                } else {
                    plantCell.stopImage()
                    animating = false
                }
                return
            }
        }
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.contentInset.top = -UIApplication.shared.statusBarFrame.size.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if first {
            first = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if !first {
            tableView.reloadData()
        }
    }
}
