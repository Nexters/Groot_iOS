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

    @IBOutlet weak var writeDiaryButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var diaryCards: [DiaryCard] = []
    var diaryCardsCount: Int {
        return 10
//        return diaryCards.count + 2
    }
    
    @IBAction func tapWriteDiaryButton(_ sender: Any) {
        
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.size.height, left: 0, bottom: 0, right: 0)
        
        let mainDetailName = MainDetailTableViewCell.reuseIdentifier
        let mainDetailNib = UINib(nibName: mainDetailName, bundle: nil)
        tableView.register(mainDetailNib, forCellReuseIdentifier: mainDetailName)
        
        let dayWithPlantName = DayWithPlantTableViewCell.reuseIdentifier
        let dayWithPlantNib = UINib(nibName: dayWithPlantName, bundle: nil)
        tableView.register(dayWithPlantNib, forCellReuseIdentifier: dayWithPlantName)
        
        let diaryCardWithAllName = DiaryCardWithAllTableViewCell.reuseIdentifier
        let diaryCardWithAllNib = UINib(nibName: diaryCardWithAllName, bundle: nil)
        tableView.register(diaryCardWithAllNib, forCellReuseIdentifier: diaryCardWithAllName)
    }
    
    func setUpGesture() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:)))
        tableView.addGestureRecognizer(gesture)
        gesture.delegate = self
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpGesture()
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer)
        -> Bool {
            return true
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        guard tableView.contentOffset.y == 0 else {
            Hero.shared.cancel()
            return
        }
        
        let translation = gr.translation(in: view)
        let velocity = gr.velocity(in: view)
        
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < view.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = true
        } else if scrollView.contentOffset.y == view.frame.height {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            writeDiaryButton.isHidden = false
        } else {
            tableView.isPagingEnabled = false
            tableView.bounces = true
            writeDiaryButton.isHidden = false
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return tableView.frame.height
        } else if indexPath.row == 0 {
            return DayWithPlantTableViewCell.height
        } else {
            return DiaryCardWithAllTableViewCell.height
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return DetailTableHeaderView.height
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return diaryCardsCount
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let headerView = DetailTableHeaderView.instance()
            headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: DetailTableHeaderView.height)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                return cell
            }
        } else if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: DayWithPlantTableViewCell.reuseIdentifier) as? DayWithPlantTableViewCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: DiaryCardWithAllTableViewCell.reuseIdentifier) as? DiaryCardWithAllTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    
}
