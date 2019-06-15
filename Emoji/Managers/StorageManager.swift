//
//  StorageManager.swift
//  Emoji
//
//  Created by Michael Tseitlin on 6/12/19.
//  Copyright © 2019 Michael Tseitlin. All rights reserved.
//

import Foundation

class StorageManager {
    
    // MARK: - Properties
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let archiveURL: URL
    
    init() {
        archiveURL = documentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    }
    
    // MARK: - Methods
    
    func saveData(emojis: [[Emoji]]) {
        let encoder = PropertyListEncoder()
        guard let encodedEmojis = try? encoder.encode(emojis) else { return }
        try? encodedEmojis.write(to: archiveURL, options: .noFileProtection)
    }
    
    func loadData() -> [[Emoji]]? {
        guard let data = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([[Emoji]].self, from: data)
    }
    
    func loadEmojis() -> [[Emoji]] {
        return [
            [Emoji(symbol: "⭐️", name: "Звезда", description: "Жёлтая звезда", usage: "Отмечать хорошее"),
             Emoji(symbol: "🤓", name: "Нерд", description: "Смайлик в очках", usage: "Что-то заумное"),
             Emoji(symbol: "🏖", name: "Пляж", description: "Зонтик на острове", usage: "Поедем отдыхать"),
             Emoji(symbol: "🗽", name: "Свобода", description: "Статуя свободы", usage: "Права человека")],
            [Emoji(symbol: "🍏", name: "Яблоко", description: "Зеленое яблоко", usage: "Очень кислое"),
             Emoji(symbol: "🍉", name: "Арбуз", description: "Спелый арбуз", usage: "Можно и поесть и попить одновременно"),
             Emoji(symbol: "🍓", name: "Клубника", description: "Свежая клубника", usage: "Популярная ягода"),
             Emoji(symbol: "🥗", name: "Зеленный салат", description: "Салат из свежих овощей", usage: "Для тех, кто хочет быть в форме")],
            [Emoji(symbol: "🐶", name: "Собака", description: "Вислоухая собака", usage: "Друг человека"),
             Emoji(symbol: "🐼", name: "Панда", description: "Пухлая панда", usage: "Самое милое существо"),
             Emoji(symbol: "🐬", name: "Дельфин", description: "Выпрыгивающий дельфин", usage: "Самое умное млекопитающее"),
             Emoji(symbol: "🦄", name: "Единорог", description: "Розовый единорог", usage: "Мифическое животное")],
            [Emoji(symbol: "📱", name: "Телефон", description: "Современный телефон", usage: "Предположительно iPhone"),
             Emoji(symbol: "📟", name: "Пейджер", description: "Портативное радиоприёмное устройство", usage: "Когда-то такими штуками пользовались люди")]
        ]
    }
}
