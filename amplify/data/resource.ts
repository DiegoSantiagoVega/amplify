import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  User: a
    .model({
      id: a.id().required(),
      firstName: a.string().required(),
      lastName: a.string().required(),
      username: a.string().required(),
      phoneNumber: a.string(),
      email: a.string().required(),
      bio: a.string(),
      profilePictureUrl: a.string().required(),
      posts: a.hasMany('Post', 'authorId'),
      postComments: a.hasMany('PostComment', 'authorId'),
      postLikes: a.hasMany('PostLike', 'userId'),
    })
    .authorization((allow) => [allow.owner()]),
    // generate a Post schema, so that a user can have many posts
    Post: a.model({
      id: a.id().required(),
      title: a.string().required(),
      content: a.string().required(),
      authorId: a.string().required(),
      author: a.belongsTo('User', 'authorId'),
      createdAt: a.datetime().required(),
      updatedAt: a.datetime().required(),
      published: a.boolean().required(),
      publishedAt: a.datetime(),
      coverImageUrl: a.string().required(),
      tags: a.string(),
      postLikes: a.hasMany('PostLike', 'postId'),
      comments: a.hasMany('PostComment', 'postId'),
      views: a.float(),
    }).authorization((allow) => [allow.owner()]),
    // generate a postComment schema so a post can have many comments from different users
    PostComment: a.model({
      id: a.id().required(),
      content: a.string().required(),
      authorId: a.id().required(),
      author: a.belongsTo('User', 'authorId'),
      createdAt: a.datetime().required(),
      updatedAt: a.datetime().required(),
      postId: a.string().required(),
      post: a.belongsTo('Post', 'postId'),
    }).authorization((allow) => [allow.owner()]),
    PostLike: a
    .model({
      id: a.id().required(),
      postId: a.id().required(),
      post: a.belongsTo('Post', 'postId'),
      userId: a.id().required(),
      user: a.belongsTo('User', 'userId'),
    })
    .authorization((allow) => [allow.owner()]),
    // add Winery schema
    // Winery: a.model({
    //   id: a.id().required(),
    //   name: a.string().required(),
    //   location: a.string().required(),
    //   description: a.string().required(),
    //   website: a.string().required(),
    //   image: a.string().required(),
    //   posts: a.hasMany('Post', 'wineryId'),
    //   // give me more data
    //   wineryType: a.string().required(),
    //   wineryRegion: a.string().required(),
    //   wineryCountry: a.string().required(),
    //   wineryYear: a.string().required(),
    //   wineryAge: a.string().required(),
    //   wineryAwards: a.string().required(),
    // }).authorization((allow) => [allow.owner()]),
    // // add Wine schema
    // Wine: a.model({
    //   id: a.id().required(),
    //   name: a.string().required(),
    //   description: a.string().required(),
    //   image: a.string().required(),
    //   price: a.float().required(),
    //   wineryId: a.string().required(),
    //   winery: a.belongsTo('Winery', 'wineryId'),
    //   tags: a.string(),
    //   rating: a.float(),
    //   reviews: a.hasMany('Review', 'wineId'),
    //   // grape type as a foreign key of a GrapeType schema
    //   grapeType: a.string().required(),
    //   grapeTypeObj: a.belongsTo('GrapeType', 'grapeType'),
    //   // add a field to store the wine's region
    //   region: a.string().required(),
    //   // add a field to store the wine's country
    //   country: a.string().required(),
    //   // add a field to store the wine's year
    //   year: a.string().required(),
    //   // add a field to store the wine's age
    //   age: a.string().required(),
    //   // add a field to store the wine's awards
    //   awards: a.string().required(),
    //   // add a field to store the wine's type
    //   type: a.string().required(),
    // }).authorization((allow) => [allow.owner()]),

});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
