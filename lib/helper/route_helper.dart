import 'package:get/get.dart';
import 'package:neoloop/screens/auth/auth.dart';
import 'package:neoloop/screens/home/home.dart';
import 'package:neoloop/screens/home/product/Produktausgang%20Kunden/produktausgang_kunden.dart';
import 'package:neoloop/screens/home/product/Produktausgang%20Kunden/produktausgang_kunden_shipping_details.dart';
import 'package:neoloop/screens/home/product/Produkteingang%20Produktion/produkteingang_produktion.dart';
import 'package:neoloop/screens/home/product/Produktretoure%20Kunden/produktretoure_kunden.dart';
import 'package:neoloop/screens/home/product/product_main_page.dart';
import 'package:neoloop/screens/home_screen.dart';

class RouteHelper {
  static String splashScreen = '/splashScreen';
  static String loginScreen = '/loginScreen';
  static String forgotPassword = '/forgotPassword';
  static String homeScreen = '/homeScreen';
  static String productMainPage = '/productMainPage';
  static String produkteingangProduktionMainPage =
      '/produkteingangProduktionMainPage';
  static String produkteingangProduktionConfirmation =
      '/produkteingangProduktionConfirmation';
  static String produkteingangProduktionPrint =
      '/produkteingangProduktionPrint';
  static String produkteingangProduktionQue = '/produkteingangProduktionQue';
  static String produktausgangKundenExitCustomers =
      '/produktausgangKundenExitCustomers';
  static String produktausgangKundenOrderDetails =
      '/produktausgangKundenOrderDetails';
  static String produktausgangKundenShippingDetails =
      '/produktausgangKundenShippingDetails';
  static String returnAndReplacement = '/returnAndReplacement';
  static String returnDetails = '/returnDetails';
  static String notificationPage = '/notificationPage';
  static String mePage = '/mePage';
  static String chatMainPage = '/chatMainPage';
  static String printers = '/printers';
  static String settings = '/settings';

  static List<GetPage> getPages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPassword()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: productMainPage, page: () => ProductMainPage()),
    GetPage(name: notificationPage, page: () => NotificationPage()),
    GetPage(name: mePage, page: () => MePage()),
    GetPage(name: chatMainPage, page: () => ChatMainPage()),
    GetPage(
        name: produkteingangProduktionMainPage,
        page: () => ProdukteingangProduktionMainPage()),
    GetPage(
        name: produkteingangProduktionConfirmation,
        page: () => ProdukteingangProduktionConfirmation()),
    GetPage(
        name: produkteingangProduktionPrint,
        page: () => ProdukteingangProduktionPrint()),
    GetPage(
        name: produkteingangProduktionQue,
        page: () => ProdukteingangProduktionQue()),
    GetPage(
        name: produktausgangKundenExitCustomers,
        page: () => ProduktausgangKundenExitCustomers()),
    GetPage(
        name: produktausgangKundenOrderDetails,
        page: () => ProduktausgangKundenOrderDetails()),
    GetPage(
        name: produktausgangKundenShippingDetails,
        page: () => ProduktausgangKundenShippingDetails()),
    GetPage(name: returnAndReplacement, page: () => ReturnAndReplacement()),
    GetPage(name: returnDetails, page: () => ReturnDetails()),
    GetPage(name: printers, page: () => Printers()),
    GetPage(name: settings, page: () => SettingsPage()),
  ];
}
