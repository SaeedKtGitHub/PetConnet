class AppLink {
  static String server = "http://149.200.255.255:47055";
  static String linkImageRoot = "$server/uploads/images";

  //Auth
  static String signUp = "$server/users/addUser";
  static String login = "$server/users/login";
  //POST
  static String addPost = "$server/posts/addPost";
  static String getUserPets = "$server/users/getPets";
  static String getAllPosts = "$server/posts/getAll";
  static String getUser = "$server/users/getUser";
  static String addPet = "$server/pets/add";
  static String removePet = "$server/pets/delete";
  static String getPostsByTag = "$server/posts/getByTag";
  static String getAllArticles = "$server/articles/getAll";

  static String addProfilePic = "$server/users/addProfilePic";
  static String addPhone = "$server/users/addPhone";
  static String privacyPolicy = "$server/privacypolicy";
  static String termsCondition = "$server/termsofuse";
  static String getUserPosts = "$server/users/getPosts";
  static String removePost = "$server/posts/delete";
  static String addComment = "$server/posts/addComment";
  static String getComments = "$server/posts/getComments";
  static String deleteComment = "$server/posts/deleteComment";
  static String likeOrDislike = "$server/posts/like";
}
