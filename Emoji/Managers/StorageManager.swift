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
            [Emoji(symbol: "⭐️", name: "Звезда", description: "Жёлтая звезда", type: "Рандом", usage: "Отмечать хорошее"),
             Emoji(symbol: "🤓", name: "Нерд", description: "Смайлик в очках", type: "Рандом", usage: "Что-то заумное"),
             Emoji(symbol: "🏖", name: "Пляж", description: "Зонтик на острове", type: "Рандом", usage: "Поедем отдыхать"),
             Emoji(symbol: "🗽", name: "Свобода", description: "Статуя свободы", type: "Рандом", usage: "Права человека")],
            [Emoji(symbol: "🍏", name: "Яблоко", description: "Зеленое яблоко", type: "Еда", usage: "Очень кислое"),
             Emoji(symbol: "🍉", name: "Арбуз", description: "Спелый арбуз", type: "Еда", usage: "Можно и поесть и попить одновременно"),
             Emoji(symbol: "🍓", name: "Клубника", description: "Свежая клубника", type: "Еда", usage: "Популярная ягода"),
             Emoji(symbol: "🥗", name: "Зеленный салат", description: "Салат из свежих овощей", type: "Еда", usage: "Для тех, кто хочет быть в форме")],
            [Emoji(symbol: "🐶", name: "Собака", description: "Вислоухая собака", type: "Животные", usage: "Друг человека"),
             Emoji(symbol: "🐼", name: "Панда", description: "Пухлая панда", type: "Животные", usage: "Самое милое существо"),
             Emoji(symbol: "🐬", name: "Дельфин", description: "Выпрыгивающий дельфин", type: "Животные", usage: "Самое умное млекопитающее"),
             Emoji(symbol: "🦄", name: "Единорог", description: "Розовый единорог", type: "Животные", usage: "Мифическое животное")],
            [Emoji(symbol: "📱", name: "Телефон", description: "Современный телефон", type: "Техника", usage: "Предположительно iPhone"),
             Emoji(symbol: "📟", name: "Пейджер", description: "Портативное радиоприёмное устройство", type: "Техника", usage: "Когда-то такими штуками пользовались люди")]
        ]
    }
}
