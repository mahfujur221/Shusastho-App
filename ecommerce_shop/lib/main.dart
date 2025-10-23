import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerce_shop/views/signup.dart';
import 'package:ecommerce_shop/views/home_nav.dart';
import 'package:ecommerce_shop/views/discount_page.dart';
import 'package:ecommerce_shop/views/specific_products.dart';
import 'package:ecommerce_shop/views/view_product.dart';
import 'package:ecommerce_shop/views/orders_page.dart';
import 'package:ecommerce_shop/views/checkout_page.dart';
import 'package:ecommerce_shop/views/login.dart';
import 'package:ecommerce_shop/views/cart_page.dart';
import 'package:ecommerce_shop/views/update_profile.dart';
import 'package:ecommerce_shop/controllers/auth_service.dart';
import 'package:ecommerce_shop/firebase_options.dart';
import 'package:ecommerce_shop/providers/user_provider.dart';
import 'package:ecommerce_shop/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(create: (context) =>  UserProvider(),),
        ChangeNotifierProvider(create: (context) =>  CartProvider(),),
    ],
    child: MaterialApp(
    title: 'eCommerce App',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routes: {
        "/":(context)=> CheckUser(),
        "/login": (context)=> LoginPage(),
        "/home": (context)=> HomeNav(),
        "/signup": (context)=> SingupPage(),
        "/update_profile":(context)=>UpdateProfile(),
        "/discount": (context)=> DiscountPage(),
        "/specific": (context)=> SpecificProducts(),
        "/view_product":(context)=> ViewProduct(),
        "/cart": (context)=> CartPage(),
        "/checkout":(context)=> CheckoutPage(),
        "/orders":(context)=> OrdersPage(),
        // "/view_order":(context)=> ViewOrder(),
      },
    ),
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {

  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:  Center(child: CircularProgressIndicator(),),);
  }
}

