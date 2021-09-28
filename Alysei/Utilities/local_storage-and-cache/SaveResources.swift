//
//  SaveResources.swift
//  Alysei
//
//  Created by Janu Gandhi on 24/03/21.
//

import Foundation
import UIKit


// class for downloading and saving image
class LocalStorage {
    static let shared = LocalStorage()


    func saveImage(_ imageURLString: String, fileName: String) {
        let imageURLEncodedString = imageURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let imageURL = URL(string: imageURLEncodedString) else {  return }

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: fileURL.relativePath) {
            print("file exists")
            return
        }

        DispatchQueue.global(qos: .background).async {
            guard let data = NSData(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.writeImageToDisk(Data(referencing: data), fileName: fileName)
            }
        }
    }


    func saveImage(_ imageData: Data?, fileName: String) {
        self.writeImageToDisk(imageData, fileName: fileName)
    }

    private func writeImageToDisk(_ imageData: Data?, fileName: String) {
        guard let data = imageData else { return }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        do {
            if FileManager.default.fileExists(atPath: fileURL.relativePath) {
                print("file exists")
                try FileManager.default.removeItem(atPath: fileURL.relativePath)
            }
            try data.write(to: fileURL)
            print("file saved")
        } catch {
            print("error saving file:", error)
        }
    }

    func fetchImage(_ fileName: String) -> UIImage? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        if let data = try? Data(contentsOf: fileURL) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }

    func deleteImage(_ fileName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }

}

