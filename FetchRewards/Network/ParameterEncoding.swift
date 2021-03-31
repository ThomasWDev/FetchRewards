//
//  ParameterEncoding.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 6/20/19.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

extension CharacterSet {
    
    static let networkURLQueryAllowed: CharacterSet = {
        let encodableDelimiters = CharacterSet(charactersIn: ":#[]@!$&'()*+,;=")
        let allowedCharacterSet = CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
        return allowedCharacterSet
    }()
}

class ParameterEncoding {
    
    class func formatRequestParameters(request: URLRequest, parameters: [String: AnyHashable]?) -> URLRequest {
        var request = request
        guard let parameters = parameters else {
            return request
        }
        switch request.httpMethod {

        case RequestConfiguration.HTTPMethod.get.rawValue:

            var parametersString = httpParametersString(parameters: parameters)

            if !parametersString.isEmpty {
                parametersString = "?" + parametersString
            }
            if let url = request.url {
                let urlStringWithParameters = url.absoluteString + parametersString
                if let urlWithParameters = URL(string: urlStringWithParameters) {
                    request.url = urlWithParameters
                }
            }
        case RequestConfiguration.HTTPMethod.post.rawValue,
             RequestConfiguration.HTTPMethod.put.rawValue:
            let parametersString = httpParametersString(parameters: parameters)
            request.httpBody = parametersString.data(using: .utf8)

        default: debugPrint("Nothing to do")

        }

        return request
    }
    
    class func urlEncode(string: String) -> String {
        var urlEncodedString = ""
        if let encodedString = string.addingPercentEncoding(withAllowedCharacters: .networkURLQueryAllowed) {
            urlEncodedString = encodedString
        }
        return urlEncodedString
    }
    
    class func httpParametersString(parameters: [String: AnyHashable]) -> String {
        var parametersString = ""
        parameters.keys.forEach { (key) in
            if let parameterValue = parameters[key] {
                let encodedParameterKey = urlEncode(string: key)
                let encodedParameterValue = urlEncode(string: "\(parameterValue)")
                parametersString = "\(parametersString)\(encodedParameterKey)=\(encodedParameterValue)"
                parametersString.append("&")
            }
        }
        return parametersString
    }
}
