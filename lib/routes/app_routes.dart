import 'package:get/get.dart';
import '../screens/feedback_screen.dart';
import '../screens/leave_screen.dart';
import '../screens/auth/select_hostel_screen.dart';
import '../screens/history_screen.dart';
import '../screens/mess_card_screen.dart';
import '../screens/mess_menu_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/recharge_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  static String splash = "/splash";
  static String home = "/home";
  static String login = "/login";
  static String signup = "/signup";
  static String selectHostel = "/selectHostel";
  static String recharge = "/rechagre";
  static String history = "/history";
  static String payment = "/payment";
  static String profile = "/profile";
  static String messcard = "/messCard";
  static String messmenu = "/messMenu";
  static String feedback = '/feedback';
  static String leaveHistory = '/leaveHistory';

  static String getSplashRoute() => splash;
  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getSignupRoute() => signup;
  static String getSelectHostelRoute() => selectHostel;
  static String getRechagreRoute() => recharge;
  static String getHistoryRoute() => history;
  static String getPaymentRoute() => payment;
  static String getProfileRoute() => profile;
  static String getMessCardRoute() => messcard;
  static String getMessMenuRoute() => messmenu;
  static String getFeedbackRoute() => feedback;
  static String getLeaveRoute() => leaveHistory;

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: selectHostel, page: () => SelectHostelScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: recharge, page: () => RechargeScreen()),
    GetPage(name: history, page: () => HistoryScreen()),
    GetPage(name: payment, page: () => PaymentScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: messcard, page: () => MessCardScreen()),
    GetPage(name: messmenu, page: () => MessMenuScreen()),
    GetPage(name: feedback, page: () => FeedbackScreen()),
    GetPage(name: leaveHistory, page: () => LeaveScreen()),
  ];
}
