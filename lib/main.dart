import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project1/api/firebase_api.dart';
import 'package:project1/loginScreen.dart';
import 'package:project1/models/designRings.dart';
import 'package:project1/models/product.dart';
import 'package:project1/AdminScreens/admin_page.dart';
import 'package:project1/screens/Gemstone.dart';
import 'package:project1/screens/cart.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/screens/design_ring.dart';
import 'package:project1/screens/diamond_page.dart';
import 'package:project1/screens/earring_page.dart';
import 'package:project1/screens/forgot-password.dart';
import 'package:project1/screens/gold_items.dart';
import 'package:project1/screens/gold_page.dart';
import 'package:project1/screens/home_page.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/screens/necklace_page.dart';
import 'package:project1/screens/productDetails.dart';
import 'package:project1/screens/profile.dart';
import 'package:project1/screens/ring_page.dart';
import 'package:project1/screens/screen.dart';
import 'package:project1/screens/create-new-account.dart';
import 'package:project1/screens/notification.dart';
import 'package:project1/screens/websiteHomepage.dart';
import 'package:project1/screens/wishlist.dart';
import 'package:project1/widgets/UserPreferences.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final navigatorKey = GlobalKey<NavigatorState>();
/* FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin(); */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCNi2pUyKq2-K3nBKQE9mRmidT8PRrOq1w",
            authDomain: "sgproj-94193.firebaseapp.com",
            projectId: "sgproj-94193",
            storageBucket: "sgproj-94193.appspot.com",
            messagingSenderId: "712894584402",
            appId: "1:712894584402:web:24b9a0aa1dc4600b89318b"));
    await FirebaseAppCheck.instance.activate();
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  // await FirebaseApi().initNotifications();
  await UserPreferences.init();
  //await flutterLocalNotificationsPlugin.initialize(initSettings);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController emailController = TextEditingController();
  late Product product;
  late design Design;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const CupertinoScrollBehavior(),
      initialRoute: kIsWeb ? 'websiteMainScreen' : '/',
      routes: {
        '/': (context) => loginpagee(),
        'websiteMainScreen': (context) => websiteHomePage(),
        'ForgetPassword': (context) => ForgetPassword(),
        'CreateNewAccount': (context) => CreateNewAccount(),
        'MainScreen': (context) => MainScreen(),
        'DiamondScreen': (context) => DiamondScreen(),
        'GoldScreen': (context) => GoldScreen(),
        'DesignRingScreen': (context) => DesignRing(name: 'round diamond'),
        'SetPage': (context) => RingPage(
              category: 'Set',
              title: kIsWeb
                  ? 'Sets                                                                 '
                  : '    Sets            ',
              sort: "",
            ),
        'RingPage': (context) => RingPage(
              category: 'Ring',
              title: kIsWeb
                  ? 'Rings                                                                 '
                  : '    Rings            ',
              sort: "",
            ),
        'NecklacePage': (context) => RingPage(
              category: 'Necklace',
              title: kIsWeb
                  ? 'Necklaces                                                                 '
                  : '   Necklaces      ',
              sort: "",
            ),
        'BraceletPage': (context) => RingPage(
              category: 'Bracelet',
              title: kIsWeb
                  ? 'Bracelets                                                                 '
                  : 'Bracelets       ',
              sort: "",
            ),
        'EarringPage': (context) => RingPage(
              category: 'Earring',
              title: kIsWeb
                  ? 'Earrings                                                                 '
                  : 'Earrings          ',
              sort: "",
            ),
        'GoldItem': (context) =>
            GoldItem(category: 'Ring', title: '    Rings            ',sort: "",),
        'GNecklacePage': (context) =>
            GoldItem(category: 'Necklace', title: '   Necklaces      ',sort: "",),
        'GBraceletPage': (context) =>
            GoldItem(category: 'Bracelet', title: 'Bracelets       ',sort: "",),
        'GEarringPage': (context) =>
            GoldItem(category: 'Earring', title: 'Earings          ',sort: "",),
        'GSetPage': (context) =>
            GoldItem(category: 'Set', title: '    Sets            ',sort: "",),
        'chatPage': (context) => Chat(
              isAdmin: false,
              userId: "",
            ),
        'ProductDetails': (context) => ProductDetails(
              product: product,
              isDiamond: true,
            ),
        'wishlist': (context) => wishlist(
              isDiamond: true,
            ),
        'profile': (context) => profile(),
        'Cart': (context) => Cart(),
        'AdminPage': (context) => AdminPage(),
        'Gemstone': (context) => Gemstone(),
        'notification': (context) => notification(),
      },
    );
  }
}
