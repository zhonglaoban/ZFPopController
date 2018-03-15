//
//  ZFPopController.swift
//  ZFPopup
//
//  Created by 钟凡 on 2017/10/17.
//  Copyright © 2017年 钟凡. All rights reserved.
//

import UIKit

enum PopDirection {
    case up
    case down
    case left
    case right
}

class ZFPopController: UIViewController {

    private let bundle = Bundle(for: ZFPopController.self)
    lazy var props = PopupProps()
    
    init() {
        super.init(nibName: nil, bundle: bundle)
        modalPresentationStyle = .popover
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nib = UINib(nibName: props.cellName, bundle: bundle)
            tableView.register(nib, forCellReuseIdentifier: props.cellName)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        tableView.selectRow(at: IndexPath(row:props.defaultIndex, section:0), animated: false, scrollPosition: .none)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ZFPopController:UITableViewDataSource, UITableViewDelegate {
    //MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return props.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: props.cellName, for: indexPath) as! PopupCell
        cell.data = props.dataSource[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.defaultIndex = indexPath.row
        if props.didSelectedBlock != nil {
            props.didSelectedBlock!(indexPath.row)
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: view.bounds.width, y: 0)
        let delay:TimeInterval = 0.05
        let cellDelay = delay * TimeInterval(indexPath.row)
        UIView.animate(withDuration: 1.0, delay: cellDelay, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
}
class PopupCell: UITableViewCell {
    @IBOutlet weak var infoLab: UILabel!
    @IBOutlet weak var countLab: UILabel!
    @IBOutlet weak var checkView: UIImageView!
    
    var data:(String?,Int)? {
        didSet {
            infoLab.text = data?.0
            countLab.text = "(\(data?.1 ?? 0))"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkView.isHidden = !selected
        if selected {
            infoLab.textColor = UIColor(red: 28/255, green: 156/255, blue: 221/255, alpha: 1)
            countLab.textColor = UIColor(red: 28/255, green: 156/255, blue: 221/255, alpha: 1)
        }else {
            infoLab.textColor = UIColor.black
            countLab.textColor = UIColor.black
        }
    }
}
class PopupProps {
    var popDirection:PopDirection = .up
    var popRect:CGRect = .zero
    var needHead:Bool = true
    var dataSource:[(String?,Int)] = [("1",1), ("2",2), ("3",3)]
    var cellHeight = 44
    var cellName:String = "PopupCell"
    var didSelectedBlock:((_ index:Int) -> ())?
    var defaultIndex:Int = 0
    
    init() {
        
    }
    
    init(dataSource:[String], defaultIndex:Int, didSelectedBlock:((_ index:Int) -> ())?) {
        
    }
}

