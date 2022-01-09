//
//  String.swift
//  NoteAppSE
//
//  Created by Stanislav on 02.01.2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
