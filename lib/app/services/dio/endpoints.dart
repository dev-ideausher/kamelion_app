class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.kamelion.co/v1/";

  //endpoints
  static const String verifyLisenceKey = "sendlicensekey/save";
  static const String signUp = "auth/register";
  static const String login = "auth/login";
  static const String getOnboardingQuestions = "question/getallquestions";
  static String getMentalGymQuestions(String id) => "quiz/getquiz/$id";
  static String markOpenedCommunity(String id) => "community/markopened/$id";
  static const String getUser = "users/getUser";
  static const String createAvatar = "avatar/save";
  static const String saveUser = "userinfo/save";
  static const String uploadFile = "users/fileupload";
  static String updateUser(String id) => "users/updateuser/$id";
  static String getMood(String id, String timezone) =>
      "/mood/getmoods/$id?timezone=$timezone";
  static const String addMood = "mood/save";
  static String deleteAccount(String id) => "users/deleteuser/$id";
  static const String getMentalGymCategiries = "category/all-category";
  static String getActiveMentalGym({
    required String page,
    required String limit,
  }) => "mentalgym/getallmentalgyms?isActive=true&page=$page&limit=$limit";
  static String searchMentalGym({
    required String page,
    required String limit,
    required String word,
  }) => "mentalgym/getallmentalgyms?search=$word&page=$page&limit=$limit";
  static String getYourCommunities({
    required String page,
    required String limit,
  }) => "community/getcommunitys";
  static String getTrendingMentalGyms({
    required String page,
    required String limit,
  }) => "mentalgym/getallmentalgyms?isTrending=true";
  static String getSuggestedMentalGyms(String id) =>
      "mentalgym/getallsuggestedmentalgyms/$id";
  static String getSavedMentalGyms(String id) => "savedmentalgym/get/$id";
  static String getMentalGymsByCategory(String id) =>
      "mentalgym/getallmental/$id";
  static String getMentalGymsDetails(String id) => "workout/getallworkout/$id";
  static String getCommunityDetails(String id) => "post/getcommunityposts/$id";
  static String addLikePost(String id) => "postinteraction/$id/like";
  static String addComment(String id) => "postinteraction/$id/comment";
  static String startMentalGym(String id) => "mentalgym/getmentalgym/$id";
  static String getComments(String id) => "postinteraction/$id/comments";
  static String saveMentalGyms = "savedmentalgym/save";
  static String updateMentalGym(String id) => "mentalgym/update/$id";
  static String updateCommunity(String id) => "community/update/$id";
  static String updatePost(String id) => "post/update/$id";
  static String deletePost(String id) => "post/delete/$id";
  static String savePost = "post/addfavourite";
  // static String saveMentalGyms = "savedmentalgym/save";
  static const String getMentalGymCounts = "savedmentalgym/totalcount";
  static const String createCommunity = "community/save";
  static const String joinCommunity = "community/joincommunity";
  static const String createPost = "post/save";
  static const String getTrendingCommunities =
      "community/getallcommunities?isTrending=true";
  static const String getfavouriteposts = "post/getfavouriteposts";
  static String getCommunitiesByCategory(String id) =>
      "community/getcommunitybycategory/$id";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
