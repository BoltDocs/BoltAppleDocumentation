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

import Compression
import Foundation

extension Data {

  func brotliDecompressed(bufferSize: Int = 65536) throws -> Data {
    var decompressed = Data()
    var currentIndex = startIndex
    let filter = try InputFilter(.decompress, using: .brotli) { (length: Int) -> Data? in
      guard currentIndex < endIndex else {
        return nil
      }
      let end = index(currentIndex, offsetBy: length, limitedBy: endIndex) ?? endIndex
      let chunk = self[currentIndex..<end]
      currentIndex = end
      return chunk
    }
    while let page = try filter.readData(ofLength: bufferSize) {
      decompressed.append(page)
    }
    return decompressed
  }

}
