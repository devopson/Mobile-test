//
//  Extention.swift
//  marvel
//
//  Created by Matheus Cereja on 24/05/19.
//  Copyright © 2019 Matheus Cereja. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import CommonCrypto

extension Alamofire.DataResponse {
    func debugLog() {
        var output: [String] = []
        var datastring = ""
        if let body = request?.httpBody {
            datastring = NSString(data: body, encoding: String.Encoding.utf8.rawValue)! as String
        }
        if let header = request?.allHTTPHeaderFields {
            print(header)
        }
        
        if let response = response?.allHeaderFields {
            print(response)
        }
        
        output.append(request != nil ? "[Request]: \(request!)" : "[Request]: nil")
        output.append("[Method]: \(String(describing: request?.httpMethod))")
        output.append("[Body]: \(datastring)")
        output.append("[Result]: \(result.debugDescription)")
        print(output.joined(separator: "\n"))
    }
}

extension Alamofire.SessionManager{
    @discardableResult
    open func requestWithoutCache(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil)// also you can add URLRequest.CachePolicy here as parameter
        -> DataRequest
    {
        do {
            var urlRequest = try URLRequest(url: url, method: method, headers: headers)
            urlRequest.cachePolicy = .reloadIgnoringCacheData // <<== Cache disabled
            let encodedURLRequest = try encoding.encode(urlRequest, with: parameters)
            return request(encodedURLRequest)
        } catch {
            // TODO: find a better way to handle error
            print(error)
            return request(URLRequest(url: URL(string: "http://example.com/wrong_request")!))
        }
    }
}

extension String {
    func md5() -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}

extension UIView{
    func rounder(){
        self.layer.cornerRadius = 6.0
    }
}

