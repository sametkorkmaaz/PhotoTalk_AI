//
//  ViewController.swift
//  PhotoTalk_AI
//
//  Created by Samet Korkmaz on 13.12.2024.
//

import UIKit

class ViewController: UIViewController {

    
    private let view1: UIView = {
        let view1 = UIView()
        view1.layer.cornerRadius = 10
        view1.layer.borderWidth = 10
        view1.layer.borderColor = UIColor.second.cgColor
        view1.backgroundColor = .main
        return view1
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        prepareUI()
        
    }

    func prepareUI() {
        [view1].forEach{
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            view1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
        ])
    }

}
#Preview("UIKit"){
    ViewController()
}

