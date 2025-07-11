class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://api.kamelion.co/v1/";

  //endpoints
  static const String verifyLisenceKey = "sendlicensekey/save";
  static const String signUp = "auth/register";
  static const String login = "auth/login";
  static const String getOnboardingQuestions = "question/getallquestions";
  static const String personalityQuestionsType = "personalitytest/getall";
  static String getMentalGymQuestions(String id) => "quizmodule/allquizes/$id";
  static String getPersonalityQuestions(String id) =>
      "personalitytest/getquestions/$id";
  static String markOpenedCommunity(String id) => "community/markopened/$id";
  static const String getUser = "users/getUser";
  static const String getMyStats = "postinteraction/stats";
  static const String createAvatar = "avatar/save";
  static const String saveUser = "userinfo/save";
  static const String uploadFile = "users/fileupload";

  static const String workoutComplete = "savedmentalgym/workoutcomplete";

  static String updateUser(String id) => "users/updateuser/$id";
  static String submitQuize = "completequiz/save";
  static String submitPersonalityAnswers = "personalitytest/complete";
  static String getMood(String id, String timezone) => "/mood/getmoods/$id";
  static const String addMood = "mood/save";
  static String deleteAccount(String id) => "users/deleteuser/$id";
  static const String getMentalGymCategiries = "category/all-category";
  static const String getActiveChallenges =
      "challenges/getchallenges?status=inProgress";
  static const String getBadges = "badge/getAllBadges";
  static const String getLeaderboard = "postinteraction/leaderboard";
  static const String getCompletedChallenges =
      "challenges/getchallenges?status=completed";
  static const String getSavedChallenges = "challenges/getfavouritechallenges";
  static const String getSuggestedChallenges = "challenges/getchallenges?";
  static String getActiveMentalGym({
    required String page,
    required String limit,
  }) =>
      "mentalgym/getallmentalgyms?status=inProgress&page=$page&limit=$limit";
  static String searchMentalGym({
    required String page,
    required String limit,
    required String word,
  }) =>
      "mentalgym/getallmentalgyms?search=$word&page=$page&limit=$limit";
  static String getYourCommunities({
    required String page,
    required String limit,
  }) =>
      "community/getcommunitys";
  static String getAllCommunities({
    required String page,
    required String limit,
  }) =>
      "community/getallcommunitie?isActive=true&status=approved";
  static String getTrendingMentalGyms({
    required String page,
    required String limit,
  }) =>
      "mentalgym/getallmentalgyms?isTrending=true";
  static String getSuggestedMentalGyms(String id) =>
      "mentalgym/getallsuggestedmentalgyms/$id";
  static String getAllMentalGyms = "mentalgym/getallmentalgym?isActive=true";
  static String getCompletedMentalGyms =
      "mentalgym/getallmentalgyms?status=completed";
  static String getChallengeDetails(String id) => "challenges/getchallenge/$id";
  static String getSavedMentalGyms(String id) => "savedmentalgym/get/$id";
  static String getMentalGymsByCategory(String id) =>
      "mentalgym/getallmental/$id";
  static String getMentalGymsDetails(String id) => "workout/getallworkout/$id";
  static String getCommunityDetails(String id) => "post/getcommunityposts/$id";
  static String getChallengesByCategory(String id) =>
      "challenges/getchallengesbycategory/$id";
  static String addLikePost(String id) => "postinteraction/$id/like";
  static String addComment(String id) => "postinteraction/$id/comment";
  static String startMentalGym(String id) => "mentalgym/getmentalgym/$id";
  static String getComments(String id) => "postinteraction/$id/comments";
  static String saveMentalGyms = "savedmentalgym/save";
  static String saveChallenge = "challenges/togglefavouritechallenge";
  static String updateMentalGym(String id) => "mentalgym/update/$id";
  static String joinMentalGym = "mentalgym/joinmentalgym";
  static String submitMgRating = "savedmentalgym/submitworkoutrating";
  static String updateCommunity(String id) => "community/update/$id";
  static String updatePost(String id) => "post/update/$id";
  static String deletePost(String id) => "post/delete/$id";
  static String savePost = "post/addfavourite";
  static String startChallenge = "challenges/updatechallengeprogress";
  // static String saveMentalGyms = "savedmentalgym/save";
  static const String getMentalGymCounts = "savedmentalgym/totalcount";
  static const String createCommunity = "community/save";
  static const String joinCommunity = "community/joincommunity";
  static const String createPost = "post/save";
  static const String sendcontactus = "sendlicensekey/sendcontactus";
  static const String getTrendingCommunities =
      "community/getallcommunities?isTrending=true";
  static const String getfavouriteposts = "post/getfavouriteposts";
  static String getCommunitiesByCategory(String id) =>
      "community/getcommunitybycategory/$id";
  static String getMembersOfList(String id) =>
      "community/getcommunitymembers/$id";
  static const String getAllJournals = "journal/getalljournals";
  static const String postJournalSave = "journal/save";
  static String deleteJournal(String id) => "journal/delete/$id";
  static String getJournalById(String id) => "journal/getjournal/$id";
  static String updateJournal(String id) => "journal/update/$id";
  static String deleteComment(
          {required String commentId, required String postId}) =>
      "postinteraction/$postId/comment/$commentId";
  static String leaveCommunity(String id) => "community/leavecommunity/$id";
  static String reportComment(String id) => "postinteraction/$id/report";

  static String getHomeSearch(String query) => "mood/search?search=$query";
  static String searchCommunities({
    required String page,
    required String limit,
    required String word,
  }) =>
      "community/getallcommunities?search=$word";
  static const String getMoods = "mood/getmood";
  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
