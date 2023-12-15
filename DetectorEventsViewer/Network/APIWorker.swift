//
//  APIWorker.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import Alamofire
import Foundation

class APIWorker {
    init () { 
    }

    func checkUserLogin(name: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
        AF.request("http://\(name):\(password)@try.axxonsoft.com:8000/asip-api/product/version").responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                completion(true)
            case .failure(_):
                completion(false)
            }
        })
    }
    
    func loadEvents(completion: @escaping ([Event]) -> ()) {
        AF.request("http://root:root@try.axxonsoft.com:8000/asip-api/archive/events/detectors/past/future?join=1").response { response in
            guard let data = response.data else {
                print("RESPONSE_DATA_ERROR")
                return
            }
        
            guard let responseModel = try? JSONDecoder().decode(EventsResponse.self, from: data) else {
                print("RESPONSE_MODEL_ERROR")
                return
            }
            
            completion(responseModel.actualEvents)
        }
    }
    
    func loadVideos(completion: @escaping ([Camera]) -> ()) {
        AF.request("http://root:root@try.axxonsoft.com:8000/asip-api/camera/list?filter=DEMOSERVER").response { response in
            guard let data = response.data else {
                print("RESPONSE_DATA_ERROR")
                return
            }
        
            guard let responseModel = try? JSONDecoder().decode(CamerasResponse.self, from: data) else {
                print("RESPONSE_MODEL_ERROR")
                return
            }
            
            completion(responseModel.actualCameras)
        }
    }
    
}

