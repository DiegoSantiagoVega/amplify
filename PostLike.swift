// swiftlint:disable all
import Amplify
import Foundation

public struct PostLike: Model {
  public let id: String
  internal var _post: LazyReference<Post>
  public var post: Post?   {
      get async throws { 
        try await _post.get()
      } 
    }
  internal var _user: LazyReference<User>
  public var user: User?   {
      get async throws { 
        try await _user.get()
      } 
    }
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      post: Post? = nil,
      user: User? = nil) {
    self.init(id: id,
      post: post,
      user: user,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      post: Post? = nil,
      user: User? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self._post = LazyReference(post)
      self._user = LazyReference(user)
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
  public mutating func setPost(_ post: Post? = nil) {
    self._post = LazyReference(post)
  }
  public mutating func setUser(_ user: User? = nil) {
    self._user = LazyReference(user)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      _post = try values.decodeIfPresent(LazyReference<Post>.self, forKey: .post) ?? LazyReference(identifiers: nil)
      _user = try values.decodeIfPresent(LazyReference<User>.self, forKey: .user) ?? LazyReference(identifiers: nil)
      createdAt = try? values.decode(Temporal.DateTime?.self, forKey: .createdAt)
      updatedAt = try? values.decode(Temporal.DateTime?.self, forKey: .updatedAt)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(_post, forKey: .post)
      try container.encode(_user, forKey: .user)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(updatedAt, forKey: .updatedAt)
  }
}