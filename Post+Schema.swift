// swiftlint:disable all
import Amplify
import Foundation

extension Post {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case title
    case content
    case author
    case createdAt
    case updatedAt
    case published
    case publishedAt
    case coverImageUrl
    case tags
    case postLikes
    case comments
    case views
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let post = Post.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Posts"
    model.syncPluralName = "Posts"
    
    model.attributes(
      .index(fields: ["id"], name: nil),
      .primaryKey(fields: [post.id])
    )
    
    model.fields(
      .field(post.id, is: .required, ofType: .string),
      .field(post.title, is: .required, ofType: .string),
      .field(post.content, is: .required, ofType: .string),
      .belongsTo(post.author, is: .optional, ofType: User.self, targetNames: ["authorId"]),
      .field(post.createdAt, is: .required, ofType: .dateTime),
      .field(post.updatedAt, is: .required, ofType: .dateTime),
      .field(post.published, is: .required, ofType: .bool),
      .field(post.publishedAt, is: .optional, ofType: .dateTime),
      .field(post.coverImageUrl, is: .required, ofType: .string),
      .field(post.tags, is: .optional, ofType: .string),
      .hasMany(post.postLikes, is: .optional, ofType: PostLike.self, associatedFields: [PostLike.keys.post]),
      .hasMany(post.comments, is: .optional, ofType: PostComment.self, associatedFields: [PostComment.keys.post]),
      .field(post.views, is: .optional, ofType: .double)
    )
    }
    public class Path: ModelPath<Post> { }
    
    public static var rootPath: PropertyContainerPath? { Path() }
}

extension Post: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}
extension ModelPath where ModelType == Post {
  public var id: FieldPath<String>   {
      string("id") 
    }
  public var title: FieldPath<String>   {
      string("title") 
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
  public var published: FieldPath<Bool>   {
      bool("published") 
    }
  public var publishedAt: FieldPath<Temporal.DateTime>   {
      datetime("publishedAt") 
    }
  public var coverImageUrl: FieldPath<String>   {
      string("coverImageUrl") 
    }
  public var tags: FieldPath<String>   {
      string("tags") 
    }
  public var postLikes: ModelPath<PostLike>   {
      PostLike.Path(name: "postLikes", isCollection: true, parent: self) 
    }
  public var comments: ModelPath<PostComment>   {
      PostComment.Path(name: "comments", isCollection: true, parent: self) 
    }
  public var views: FieldPath<Double>   {
      double("views") 
    }
}