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
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.size.height, left: 0, bottom: 0, right: 0)
        
        let mainDetailName = MainDetailTableViewCell.reuseIdentifier
        let mainDetailNib = UINib(nibName: mainDetailName, bundle: nil)
        tableView.register(mainDetailNib, forCellReuseIdentifier: mainDetailName)
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        let translation = gr.translation(in: view)
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            let velocity = gr.velocity(in: view)
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
}

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        tableView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let mainDetailCell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.reuseIdentifier) as? MainDetailTableViewCell {
                return mainDetailCell
            }
        }
        
        
        return UITableViewCell()
    }
    
    
}
