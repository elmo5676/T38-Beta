//
//  Downloader.swift
//  unZip
//
//  Created by Matthew Elmore on 5/10/19.
//  Copyright © 2019 Matthew Elmore. All rights reserved.
//

import Foundation

struct DAFIFDownloader {
    let myDocuments: URL
    var wantedData: [FileNames]?

    init(myDocuments: URL,
         wantedData: [FileNames]?,
         completion: (([FileNames]?)->Void)?) {
        self.wantedData = wantedData
        self.myDocuments = myDocuments
        print(self.myDocuments)
        downloadTheBigFuckingDocument(completion: completion)
    }
    
    fileprivate func downloadTheBigFuckingDocument(completion: (([FileNames]?)->Void)?) {
        let url = URL(string: "https:/s3-us-west-2.amazonaws.com/9ogv-filestorage/DAFIF/DAFIF8.zip")!
        let destination = myDocuments
        let destinationURL = destination.appendingPathComponent("DAFIF8.zip")
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.downloadTask(with: request) { (tempLocalURL, urlResponse, error) in
            if let localURL = tempLocalURL, error == nil {
                //successful download, proceeeeeeed
                if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded from \(url). Recieved HTTP Status code of \(statusCode). Elmo, a 200 is what you want here.  If it says 301 or 302, the link moved.  If it says anything with 400, you fucked up.  If it's a 500 series, their server is fucked up")
                }
                do {
                    if let _ = NSData(contentsOf: destinationURL) {
                        try FileManager.default.removeItem(at: destinationURL)
                    }
                    try FileManager.default.copyItem(at: localURL, to: destinationURL)
                    if let stuff = completion {
                        stuff(self.wantedData)
                    }
                } catch (let writeError) {
                    print("We encountered a no-no while trying to do a yes-yes.  Here's what is was: \(writeError)")
                }
            } else {
                print("You fucked up, you trusted us.")
                print("but seriously, this was the error (ass-hat): \(error!)")
            }}
        task.resume()
        
    }
}
