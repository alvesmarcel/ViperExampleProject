// Abstract: This class provides methods to download content from the internet

import Foundation

class NetworkService {
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func requestDataFromURL(url: URL, completionHandler: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let task = session.dataTask(with: url) {(data, _, error) in
            guard let receivedData = data else {
                completionHandler(nil, error)
                return
            }
            completionHandler(receivedData, nil)
        }
        task.resume()
    }
    
}
