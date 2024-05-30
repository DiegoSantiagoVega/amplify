// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "b6ecf7b8e07d909be5da6d140754243b"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: User.self)
    ModelRegistry.register(modelType: Post.self)
    ModelRegistry.register(modelType: PostComment.self)
    ModelRegistry.register(modelType: PostLike.self)
  }
}