//
//  CourseCell.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 03.01.2021.
//

import UIKit

class CourseCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCoerse: UILabel!
    
    func initCell(currencye: Currencye) {
        imageFlag.image = currencye.imageFlag
        labelCurrencyName.text = currencye.CurrencyCodeL
        labelCoerse.text = currencye.Amount
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
