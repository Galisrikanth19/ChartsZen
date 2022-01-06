//
//  PlayerTableViewCell.swift
//  ChartsZen
//
//  Created by mac on 05/01/22.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var nationalityLbl: UILabel!
    @IBOutlet var statusLbl: UILabel!
    
    var player: Player?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(WithPlayerModel player: Player, WithSelectedCell selCell:Bool) {
        customizeView()
        self.player = player
        titleLbl.text = player.name
        nationalityLbl.text = player.nationality
        statusLbl.text = player.status
        
        if selCell {
            bgView.backgroundColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1)
        } else {
            bgView.backgroundColor = .white
        }
    }
    
    private func customizeView() {
        self.selectionStyle = .none
        self.bgView.layer.cornerRadius = 10
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }

}
