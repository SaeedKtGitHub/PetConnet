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
  static String getProfilePic = "$server/users/getProfilePic";
  static String addPhone = "$server/users/addPhone";
  static String deletePhone = "$server/users/deletePhone";
  static String deleteAccount = "$server/users/delete";
  static String privacyPolicy = "$server/privacypolicy";
  static String termsCondition = "$server/termsofuse";
}
