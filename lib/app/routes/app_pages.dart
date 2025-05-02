import 'package:get/get.dart';

import '../modules/authDirection/bindings/auth_direction_binding.dart';
import '../modules/authDirection/views/auth_direction_view.dart';
import '../modules/createAvatar/bindings/create_avatar_binding.dart';
import '../modules/createAvatar/views/avatar_name_view.dart';
import '../modules/createAvatar/views/create_avatar_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/getStarted/bindings/get_started_binding.dart';
import '../modules/getStarted/views/get_started_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mentalGym/bindings/mental_gym_binding.dart';
import '../modules/mentalGym/views/mental_gym_view.dart';
import '../modules/moodSelectionForm/bindings/mood_selection_form_binding.dart';
import '../modules/moodSelectionForm/views/mood_selection_form_view.dart';
import '../modules/navigationBar/bindings/navigation_bar_binding.dart';
import '../modules/navigationBar/views/navigation_bar_view.dart';
import '../modules/onboardingQuestions/bindings/onboarding_questions_binding.dart';
import '../modules/onboardingQuestions/views/onboarding_questions_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/signUp/bindings/sign_up_binding.dart';
import '../modules/signUp/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/workoutDetails/bindings/workout_details_binding.dart';
import '../modules/workoutDetails/views/workout_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NAVIGATION_BAR;

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
  ];
}
