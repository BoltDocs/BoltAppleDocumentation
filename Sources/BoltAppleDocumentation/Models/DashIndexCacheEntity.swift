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

public struct IndexDBCacheEntity: Codable, TableRecord, FetchableRecord {

  public enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case requestKey = "request_key"
    case inheritance = "inheritance"
    case usr = "usr"
    case requestKeyAlias = "request_key_alias"
  }

  public static let databaseTableName = "cache"

  public var id: Int
  public var name: String
  public var requestKey: String
  public var inheritance: String?
  public var usr: String?
  public var requestKeyAlias: String

}
