//
//  NetworkUrl.swift
//  TANetworkingSwift
//
//  Created by Girijesh Kumar on 09/01/16.
//  Copyright © 2016 Girijesh Kumar. All rights reserved.
//

import Foundation
import UIKit

/** --------------------------------------------------------
* HTTP Basic Authentication
*	--------------------------------------------------------
*/

let kHTTPUsername               = ""
let kHTTPPassword               = ""
//let kDeviceType               = "iOS" //1-iOS 2- Andoid
let OS                          = UIDevice.current.systemVersion
let kAppVersion                 = "1.0"
let kDeviceModel                = UIDevice.current.model
//let kAPIKEY                   = "cesar@123"
//let CLASS_START               = print(__FILE__)


/** --------------------------------------------------------
*	 API Base URL defined by Targets.
*	--------------------------------------------------------
*/

// wizz Server
 //let domain                      = "https://http-alysei-ibyteinfomatics-com-3.moesif.net/eyJhcHAiOiIxOTg6MTE5MCIsInZlciI6IjIuMCIsIm9yZyI6Ijg4OjE2OTkiLCJpYXQiOjE2MTQ1NTY4MDB9.Xp9RY5TPnnE3Aczw11vAT_hR--ve9i8aQrNNFDKTYrA"

//let domain                      = "http://alysei.ibyteinfomatics.com"


let domain                      = "https://https-alyseiapi-ibyteworkshop-com-3.moesif.net/eyJhcHAiOiIxOTg6MTE5MCIsInZlciI6IjIuMCIsIm9yZyI6Ijg4OjE2OTkiLCJpYXQiOjE2MjI1MDU2MDB9._oA92M6D_41n-jjhUT2cI5ciiqQ6oYkanoaBKSrZYho"
//let imageDomain                 = domain


//let domain                      = "https://alyseiapi.ibyteworkshop.com"
let imageDomain                 = "https://alyseiapi.ibyteworkshop.com"
let kBASEURL                    = "\(domain)/public/api/"
let kImageBaseUrl               = "\(imageDomain)/"
let kImageBaseUrl1              = "\(imageDomain)"
let kAuthentication             = "Authentication"      //Header key of request  encrypt data
let kEncryptionKey              = ""                    //Encryption key replace this with your projectname

//
//#if DEBUG
//    static int ddLogLevel = LOG_LEVEL_VERBOSE;
//    #elif TEST
//    static int ddLogLevel = LOG_LEVEL_INFO;
//    #elif STAGE
//    static int ddLogLevel = LOG_LEVEL_WARN;
//    #else
//    static int ddLogLevel = LOG_LEVEL_ERROR;
//    #endif

    /*****************************************************************************/
    /* Entry/exit trace macros                                                   */
    /*****************************************************************************/
   // #define TRC_ENTRY()    DDLogVerbose(@"ENTRY: %s:%d:", __PRETTY_FUNCTION__,__LINE__);
   // #define TRC_EXIT()     DDLogVerbose(@"EXIT:  %s:%d:", __PRETTY_FUNCTION__,__LINE__);
    
    
/** --------------------------------------------------------
*		Used Web Services Name
*	--------------------------------------------------------
*/


/** --------------------------------------------------------
*		API Request & Response Parameters Keys
*	--------------------------------------------------------
*/
let kUserData                     = "userData"

let kResult                     = "result"
let kResponse                   = "response"
let kDetail                     = "detail"
let kMessage                    = "message"
let kDeviceToken                = "deviceToken"

