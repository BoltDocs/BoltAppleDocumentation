//
// Copyright (C) 2026 Bolt Contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

import BoltUtils

public struct AppleDocFileSystem {

  public enum Error: LocalizedError {

    case dataFileloadFailed(path: String, underlyingError: Swift.Error)
    case decompressFailed(underlyingError: Swift.Error)
    case invalidDataRange

    public var errorDescription: String? {
      switch self {
      case let .dataFileloadFailed(path, underlyingError):
        return "Failed to load documentation data file at path: \(path), error: \(underlyingError.localizedDescription)"
      case let .decompressFailed(underlyingError):
        return "Failed to decompress documentation data: \(underlyingError.localizedDescription)"
      case .invalidDataRange:
        return "Invalid data range: offset and length exceed data bounds."
      }
    }

  }

  public static func documentationData(
    forData data: Data,
    offset: Int,
    length: Int,
    isCompressed: Bool
  ) throws -> Data {
    var subData = data
    if isCompressed {
      do {
        subData = try subData.brotliDecompressed()
      } catch {
        throw Error.decompressFailed(underlyingError: error)
      }
    }
    guard offset >= 0, length >= 0, length <= subData.count - offset else {
      throw Error.invalidDataRange
    }
    return subData[offset..<offset + length]
  }

  public static func documentationData(
    forRootPath rootPath: String,
    fileID: Int,
    offset: Int,
    length: Int,
    isCompressed: Bool
  ) throws -> Data {
    let filePath = rootPath.appendingPathComponent("fs/\(fileID)")
    let data: Data
    do {
      data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    } catch {
      throw Error.dataFileloadFailed(path: filePath, underlyingError: error)
    }
    return try documentationData(forData: data, offset: offset, length: length, isCompressed: isCompressed)
  }

}
