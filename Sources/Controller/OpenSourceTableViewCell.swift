//
//  OpenSourceTableViewCell.swift
//  Pods
//
//  Created by Florian Gabach on 05/02/2017.

import UIKit

final class OpenSourceTableViewCell: UITableViewCell, Reusable {

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.prepareCellComponent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Prepare

    func prepareCellComponent() {
        self.textLabel?.numberOfLines = 0
        self.accessoryType = .none
        self.selectionStyle = .none
    }

    // MARK: - Configure

    func configure(licence: LicenceFile, config: OpenSourceControllerConfig) {
        self.textLabel?.attributedText = licence.attributedContent
        self.textLabel?.textColor = config.uiConfig.licenceTextColor

        if let backgroundColor = config.uiConfig.licenceBackgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}
