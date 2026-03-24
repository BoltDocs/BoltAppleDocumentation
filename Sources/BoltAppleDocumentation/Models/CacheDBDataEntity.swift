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

import GRDB

public struct CacheDBDataEntity: Codable, TableRecord, FetchableRecord {

  public enum CodingKeys: String, CodingKey  {
    case rowId = "row_id"
    case data = "data"
    case isCompressed = "is_compressed"
  }

  public static let databaseTableName = "data"

  public var rowId: String
  public var data: Data?
  public var isCompressed: Bool

}
