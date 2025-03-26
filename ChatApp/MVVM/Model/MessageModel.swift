//
//  MessageModel.swift
//  ChatApp
//
//  Created by Nikk Bhateja on 26/03/25.
//

import Foundation

struct MessageModel: Codable {
    var text: String?
    var userId: String?
    var image: String?
    var timestamp: Date?
    var messageType: String?
    
    init(text: String? = nil, userId: String? = nil, image: String? = nil, timestamp: Date? = nil, messageType: String? = nil) {
        self.text = text
        self.userId = userId
        self.image = image
        self.timestamp = timestamp
        self.messageType = messageType
    }
    
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.text, forKey: .text)
        try container.encodeIfPresent(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encodeIfPresent(self.timestamp, forKey: .timestamp)
        try container.encodeIfPresent(self.messageType, forKey: .messageType)
    }
    
    enum CodingKeys: CodingKey {
        case text
        case userId
        case image
        case timestamp
        case messageType
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.timestamp = try container.decodeIfPresent(Date.self, forKey: .timestamp)
        self.messageType = try container.decodeIfPresent(String.self, forKey: .messageType)
    }
}
