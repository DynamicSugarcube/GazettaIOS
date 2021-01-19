//
//  TableCellProtocol.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 19.01.2021.
//

import UIKit

protocol TableCellProtocol {
    static var identifier: String { get }
    static var nib: UINib { get }
}
