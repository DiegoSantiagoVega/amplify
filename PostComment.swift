// swiftlint:disable all
import Amplify
import Foundation

public struct PostComment: Model {
  public let id: String
  public var content: String
  internal var _author: LazyReference<User>
  public var author: User?   {
      get async throws { 
        try await _author.get()
      } 
    }
  public var createdAt: Temporal.DateTime
  public var updatedAt: Temporal.DateTime
  internal var _post: LazyReference<Post>
  public var post: Post?   {
      get async throws { 
        try await _post.get()
      } 
    }
  
  public init(id: String = UUID().uuidString,
      content: String,
      author: User? = nil,
      createdAt: Temporal.DateTime,
      updatedAt: Temporal.DateTime,
      post: Post? = nil) {
      self.id = id
      self.content = content
      self._author = LazyReference(author)
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self._post = LazyReference(post)
  }
  public mutating func setAuthor(_ author: User? = nil) {
    self._author = LazyReference(author)
  }
  public mutating func setPost(_ post: Post? = nil) {
    self._post = LazyReference(post)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      content = try values.decode(String.self, forKey: .content)
      _author = try values.decodeIfPresent(LazyReference<User>.self, forKey: .author) ?? LazyReference(identifiers: nil)
      createdAt = try values.decode(Temporal.DateTime.self, forKey: .createdAt)
      updatedAt = try values.decode(Temporal.DateTime.self, forKey: .updatedAt)
      _post = try values.decodeIfPresent(LazyReference<Post>.self, forKey: .post) ?? LazyReference(identifiers: nil)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(content, forKey: .content)
      try container.encode(_author, forKey: .author)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(updatedAt, forKey: .updatedAt)
      try container.encode(_post, forKey: .post)
  }
}