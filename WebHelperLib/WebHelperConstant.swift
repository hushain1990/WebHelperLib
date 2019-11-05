//
//  WebHelperConstant.swift
//  WebHelperLib
//
//  Created by Hushan on 11/5/19.
//  Copyright © 2019 Hushan M Khan. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2019 Hushain Mubarik Khan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


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




