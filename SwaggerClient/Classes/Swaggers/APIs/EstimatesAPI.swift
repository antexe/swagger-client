//
// EstimatesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



open class EstimatesAPI: APIBase {
    /**
     Price Estimates
     
     - parameter startLatitude: (query) Latitude component of start location. 
     - parameter startLongitude: (query) Longitude component of start location. 
     - parameter endLatitude: (query) Latitude component of end location. 
     - parameter endLongitude: (query) Longitude component of end location. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func estimatesPriceGet(startLatitude: Double, startLongitude: Double, endLatitude: Double, endLongitude: Double, completion: @escaping ((_ data: [InlineResponse2001]?,_ error: Error?) -> Void)) {
        estimatesPriceGetWithRequestBuilder(startLatitude: startLatitude, startLongitude: startLongitude, endLatitude: endLatitude, endLongitude: endLongitude).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Price Estimates
     - GET /estimates/price
     - The Price Estimates endpoint returns an estimated price range for each product offered at a given location. The price estimate is provided as a formatted string with the full price range and the localized currency symbol.<br><br>The response also includes low and high estimates, and the [ISO 4217](http://en.wikipedia.org/wiki/ISO_4217) currency code for situations requiring currency conversion. When surge is active for a particular product, its surge_multiplier will be greater than 1, but the price estimate already factors in this multiplier. 
     - examples: [{contentType=application/json, example=[ {
  "high_estimate" : 1.3579000000000001069366817318950779736042022705078125,
  "product_id" : "aeiou",
  "low_estimate" : 1.3579000000000001069366817318950779736042022705078125,
  "surge_multiplier" : 1.3579000000000001069366817318950779736042022705078125,
  "estimate" : "aeiou",
  "display_name" : "aeiou",
  "currency_code" : "aeiou"
} ]}]
     
     - parameter startLatitude: (query) Latitude component of start location. 
     - parameter startLongitude: (query) Longitude component of start location. 
     - parameter endLatitude: (query) Latitude component of end location. 
     - parameter endLongitude: (query) Longitude component of end location. 

     - returns: RequestBuilder<[InlineResponse2001]> 
     */
    open class func estimatesPriceGetWithRequestBuilder(startLatitude: Double, startLongitude: Double, endLatitude: Double, endLongitude: Double) -> RequestBuilder<[InlineResponse2001]> {
        let path = "/estimates/price"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "start_latitude": startLatitude, 
            "start_longitude": startLongitude, 
            "end_latitude": endLatitude, 
            "end_longitude": endLongitude
        ])
        

        let requestBuilder: RequestBuilder<[InlineResponse2001]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Time Estimates
     
     - parameter startLatitude: (query) Latitude component of start location. 
     - parameter startLongitude: (query) Longitude component of start location. 
     - parameter customerUuid: (query) Unique customer identifier to be used for experience customization. (optional)
     - parameter productId: (query) Unique identifier representing a specific product for a given latitude &amp; longitude. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func estimatesTimeGet(startLatitude: Double, startLongitude: Double, customerUuid: UUID? = nil, productId: String? = nil, completion: @escaping ((_ data: [InlineResponse200]?,_ error: Error?) -> Void)) {
        estimatesTimeGetWithRequestBuilder(startLatitude: startLatitude, startLongitude: startLongitude, customerUuid: customerUuid, productId: productId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Time Estimates
     - GET /estimates/time
     - The Time Estimates endpoint returns ETAs for all products offered at a given location, with the responses expressed as integers in seconds. We recommend that this endpoint be called every minute to provide the most accurate, up-to-date ETAs.
     - examples: [{contentType=application/json, example=[ {
  "image" : "aeiou",
  "product_id" : "aeiou",
  "description" : "aeiou",
  "display_name" : "aeiou",
  "capacity" : "aeiou"
} ]}]
     
     - parameter startLatitude: (query) Latitude component of start location. 
     - parameter startLongitude: (query) Longitude component of start location. 
     - parameter customerUuid: (query) Unique customer identifier to be used for experience customization. (optional)
     - parameter productId: (query) Unique identifier representing a specific product for a given latitude &amp; longitude. (optional)

     - returns: RequestBuilder<[InlineResponse200]> 
     */
    open class func estimatesTimeGetWithRequestBuilder(startLatitude: Double, startLongitude: Double, customerUuid: UUID? = nil, productId: String? = nil) -> RequestBuilder<[InlineResponse200]> {
        let path = "/estimates/time"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "start_latitude": startLatitude, 
            "start_longitude": startLongitude, 
            "customer_uuid": customerUuid, 
            "product_id": productId
        ])
        

        let requestBuilder: RequestBuilder<[InlineResponse200]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
