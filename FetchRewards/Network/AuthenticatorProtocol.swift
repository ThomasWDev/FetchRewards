//
//  AuthenticatorProtocol.swift
//  FetchRewards
//
//  Created by Thomas Woodfin on 6/20/19.
//  Copyright © 2021 Thomas.Woodfin. All rights reserved.
//

import Foundation

typealias AuthenticationCompletion = (Result<URLRequest, Error>) -> Void

protocol AuthenticatorProtocol {
    
    func addAuthentication(requestConfiguration: RequestConfiguration, urlRequest: URLRequest, completion: @escaping AuthenticationCompletion)
}
