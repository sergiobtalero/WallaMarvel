//
//  String+MD5.swift
//  Data
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        return digest.map { .init(format: "%02hhx", $0) }.joined()
    }
}
