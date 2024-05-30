// swiftlint:disable all
import Amplify
import Foundation

extension PostComment {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case content
    case author
    case createdAt
    case updatedAt
    case post
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let postComment = PostComment.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "PostComments"
    model.syncPluralName = "PostComments"
    
    model.attributes(
      .index(fields: ["id"], name: nil),
      .primaryKey(fields: [postComment.id])
    )
    
    model.fields(
      .field(postComment.id, is: .required, ofType: .string),
      .field(postComment.content, is: .required, ofType: .string),
      .belongsTo(postComment.author, is: .optional, ofType: User.self, targetNames: ["authorId"]),
      .field(postComment.createdAt, is: .required, ofType: .dateTime),
      .field(postComment.updatedAt, is: .required, ofType: .dateTime),
      .belongsTo(postComment.post, is: .optional, ofType: Post.self, targetNames: ["postId"])
    )
    }
    public class Path: ModelPath<PostComment> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension PostComment: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == PostComment {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var content: FieldPath<String>   {
      string("content") 
    }
  public var author: ModelPath<User>   {
      User.Path(name: "author", parent: self) 
    }
  public var createdAt: FieldPath<Temporal.DateTime>   {
      datetime("createdAt") 
    }
  public var updatedAt: FieldPath<Temporal.DateTime>   {
      datetime("updatedAt") 
    }
  public var post: ModelPath<Post>   {
      Post.Path(name: "post", parent: self) 
    }
}