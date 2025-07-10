import 'package:get/get.dart';

import '../modules/activities/bindings/activities_binding.dart';
import '../modules/activities/views/activities_view.dart';
import '../modules/authDirection/bindings/auth_direction_binding.dart';
import '../modules/authDirection/views/auth_direction_view.dart';
import '../modules/challengeDetails/bindings/challenge_details_binding.dart';
import '../modules/challengeDetails/views/challenge_details_view.dart';
import '../modules/challenges/bindings/challenges_binding.dart';
import '../modules/challenges/views/challenges_view.dart';
import '../modules/commentBottomSheet/bindings/comment_bottom_sheet_binding.dart';
import '../modules/commentBottomSheet/views/comment_bottom_sheet_view.dart';
import '../modules/community/bindings/community_binding.dart';
import '../modules/community/views/community_view.dart';
import '../modules/communityPosts/bindings/community_posts_binding.dart';
import '../modules/communityPosts/views/community_posts_view.dart';
import '../modules/contactUs/bindings/contact_us_binding.dart';
import '../modules/contactUs/views/contact_us_view.dart';
import '../modules/courseComplete/bindings/course_complete_binding.dart';
import '../modules/courseComplete/views/course_complete_view.dart';
import '../modules/createAvatar/bindings/create_avatar_binding.dart';
import '../modules/createAvatar/views/avatar_name_view.dart';
import '../modules/createAvatar/views/create_avatar_view.dart';
import '../modules/createCommunity/bindings/create_community_binding.dart';
import '../modules/createCommunity/views/create_community_view.dart';
import '../modules/createPost/bindings/create_post_binding.dart';
import '../modules/createPost/views/create_post_view.dart';
import '../modules/createTimeLine/bindings/create_time_line_binding.dart';
import '../modules/createTimeLine/views/create_time_line_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/faqs/bindings/faqs_binding.dart';
import '../modules/faqs/views/faqs_view.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/getSchool/bindings/get_school_binding.dart';
import '../modules/getSchool/views/get_school_view.dart';
import '../modules/getStarted/bindings/get_started_binding.dart';
import '../modules/getStarted/views/get_started_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homeSearch/bindings/home_search_binding.dart';
import '../modules/homeSearch/views/home_search_view.dart';
import '../modules/journaling/bindings/journaling_binding.dart';
import '../modules/journaling/views/journaling_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mentalGym/bindings/mental_gym_binding.dart';
import '../modules/mentalGym/views/mental_gym_view.dart';
import '../modules/mindFullHours/bindings/mind_full_hours_binding.dart';
import '../modules/mindFullHours/views/mind_full_hours_view.dart';
import '../modules/moodSelectionForm/bindings/mood_selection_form_binding.dart';
import '../modules/moodSelectionForm/views/mood_selection_form_view.dart';
import '../modules/mood_tracker/bindings/mood_tracker_binding.dart';
import '../modules/mood_tracker/views/mood_tracker_view.dart';
import '../modules/navigationBar/bindings/navigation_bar_binding.dart';
import '../modules/navigationBar/views/navigation_bar_view.dart';
import '../modules/onboardingQuestions/bindings/onboarding_questions_binding.dart';
import '../modules/onboardingQuestions/views/onboarding_questions_view.dart';
import '../modules/personalityQuestions/bindings/personality_questions_binding.dart';
import '../modules/personalityQuestions/views/personality_questions_view.dart';
import '../modules/personalityResults/bindings/personality_results_binding.dart';
import '../modules/personalityResults/views/personality_results_view.dart';
import '../modules/personalityTests/bindings/personality_tests_binding.dart';
import '../modules/personalityTests/views/personality_tests_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quizeComplete/bindings/quize_complete_binding.dart';
import '../modules/quizeComplete/views/quize_complete_view.dart';
import '../modules/quize_collect_coin/bindings/quize_collect_coin_binding.dart';
import '../modules/quize_collect_coin/views/quize_collect_coin_view.dart';
import '../modules/resetPassword/bindings/reset_password_binding.dart';
import '../modules/resetPassword/views/reset_password_view.dart';
import '../modules/searchMentalGym/bindings/search_mental_gym_binding.dart';
import '../modules/searchMentalGym/views/search_mental_gym_view.dart';
import '../modules/search_community/bindings/search_community_binding.dart';
import '../modules/search_community/views/search_community_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/startQuize/bindings/start_quize_binding.dart';
import '../modules/startQuize/views/start_quize_view.dart';
import '../modules/suggestionForm/bindings/suggestion_form_binding.dart';
import '../modules/suggestionForm/views/suggestion_form_view.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/support/views/support_view.dart';
import '../modules/update_timeline/bindings/update_timeline_binding.dart';
import '../modules/update_timeline/views/update_timeline_view.dart';
import '../modules/waveOnboarding/bindings/wave_onboarding_binding.dart';
import '../modules/waveOnboarding/views/wave_onboarding_view.dart';
import '../modules/workoutDetails/bindings/workout_details_binding.dart';
import '../modules/workoutDetails/views/workout_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_DIRECTION,
      page: () => const AuthDirectionView(),
      binding: AuthDirectionBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => const GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_QUESTIONS,
      page: () => const OnboardingQuestionsView(),
      binding: OnboardingQuestionsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_AVATAR,
      page: () => CreateAvatarView(),
      binding: CreateAvatarBinding(),
    ),
    GetPage(
      name: _Paths.AVATAR_NAME,
      page: () => const AvatarNameView(),
      binding: CreateAvatarBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_BAR,
      page: () => const NavigationBarView(),
      binding: NavigationBarBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.MOOD_SELECTION_FORM,
      page: () => MoodSelectionFormView(),
      binding: MoodSelectionFormBinding(),
    ),
    // GetPage(
    //   name: _Paths.MENTAL_GYMS,
    //   page: () => MentalGymsView(),
    //   binding: MentalGymsBinding(),
    // ),
    GetPage(
      name: _Paths.MENTAL_GYM,
      page: () => MentalGymView(),
      binding: MentalGymBinding(),
    ),
    GetPage(
      name: _Paths.WORKOUT_DETAILS,
      page: () => const WorkoutDetailsView(),
      binding: WorkoutDetailsBinding(),
    ),
    GetPage(
      name: _Paths.COURSE_COMPLETE,
      page: () => const CourseCompleteView(),
      binding: CourseCompleteBinding(),
    ),
    GetPage(
      name: _Paths.QUIZE_COMPLETE,
      page: () => const QuizeCompleteView(),
      binding: QuizeCompleteBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY,
      page: () => CommunityView(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_COMMUNITY,
      page: () => const CreateCommunityView(),
      binding: CreateCommunityBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY_POSTS,
      page: () => const CommunityPostsView(),
      binding: CommunityPostsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_POST,
      page: () => const CreatePostView(),
      binding: CreatePostBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT_BOTTOM_SHEET,
      page: () => CommentBottomSheetView(),
      binding: CommentBottomSheetBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITIES,
      page: () => const ActivitiesView(),
      binding: ActivitiesBinding(),
    ),
    GetPage(
      name: _Paths.SUPPORT,
      page: () => const SupportView(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.CHALLENGES,
      page: () => const ChallengesView(),
      binding: ChallengesBinding(),
    ),
    GetPage(
      name: _Paths.CHALLENGE_DETAILS,
      page: () => const ChallengeDetailsView(),
      binding: ChallengeDetailsBinding(),
    ),
    GetPage(
      name: _Paths.JOURNALING,
      page: () => const JournalingView(),
      binding: JournalingBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_TIME_LINE,
      page: () => const CreateTimeLineView(),
      binding: CreateTimeLineBinding(),
    ),
    GetPage(
      name: _Paths.MIND_FULL_HOURS,
      page: () => MindFullHoursView(),
      binding: MindFullHoursBinding(),
    ),
    GetPage(
      name: _Paths.GET_SCHOOL,
      page: () => const GetSchoolView(),
      binding: GetSchoolBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.QUIZE_COLLECT_COIN,
      page: () => const QuizeCollectCoinView(),
      binding: QuizeCollectCoinBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_MENTAL_GYM,
      page: () => const SearchMentalGymView(),
      binding: SearchMentalGymBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_TIMELINE,
      page: () => const UpdateTimelineView(),
      binding: UpdateTimelineBinding(),
    ),
    GetPage(
      name: _Paths.MOOD_TRACKER,
      page: () => const MoodTrackerView(),
      binding: MoodTrackerBinding(),
    ),
    GetPage(
      name: _Paths.WAVE_ONBOARDING,
      page: () => const WaveOnboardingView(),
      binding: WaveOnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME_SEARCH,
      page: () => const HomeSearchView(),
      binding: HomeSearchBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_COMMUNITY,
      page: () => const SearchCommunityView(),
      binding: SearchCommunityBinding(),
    ),
    GetPage(
      name: _Paths.PERSONALITY_TESTS,
      page: () => const PersonalityTestsView(),
      binding: PersonalityTestsBinding(),
      children: [
        GetPage(
          name: _Paths.PERSONALITY_TESTS,
          page: () => const PersonalityTestsView(),
          binding: PersonalityTestsBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PERSONALITY_QUESTIONS,
      page: () => const PersonalityQuestionsView(),
      binding: PersonalityQuestionsBinding(),
    ),
    GetPage(
      name: _Paths.PERSONALITY_RESULTS,
      page: () => const PersonalityResultsView(),
      binding: PersonalityResultsBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.FAQS,
      page: () => const FaqsView(),
      binding: FaqsBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SUGGESTION_FORM,
      page: () => const SuggestionFormView(),
      binding: SuggestionFormBinding(),
    ),
    GetPage(
      name: _Paths.START_QUIZE,
      page: () => const StartQuizeView(),
      binding: StartQuizeBinding(),
    ),
  ];
}
