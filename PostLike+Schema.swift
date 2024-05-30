// swiftlint:disable all
import Amplify
import Foundation

extension PostLike {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case post
    case user
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let postLike = PostLike.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "PostLikes"
    model.syncPluralName = "PostLikes"
    
    model.attributes(
      .index(fields: ["id"], name: nil),
      .primaryKey(fields: [postLike.id])
    )
    
    model.fields(
      .field(postLike.id, is: .required, ofType: .string),
      .belongsTo(postLike.post, is: .optional, ofType: Post.self, targetNames: ["postId"]),
      .belongsTo(postLike.user, is: .optional, ofType: User.self, targetNames: ["userId"]),
      .field(postLike.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(postLike.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
    public class Path: ModelPath<PostLike> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension PostLike: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == PostLike {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var post: ModelPath<Post>   {
      Post.Path(name: "post", parent: self) 
    }
  public var user: ModelPath<User>   {
      User.Path(name: "user", parent: self) 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
}