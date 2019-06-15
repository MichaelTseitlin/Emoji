//
//  Emoji.swift
//  Emoji
//
//  Created by Michael Tseitlin on 6/12/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import Foundation

class Emoji: Codable {
    
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    var encoded: Data? {
        let encoder = PropertyListEncoder()
        return try? encoder.encode(self)
    }
    
    convenience init?(from data: Data) {
        let decoder = PropertyListDecoder()
        guard let emoji = try? decoder.decode(Emoji.self, from: data) else { return nil}
        self.init(symbol: emoji.symbol,
                  name: emoji.name,
                  description: emoji.description,
                  usage: emoji.usage)
    }
    
    init(symbol: String = "",
         name: String = "",
         description: String = "",
         usage: String = "")
    {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
