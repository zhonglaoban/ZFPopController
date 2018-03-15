//
//  ViewController.swift
//  ZFPopController
//
//  Created by 钟凡 on 2018/3/14.
//  Copyright © 2018年 钟凡. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: view) ?? .zero
        let popVC = ZFPopController()
        popVC.preferredContentSize = CGSize(width: 200, height: 300)
        popVC.popoverPresentationController?.delegate = self
        popVC.popoverPresentationController?.sourceView = view
        popVC.popoverPresentationController?.sourceRect = CGRect(origin: point, size: CGSize.zero)
        
        present(popVC, animated: true, completion: nil)
    }

}
extension ViewController:UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

