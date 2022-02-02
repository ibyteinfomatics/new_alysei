//
//  TANetworkManager.swift
//  TANetworkingSwift
//
//  Created by Girijesh Kumar on 09/01/16.
//  Copyright © 2016 Girijesh Kumar. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


public enum kHTTPMethod: String
{
    case GET, POST, PUT, PATCH, DELETE
}

public enum ErrorType: Error
{
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class TANetworkManager{
  
    // MARK: - Properties
    
    /**
     A shared instance of `Manager`, used by top-level Alamofire request methods, and suitable for use directly
     for any ad hoc requests.
     */
    internal static let sharedInstance: TANetworkManager =
    {
        return TANetworkManager()
    }()
    
    static var IMG_EXTENSION:String { return ".jpeg" }
    
    static var VID_EXTENSION:String { return ".mp4" }

    static var IMG_MIMETYPE:String { return "image/jpeg" }
    
    static var VIDEO_MIMETYPE:String { return "video/mp4" }
    
    //MARK: - setupURLForGETRequest -
    
    func createGETURL(forString strURL:String, withParams pararmsDict:Dictionary<String, Any>) -> String{
      
           var newStrURL = strURL
           
           if newStrURL.hasSuffix("?") == false
           {
               newStrURL += "?"
           }
           
           for (key, value) in pararmsDict
           {
               if newStrURL.hasSuffix("?")
               {
                   newStrURL = "\(newStrURL)\(key)=\(value)"
               }
               else
               {
                   newStrURL = "\(newStrURL)&\(key)=\(value)"
               }
           }
           
           return newStrURL
       }// end of method -- setupURLForGETRequest
    
    //MARK:- Public Method
    /**
     *  Initiates HTTPS or HTTP request over |kHTTPMethod| method and returns call back in success and failure block.
     *
     *  @param serviceName  name of the service
     *  @param method       method type like Get and Post
     *  @param postData     parameters
   *  @param responeBlock call back in block
   */


func requestApi(withServiceName serviceName: String,requestMethod method: kHTTPMethod, userName: String = "",passsword: String = "",requestParameters dictParams: NonNullDictionary, withProgressHUD showProgress: Bool, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void{
      
          if NetworkReachabilityManager()?.isReachable == true{
            
              if showProgress{
                  if isRefreshing == true{
                      SVProgressHUD.dismiss()
                      isRefreshing = false
                  }else{
                SVProgressHUD.show()
                  }
              }
            
              let headers = getHeaderWithAPIName(serviceName: serviceName,username: userName,password: passsword)
            
              let serviceUrl = getServiceUrl(string: serviceName)
            
              //let postData = self.checkAndConvertAllValuesToString(withDictParams: dictParams)
            
              let params  = getPrintableParamsFromJson(postData: dictParams)
            
              print( "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
            
              print(headers)
            
              //NSAssert Statements
              assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
                window.isUserInteractionEnabled = true
            }
              switch method
              {
              case .GET:
               
                Alamofire.Session.default.request(serviceUrl, method: .get, parameters: dictParams, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                      { (DataResponse) in
                        SVProgressHUD.dismiss()
                        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
                            window.isUserInteractionEnabled = true
                        }
                        switch DataResponse.result
                        {
                          case .success(let JSON):
                              print( "Success with JSON: \(JSON)")
                              print( "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                              guard  DataResponse.data != nil else {
                                return
                              }
                              let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                              completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                          case .failure(let error):
                              print( "json error: \(error.localizedDescription)")
                              if error.localizedDescription == "cancelled"
                              {
                                  completionClosure(nil, error, .requestCancelled, Int.getInt(DataResponse.response?.statusCode))
                              }
                              else
                              {
                                  completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                              }
                          }
                  })
                
                
              case .POST:
                Alamofire.Session.default.request(serviceUrl, method: .post, parameters: dictParams, encoding: JSONEncoding.default
                      , headers: headers).responseJSON(completionHandler:
                          { (DataResponse) in
                            SVProgressHUD.dismiss()
                              switch DataResponse.result
                              {
                              case .success(let JSON):
                                  print( "Success with JSON: \(JSON)")
                                  print( "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                                  let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                                  completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                              case .failure(let error):
                                  print( "json error: \(error.localizedDescription)")
                                  completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                              }
                      })
              case .PUT:
                  Alamofire.Session.default.request(serviceUrl, method: .put, parameters: dictParams, encoding: JSONEncoding.prettyPrinted, headers: headers).responseJSON(completionHandler:
                      { (DataResponse) in
                        SVProgressHUD.dismiss()
                          switch DataResponse.result
                          {
                          case .success(let JSON):
                              print( "Success with JSON: \(JSON)")
                              print( "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                              let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                              completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                          case .failure(let error):
                              print( "json error: \(error.localizedDescription)")
                              completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                          }
                  })
              case .PATCH:
                  Alamofire.Session.default.request(serviceUrl, method: .patch, parameters: dictParams, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                      { (DataResponse) in
                        //SVProgressHUD.show()
                        SVProgressHUD.dismiss()
                          switch DataResponse.result
                          {
                          case .success(let JSON):
                              print( "Success with JSON: \(JSON)")
                              print( "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                              let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                              completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                          case .failure(let error):
                              print( "json error: \(error.localizedDescription)")
                              completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                          }
                  })
              case .DELETE:
                  Alamofire.Session.default.request(serviceUrl, method: .delete, parameters: dictParams, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                      { (DataResponse) in
                        //SVProgressHUD.show()
                        SVProgressHUD.dismiss()
                          switch DataResponse.result
                          {
                          case .success(let JSON):
                              print( "Success with JSON: \(JSON)")
                              print( "Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                              let response = self.getResponseDataDictionaryFromData(data: DataResponse.data!)
                              completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(DataResponse.response?.statusCode))
                          case .failure(let error):
                              print( "json error: \(error.localizedDescription)")
                              completionClosure(nil, error, .requestFailed, Int.getInt(DataResponse.response?.statusCode))
                          }
                  })
              }
          }
          else{
           // SVProgressHUD.show()
            SVProgressHUD.dismiss()
              completionClosure(nil, nil, .noNetwork, nil)
          }
      }

      /**
       *  Upload multiple images and videos via multipart
       *
       *  @param serviceName  name of the service
       *  @param imagesArray  array having images in NSData form
     *  @param videosArray  array having videos file path
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */

  
  private func convertToData(_ value:Any) -> Data{
    
    if let str =  value as? String
    {
      return String.getString(str).data(using: String.Encoding.utf8)!
    }
    else if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
    {
      return jsonData
    }
    else
    {
      return Data()
    }
  }
  
  func requestMultiPart(withServiceName serviceName: String, requestMethod method: HTTPMethod, requestImages arrImages: [Dictionary<String, Any>], requestVideos arrVideos: Dictionary<String, Any>, requestData postData: Dictionary<String, Any>, completionClosure: @escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void {
    
    if NetworkReachabilityManager()?.isReachable == true {
      
      let serviceUrl = getServiceUrl(string: serviceName)
      let params  = getPrintableParamsFromJson(postData: postData)
      let headers = getHeaderWithAPIName(serviceName: serviceName)
      
      print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
            window.isUserInteractionEnabled = true
        }
      
      Alamofire.Session.default.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
        
        for (key,value) in postData {
          multipartFormData.append(self.convertToData(value),withName: key)
        }
        
        let videoDic = kSharedInstance.getDictionary(arrVideos)
        let videoData = videoDic["video"] as? Data
        
        if videoData != nil {
          multipartFormData.append(videoData!,
                                   withName: videoDic["videoName"] as! String,
                                   fileName: "messagevideo.mp4",
                                   mimeType: "video/mp4")
        }
        
        for (key, value) in postData {
          multipartFormData.append(self.convertToData(value), withName: key)
        }
        
        
        for dictImage in arrImages {
          let validDict = kSharedInstance.getDictionary(dictImage)
          if let image = validDict["image"] as? UIImage
          {
            if let imageData: Data = image.jpegData(compressionQuality: 0.5)
            {
              multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
            }
          }else if let images = validDict["image"] as? [UIImage]{
            for image in images{
                if let imageData: Data = image.jpegData(compressionQuality: 0.5)
                {
                  multipartFormData.append(imageData, withName: String.getString(validDict["imageName"]), fileName: String.getString(NSNumber.getNSNumber(message: self.getCurrentTimeStamp()).intValue) + ".jpeg", mimeType: "image/jpeg")
                }
            }
          }
        }
      }, to: serviceUrl, method: method, headers: headers).responseJSON { (dataResponse: AFDataResponse<Any>) in
        
        switch dataResponse.result
        {
        case .success:
          SVProgressHUD.dismiss()
            if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
                window.isUserInteractionEnabled = true
            }
          let response = self.getResponseDataDictionaryFromData(data: dataResponse.data!)
          completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(dataResponse.response?.statusCode))
        case .failure(let error):
          SVProgressHUD.dismiss()
          completionClosure(nil, error, .requestFailed, 200)
        }
      }
    } else {
      
      SVProgressHUD.dismiss()
      completionClosure(nil, nil, .noNetwork, nil)
    }
  }

  
    func tempMultiPart(withServiceName serviceName: String, requestMethod method: HTTPMethod, requestImages arrImages: NonNullDictionary, requestVideos arrVideos: [NonNullDictionary] = [] , requestData postData: NonNullDictionary, imageGroupName: String?, completionClosure: @escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void{
      
        if NetworkReachabilityManager()?.isReachable == true{
          
          SVProgressHUD.show()
            
          let serviceUrl = getServiceUrl(string: serviceName)
          let params  = getPrintableParamsFromJson(postData: postData)
          let headers = getHeaderWithAPIName(serviceName: serviceName)
          
          print(headers)
          print_debug(items: "Connecting to Host with URL \(kBASEURL)\(serviceName) with parameters: \(params)")
          print_debug(items: "Parameter - \(postData)")
          print_debug(items: "Parameter - \(arrImages)")
            if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
                window.isUserInteractionEnabled = true
            }
            
          Alamofire.Session.default.upload(multipartFormData:{ (multipartFormData: MultipartFormData) in
            if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
                window.isUserInteractionEnabled = true
            }
                for key in postData.keys {
                  
                  let name = String.getString(key)
                  if let val = postData[name] as? String {

                    multipartFormData.append(val.data(using: String.Encoding.utf8)!, withName: name)
                  }
                }
                
            if let image = arrImages["image"] as? UIImage{
              if let imageData:Data = image.jpegData(compressionQuality: 0.7){
                    var imgFileName = TANetworkManager.toString(arrImages["fileName"])

                    if imgFileName.isEmpty { imgFileName = self.createImageFileName() }

                    multipartFormData.append(imageData, withName: TANetworkManager.toString(arrImages["imageName"]), fileName: imgFileName, mimeType: TANetworkManager.IMG_MIMETYPE)
                }
            }

            if let images = arrImages["image"] as? [UIImage] {
                for (index, image) in images.enumerated() {
                    if let imageData:Data = image.jpegData(compressionQuality: 0.3){
                        var imgFileName = TANetworkManager.toString(arrImages["fileName"])
//
                        if imgFileName.isEmpty { imgFileName = self.createImageFileName() }

//                        let imgFileName = "image\(index).jpg"
                        //multipartFormData.append(imageData, withName: "attachments[]", fileName: imgFileName, mimeType: TANetworkManager.IMG_MIMETYPE)
                        multipartFormData.append(imageData, withName: "\(imageGroupName ?? "attachments[]")", fileName: imgFileName, mimeType: TANetworkManager.IMG_MIMETYPE)
//                        multipartFormData.append(imageData.base64EncodedData(), withName: TANetworkManager.toString(arrImages["imageName"]))
                    }
                }

//                multipartFormData.append(Data(images), withName: "attachments")
            }
                //self.addBodyParameters(inFormData: multipartFormData, params: postData)
                //self.addImages(inFormData: multipartFormData, imageList: [arrImages], keyImage: "image", keyFileName: "fileName", keyImageName: "imageName")
                //self.addVideos(inFormData: multipartFormData, videoList: arrVideos, keyVideo: "video", keyFileName: "fileName", keyVideoName: "videoName")

            print(multipartFormData.contentLength)
          }, to: serviceUrl, method: method, headers:headers).responseJSON { (dataResponse: AFDataResponse<Any>) in
                
            switch dataResponse.result{
                case .success:
                  let response = self.getResponseDataDictionaryFromData(data: dataResponse.data!)
                  completionClosure(response.responseData, response.error, .requestSuccess, Int.getInt(dataResponse.response?.statusCode))
              case .failure(let error):
                //SVProgressHUD.dismiss()
                completionClosure(nil, error, .requestFailed, 200)
            }
          }
        }
        else{
           // SVProgressHUD.dismiss()
        completionClosure(nil, nil, .noNetwork, nil)
      }
    }

    func cancelAllRequests(completionHandler: @escaping () -> ()){
      
        let sessionManager = Alamofire.Session.default
        sessionManager.session.getTasksWithCompletionHandler { (dataTask: [URLSessionDataTask], uploadTask: [URLSessionUploadTask], downloadTask: [URLSessionDownloadTask]) in
            dataTask.forEach({ (task: URLSessionDataTask) in task.cancel() })
            uploadTask.forEach({ (task: URLSessionUploadTask) in task.cancel() })
            downloadTask.forEach({ (task: URLSessionDownloadTask) in task.cancel() })
            completionHandler()
        }
    }
    
    func downloadFile(withServiceName serviceName: String,params:[String: Any]? = nil,folderName:String = "", _ progressHandler:(((_ progress:Progress) ->Void)?) = nil,_ successHandler:((_ downloadURL:URL?) ->Void)? = nil, _ failureHandler:((_ error:Error) ->Void)? = nil) -> Void{
      
        let apiHeader = getHeaderWithAPIName(serviceName: serviceName)
        let serviceUrl = getServiceUrl(string: serviceName)
      
        print(apiHeader)
        print(serviceUrl)
        if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
            window.isUserInteractionEnabled = true
        }
        
      Alamofire.Session.default.download(
            serviceUrl,
            method: .get,
            parameters: params,
            encoding: URLEncoding.default,
            headers: apiHeader,
            to: { (url, response) -> (destinationURL: URL, options: DownloadRequest.Options) in
                
                print("response",response)
              
                var pathComponent = folderName

                if pathComponent.isEmpty {
                  pathComponent = self.getCurrentTimeAsPathName()
                }
                
                let fileManager = FileManager.default
                let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

                let fileUrl = directoryURL.appendingPathComponent(pathComponent).appendingPathComponent(String(any:response.suggestedFilename))
                
                return (fileUrl, [.removePreviousFile, .createIntermediateDirectories])
                
                
        }).downloadProgress(closure: { (progress:Progress) in
                progressHandler?(progress)
                print("progress",progress)
            }).response(completionHandler:
              { (downloadResponse:DownloadResponse) in
                
                if  let resError = downloadResponse.error {
                    
                    failureHandler?(resError)
                    
                } else {
                     successHandler?(downloadResponse.fileURL)
                }
                
                print("response.destinationURL",(downloadResponse.fileURL ?? ""),"response.error",(downloadResponse.error ?? ""))
                
            })
                
                //validate { (request:URLRequest?, response:HTTPURLResponse, _, _) -> Request.ValidationResult in
