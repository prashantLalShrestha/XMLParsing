//
//  CheckUserStatus.swift
//  XMLParsing
//
//  Created by Prashant Shrestha on 8/11/18.
//  Copyright © 2018 Prashant Shrestha. All rights reserved.
//

import Foundation
//
//struct Structure: Codable {
//    var envelope: Envelope?
//    enum CodingKeys: String, CodingKey {
//        case envelope = "soap:Envelope"
//    }
//}
//
//struct Envelope: Codable {
//    var body: Body?
//    enum CodingKeys: String, CodingKey {
//        case body = "soap:Body"
//    }
//}
//
//struct Body: Codable {
//    var checkuserstatusresponse: CheckUserStatusResponse?
//    enum CodingKeys: String, CodingKey {
//        case checkuserstatusresponse = "CheckUserStatusResponse"
//    }
//}
//
//struct CheckUserStatusResponse: Codable {
//    var checkuserstatusresult: CheckUserStatusResult?
//    enum CodingKeys: String, CodingKey {
//        case checkuserstatusresult = "CheckUserStatusResult"
//    }
//}

struct CheckUserStatusResult: Codable {
    let message: String?
    let statusCode: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "MESSAGE"
        case statusCode = "STATUS_CODE"
    }
}


extension CheckUserStatusResult {
    static func retrieveBook() -> CheckUserStatusResult? {
        var dataString = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body><CheckUserStatusResponse xmlns=\"WebServices\"><CheckUserStatusResult><STATUS_CODE>1001</STATUS_CODE><MESSAGE>User Login ID is blank!</MESSAGE></CheckUserStatusResult></CheckUserStatusResponse></soap:Body></soap:Envelope>"
        if let range1 = dataString.range(of: "<\(self)>"), let range2 = dataString.range(of: "</\(self)>") {
            dataString = "\(dataString[range1.lowerBound..<range2.upperBound])"
        }
        print(dataString)
        guard let data = dataString.data(using: .utf8) else { return nil }
        
        let decoder = XMLDecoder()
        
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let book: CheckUserStatusResult?
        
        do {
            book = try decoder.decode(CheckUserStatusResult.self, from: data)
        } catch {
            print(error)
            
            book = nil
        }
        
        return book
    }
    
    func toXML() -> String? {
        let encoder = XMLEncoder()
        
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        
        encoder.dateEncodingStrategy = .formatted(formatter)
        
        do {
            let data = try encoder.encode(self, withRootKey: "\(CheckUserStatusResult.self)", header: nil)
            
            return String(data: data, encoding: .utf8)
        } catch {
            print(error)
            
            return nil
        }
    }
}
