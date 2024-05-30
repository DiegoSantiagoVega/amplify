// swiftlint:disable all
import Amplify
import Foundation

public struct Post: Model {
  public let id: String
  public var title: String
  public var content: String
  internal var _author: LazyReference<User>
  public var author: User?   {
      get async throws { 
        try await _author.get()
      } 
    }
  public var createdAt: Temporal.DateTime
  public var updatedAt: Temporal.DateTime
  public var published: Bool
  public var publishedAt: Temporal.DateTime?
  public var coverImageUrl: String
  public var tags: String?
  public var postLikes: List<PostLike>?
  public var comments: List<PostComment>?
  public var views: Double?
  
  public init(id: String = UUID().uuidString,
      title: String,
      content: String,
      author: User? = nil,
      createdAt: Temporal.DateTime,
      updatedAt: Temporal.DateTime,
      published: Bool,
      publishedAt: Temporal.DateTime? = nil,
      coverImageUrl: String,
      tags: String? = nil,
      postLikes: List<PostLike>? = [],
      comments: List<PostComment>? = [],
      views: Double? = nil) {
      self.id = id
      self.title = title
      self.content = content
      self._author = LazyReference(author)
      self.createdAt = createdAt
      self.updatedAt = updatedAt
      self.published = published
      self.publishedAt = publishedAt
      self.coverImageUrl = coverImageUrl
      self.tags = tags
      self.postLikes = postLikes
      self.comments = comments
      self.views = views
  }
  public mutating func setAuthor(_ author: User? = nil) {
    self._author = LazyReference(author)
  }
  public init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      id = try values.decode(String.self, forKey: .id)
      title = try values.decode(String.self, forKey: .title)
      content = try values.decode(String.self, forKey: .content)
      _author = try values.decodeIfPresent(LazyReference<User>.self, forKey: .author) ?? LazyReference(identifiers: nil)
      createdAt = try values.decode(Temporal.DateTime.self, forKey: .createdAt)
      updatedAt = try values.decode(Temporal.DateTime.self, forKey: .updatedAt)
      published = try values.decode(Bool.self, forKey: .published)
      publishedAt = try? values.decode(Temporal.DateTime?.self, forKey: .publishedAt)
      coverImageUrl = try values.decode(String.self, forKey: .coverImageUrl)
      tags = try? values.decode(String?.self, forKey: .tags)
      postLikes = try values.decodeIfPresent(List<PostLike>?.self, forKey: .postLikes) ?? .init()
      comments = try values.decodeIfPresent(List<PostComment>?.self, forKey: .comments) ?? .init()
      views = try? values.decode(Double?.self, forKey: .views)
  }
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(title, forKey: .title)
      try container.encode(content, forKey: .content)
      try container.encode(_author, forKey: .author)
      try container.encode(createdAt, forKey: .createdAt)
      try container.encode(updatedAt, forKey: .updatedAt)
      try container.encode(published, forKey: .published)
      try container.encode(publishedAt, forKey: .publishedAt)
      try container.encode(coverImageUrl, forKey: .coverImageUrl)
      try container.encode(tags, forKey: .tags)
      try container.encode(postLikes, forKey: .postLikes)
      try container.encode(comments, forKey: .comments)
      try container.encode(views, forKey: .views)
  }
}