//
//                switch response.statusCode {
//
//                case 200: return Request.ValidationResult.success
//                case 204:
//
//                    let error = NSError(domain: "No Data", code: 0, userInfo: [NSLocalizedDescriptionKey : "No File Found"])
//
//                    return Request.ValidationResult.failure(error)
//
//                default:
//
//                    let error = NSError(domain: "Downloading Error", code: 0, userInfo: [NSLocalizedDescriptionKey : "Downloading Error"])
//                    return Request.ValidationResult.failure(error)
//            }
//        }
    }
    
    func getCurrentTimeAsPathName() -> String{
      
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HHmmss"
        return formatter.string(from: Date())
    }
    
    
    //
    //  /**
    //   *  Download image and videos
    //   *
    //   *  @param serviceName  name of the service
    //   *  @param photoInfo  destination file name after download in DocumentDirectory
    //   *  @param ProgressClosure call back in block with download
    //   */
    //
    //  internal func requestApiToDownloadImage(serviceName: String,photoInfo: String,progressClosure: (totalBytesRead : Float) -> ()) -> Void {
    //
    //    let serviceUrl = kBASEURL + serviceName
    //
    //    NSLog("Connecting to Host with URL %@%@ jsonPara String: %@", kBASEURL, serviceName);
    //
    //    // Add AES authentication ...........
    //    let headers:[String:String] = getHeaderWithAPIName(serviceName)
    //
    //    let destination: (NSURL, NSHTTPURLResponse) -> (NSURL) = {
    //      (temporaryURL, response) in
    //
    //      let directoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    //      return directoryURL.URLByAppendingPathComponent("\(photoInfo).\(response.suggestedFilename)")
    //    }
    //    // 5
    //    Alamofire.download(.GET, serviceUrl, headers: headers, destination: destination).progress {
    //
    //      (_, totalBytesRead, totalBytesExpectedToRead) in
    //
    //      dispatch_async(dispatch_get_main_queue()) {
    //        // 6
    //        progressClosure(totalBytesRead:Float(totalBytesRead) / Float(totalBytesExpectedToRead))
    //        // 7
    //        if totalBytesRead == totalBytesExpectedToRead {
    //          progressClosure(totalBytesRead: 1.0)
    //        }
    //      }
    //    }
    //  }
    
  //MARK:- Private Method
    
  private func getHeaderWithAPIName(serviceName: String, username: String = "", password: String = "") -> HTTPHeaders{

    var headers: HTTPHeaders = ["accept": "application/json"]
    if let app = UIApplication.shared.delegate as? AppDelegate,  let window = app.window {
        window.isUserInteractionEnabled = true
    }

    if serviceName == APIUrl.kLogin {
      let credentialData = "\(username):\(password)".data(using: String.Encoding.utf8)!
      let base64Credentials = credentialData.base64EncodedString(options: [])
      headers["Authorization"] = "Basic \(base64Credentials)"
    }
    else{
    headers["Authorization"] = "Bearer " + String.getString(kSharedUserDefaults.loggedInUserModal.accessToken)
  //headers["Authorization"] = "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImY4ZmNjNzQ4OGJiYTZmNTk3MzA5ZDI5ODYxNTUzZmUwOWZjYzc4NzcxNmVlMGY4OWMyODg5MGUzYjM3OTVkYjc0N2U2MDAxMTI0ODA4MjY5In0.eyJhdWQiOiI1IiwianRpIjoiZjhmY2M3NDg4YmJhNmY1OTczMDlkMjk4NjE1NTNmZTA5ZmNjNzg3NzE2ZWUwZjg5YzI4ODkwZTNiMzc5NWRiNzQ3ZTYwMDExMjQ4MDgyNjkiLCJpYXQiOjE2NDM2NDU4MzEsIm5iZiI6MTY0MzY0NTgzMSwiZXhwIjoxNjc1MTgxODMxLCJzdWIiOiIxNzIzIiwic2NvcGVzIjpbXX0.UUlIsvedTz4VCYthxziIwz_CGydMJu9eXSV6laadzsOMwbtCfKJBgOdgSkkJMH2p5ughIpT49eFMbii1Sxby1CdkaPoStEr1Ul-ednd81Km3hMgfdZcl_RZYWNDJeGQJZepdwzmYplMG4OGpCmDXE1C-8ngFlTf13GKl3M3IpLmRIqrv034q9VXrbYB7yGMjrTth9CSLPTn0WmmOaNPHxaxyVie66BSTc7wYqjiHBuFq38svZaAAgBDvNQ66iZRpC2WLio7Vf_v61vnOkArNPA92yxquzR121Bi9k2ih_Wg-A-3QJ5reGp-uNxWTdPRlEaHV9ipbCJ0IyN8MXUysQLji0WqjUVt-rHf_9vysKlb7cq_ce_4QQfRY7gM_F2tTLvsF-QkA29CGN08ri_N-KHXPR-loP1iQn3x2rNp403ST08n_fZnkfB64fbd6XoynONnJeW_3c9lSymlR3u8doheaUvdCllDKREI5iBLIJ32_Yu6W-Z2N8uPZbeSnz-_b912CHFezpP9vKKmkUmcYYe0uwG7m1vU1s_igyTZv5vfgxbv9evJHHrabfUv6u00FD4JuPLLGE0_aFY57tGpWic11B2qf2-uusGFmVA77_JJ6dBwTkhaRJKos7U0IC414-IF3yoVxWeJWGjouq6et42KUxon0Pfz5QOJBg3HuETc"
    }

    headers["timezone"] = TimeZone.current.identifier
    return headers
  }

  private func getServiceUrl(string: String) -> String{
  
        if string.contains("http"){
          return string
        }
        else{
          return kBASEURL + string
        }
    }
    
    private func getPrintableParamsFromJson(postData: NonNullDictionary) -> String{
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
            return theJSONText ?? ""
        }
        catch let error as NSError
        {
            print( error)
            return ""
        }
    }
    
    private func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
          print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        }
        catch let error as NSError
        {
            print( "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    private func getResponseDataDictionaryFromData(data: Data) -> (responseData: NonNullDictionary?, error: Error?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NonNullDictionary
          print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        }
        catch let error
        {
            print( "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    func getCurrentTimeStamp()-> TimeInterval {
      
        return NSDate().timeIntervalSince1970.rounded();
    }
    
    private func addBodyParameters(inFormData multipartFormData: MultipartFormData, params postData:NonNullDictionary) -> Void{
      
        for (key, value) in postData
        {
            multipartFormData.append((self.toJSONData(value)), withName: key)
        }
    }
    
    private func checkAndConvertAllValuesToString(withDictParams params: NonNullDictionary) -> NonNullDictionary {
      
        var postData = params
        
        postData.keys.forEach {
            
            postData.updateValue(self.toJSONString((postData[$0] ?? "")), forKey: $0)
        }

        return postData
    }

    private func addImages(inFormData multipartFormData: MultipartFormData, imageList arrImages: [NonNullDictionary], keyImage imageKey: String, keyFileName fileNameKey: String, keyImageName imageNameKey: String) -> Void{
      
        
        for dictImage in arrImages
        {
            if let image = dictImage[imageKey] as? UIImage
            {
              if let imageData:Data = image.jpegData(compressionQuality: 0.7)
                {
                    var imgFileName = TANetworkManager.toString(dictImage[fileNameKey])

                    if imgFileName.isEmpty { imgFileName = self.createImageFileName() }

                    multipartFormData.append(imageData, withName: TANetworkManager.toString(dictImage[imageNameKey]), fileName: imgFileName, mimeType: TANetworkManager.IMG_MIMETYPE)
                }
            }
        }
    }
    
    private func addVideos(inFormData multipartFormData:MultipartFormData,videoList arrVideos:[NonNullDictionary],keyVideo videoKey:String, keyFileName fileNameKey:String, keyVideoName videoNameKey:String) -> Void{
      
        for dictVideo in arrVideos
        {
            if let video = dictVideo[videoKey] as? Data
            {
                var vidFileName = TANetworkManager.toString(dictVideo[fileNameKey])
                if vidFileName.isEmpty { vidFileName = self.createVideoFileName() }
                
                print("videoFileName",vidFileName,"videoNameKey",TANetworkManager.toString(dictVideo[videoNameKey]))
                print("dictVideo",dictVideo)

                multipartFormData.append(video, withName: TANetworkManager.toString(dictVideo[videoNameKey]), fileName:vidFileName, mimeType:TANetworkManager.VIDEO_MIMETYPE)
            }
        }
    }
    
    func toJSONData(_ value: Any) -> Data{
      
        if (value is String) || (value is NSNumber)
        {
            return (String(describing:value).data(using: String.Encoding.utf8)!)
        }
        
        if let objectData = try? JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions.prettyPrinted)
        {
            return objectData
        }
        
        return Data().base64EncodedData()
    }
    
    func toJSONString(_ value: Any) -> String
    {
        if value is String
        {
            return (value as! String)
        }
        
        if let objectData = try? JSONSerialization.data(withJSONObject: value, options: JSONSerialization.WritingOptions(rawValue: 0))
        {
            let objectString = String(data: objectData, encoding: .utf8)
            
            return objectString ?? ""
        }
        
        return ""
    }
    
    class func toString(_ object:Any?) -> String
    {
        if var str = object as? String
        {
            str = String(format: "%@", str)
            return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        if let num = object as? NSNumber
        {
            let str = String(format: "%@", num)
            return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        return ""
    }

    func createImageFileName(withIdentifier identifier:String = "") -> String
    {
        return "\(TANetworkManager.toString((self.getCurrentTimeStamp())))\(identifier)\(TANetworkManager.IMG_EXTENSION)"
    }
    
    func createVideoFileName(withIdentifier identifier:String = "") -> String
    {
        return "\(TANetworkManager.toString((self.getCurrentTimeStamp())))\(identifier)\(TANetworkManager.VID_EXTENSION)"
    }
}

