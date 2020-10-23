//
//  DownloaderContarct.swift
//  Downloader
//
//  Created by Sushant Deshmukh on 22/10/20.
//  Copyright © 2020 Sushant Deshmukh. All rights reserved.
//

public typealias DownloadCompletion =  (PhotoDownloadResult) -> ()
public typealias CancelDowloading = () -> Void
protocol DownloaderContract {
    func loadImage(with url: String, completion :@escaping (DownloadCompletion)) -> CancelDowloading
    func cancelSession()
}
