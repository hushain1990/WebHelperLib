//
//  WebHelperConstant.swift
//  WebHelperLib
//
//  Created by Hushan on 11/5/19.
//  Copyright © 2019 Hushan M Khan. All rights reserved.
//

import Foundation

public enum RequestMathod {
    
    case GET
    case POST
    case PUT
    case DELETE
    
}

public enum WebHelperLibError : Error {
    
    case NO_INTERTER_CONNECTION
    case NO_DATA
    case URL_MISSING
    case MISSING_PARAMETERS
    case RESPONSE_ERROR
    case SERVER_ERROR
    
}




