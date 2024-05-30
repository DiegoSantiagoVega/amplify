// swiftlint:disable all
import Amplify
import Foundation

extension User {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case firstName
    case lastName
    case username
    case phoneNumber
    case email
    case bio
    case profilePictureUrl
    case posts
    case postComments
    case postLikes
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let user = User.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Users"
    model.syncPluralName = "Users"
    
    model.attributes(
      .index(fields: ["id"], name: nil),
      .primaryKey(fields: [user.id])
    )
    
    model.fields(
      .field(user.id, is: .required, ofType: .string),
      .field(user.firstName, is: .required, ofType: .string),
      .field(user.lastName, is: .required, ofType: .string),
      .field(user.username, is: .required, ofType: .string),
      .field(user.phoneNumber, is: .optional, ofType: .string),
      .field(user.email, is: .required, ofType: .string),
      .field(user.bio, is: .optional, ofType: .string),
      .field(user.profilePictureUrl, is: .required, ofType: .string),
      .hasMany(user.posts, is: .optional, ofType: Post.self, associatedFields: [Post.keys.author]),
      .hasMany(user.postComments, is: .optional, ofType: PostComment.self, associatedFields: [PostComment.keys.author]),
      .hasMany(user.postLikes, is: .optional, ofType: PostLike.self, associatedFields: [PostLike.keys.user]),
      .field(user.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(user.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<User> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension User: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == User {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var firstName: FieldPath<String>   {
      string("firstName") 
    }
  public var lastName: FieldPath<String>   {
      string("lastName") 
    }
  public var username: FieldPath<String>   {
      string("username") 
    }
  public var phoneNumber: FieldPath<String>   {
      string("phoneNumber") 
    }
  public var email: FieldPath<String>   {
      string("email") 
    }
  public var bio: FieldPath<String>   {
      string("bio") 
    }
  public var profilePictureUrl: FieldPath<String>   {
      string("profilePictureUrl") 
    }
  public var posts: ModelPath<Post>   {
      Post.Path(name: "posts", isCollection: true, parent: self) 
    }
  public var postComments: ModelPath<PostComment>   {
      PostComment.Path(name: "postComments", isCollection: true, parent: self) 
    }
  public var postLikes: ModelPath<PostLike>   {
      PostLike.Path(name: "postLikes", isCollection: true, parent: self) 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}