// swiftlint:disable all
import Amplify
import Foundation

public struct User: Model {
  public let id: String
  public var firstName: String
  public var lastName: String
  public var username: String
  public var phoneNumber: String?
  public var email: String
  public var bio: String?
  public var profilePictureUrl: String
  public var posts: List<Post>?
  public var postComments: List<PostComment>?
  public var postLikes: List<PostLike>?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      firstName: String,
      lastName: String,
      username: String,
      phoneNumber: String? = nil,
      email: String,
      bio: String? = nil,
      profilePictureUrl: String,
      posts: List<Post>? = [],
      postComments: List<PostComment>? = [],
      postLikes: List<PostLike>? = []) {
    self.init(id: id,
      firstName: firstName,
      lastName: lastName,
      username: username,
      phoneNumber: phoneNumber,
      email: email,
      bio: bio,
      profilePictureUrl: profilePictureUrl,
      posts: posts,
      postComments: postComments,
      postLikes: postLikes,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      firstName: String,
      lastName: String,
      username: String,
      phoneNumber: String? = nil,
      email: String,
      bio: String? = nil,
      profilePictureUrl: String,
      posts: List<Post>? = [],
      postComments: List<PostComment>? = [],
      postLikes: List<PostLike>? = [],
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.firstName = firstName
      self.lastName = lastName
      self.username = username
      self.phoneNumber = phoneNumber
      self.email = email
      self.bio = bio
      self.profilePictureUrl = profilePictureUrl
      self.posts = posts
      self.postComments = postComments
      self.postLikes = postLikes
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}