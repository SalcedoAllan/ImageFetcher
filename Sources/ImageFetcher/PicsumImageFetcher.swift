//
//  PicsumImageFetcher.swift
//  PicsumInterviewProject
//
//  Created by Jackal on 4/14/23.
//

import Combine
import UIKit

enum RequestError: Error {
    case invalidURL
    case invalidData
}

public class PicsumImageFetcher: ObservableObject {
    @Published public var image: UIImage?

    public init(image: UIImage? = nil) {
        self.image = image
    }

    public func fetchNewImage(urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
        guard let image = UIImage(data: imageData) else {
            throw RequestError.invalidData
        }
        await MainActor.run {
            self.image = image
        }
    }

    public func doSomnethingElse() {

    }
}
