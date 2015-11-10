//
// HomeAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire

extension SwaggerClientAPI {
    
    public class HomeAPI: APIBase {
    
        /**
         
         Home Information
         
         - GET /home
         - The Products endpoint returns information about the *Uber* products\noffered at a given location. The response includes the display name\nand other details about each product, and lists the products in the\nproper display order.
         - examples: [{contentType=application/json, example={
  "sound" : 1.3579000000000001069366817318950779736042022705078125,
  "temperature" : 1.3579000000000001069366817318950779736042022705078125,
  "humidity" : 1.3579000000000001069366817318950779736042022705078125,
  "home_id" : 1.3579000000000001069366817318950779736042022705078125,
  "vibration" : 1.3579000000000001069366817318950779736042022705078125,
  "dust" : 1.3579000000000001069366817318950779736042022705078125
}}]
         
         - parameter location: (query) home id

         - returns: RequestBuilder<Home> 
         */
        public class func homeGet(location location: Double) -> RequestBuilder<Home> {
            let path = "/home"
            let URLString = SwaggerClientAPI.basePath + path
            
            let nillableParameters: [String:AnyObject?] = [
                "location": location
            ]
            let parameters = APIHelper.rejectNil(nillableParameters)

            let requestBuilder: RequestBuilder<Home>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

            return requestBuilder.init(method: "GET", URLString: URLString, parameters: parameters, isBody: false)
        }
    
    }
}
