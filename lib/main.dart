import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meald/cubit/commande/commande_cubit.dart';
import 'package:meald/cubit/signup/singup_cubit.dart';

import 'package:meald/views/login.dart';
import 'cubit/article/article_cubit.dart';
import 'cubit/restaurant/restaurant_cubit.dart';
import 'firebase_options.dart';
import 'cubit/login/login_cubit.dart';
import 'views/welcome_page.dart';
import 'views/signup.dart';

import 'views/pages/liste.dart';

import 'views/pages/tableau_debord.dart';
import 'views/pages/notification.dart';
import 'views/pages/profile_resto.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/pages/historique_page.dart';
import 'views/pages/parametres.dart';

import 'views/pages/rates.dart';
import 'views/pages/articles_encours.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
 providers: [
      BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
          ),
           BlocProvider<ArticleCubit>(
            create: (context) => ArticleCubit(),
          ),
           BlocProvider<RestaurantCubit>(
            create: (context) => RestaurantCubit(),
          ),
           BlocProvider<CommandeCubit>(
            create: (context) => CommandeCubit(),
          ),
           BlocProvider<SingupCubit>(
            create: (context) => SingupCubit(),
          ),
          ]    ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'meald',
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomePage(),
          '/homePage_restaurant': (context) => const TableauDebord(),
          '/Signup': (context) => Signup(),
          '/Login': (context) => Login(),
          '/Notif': (context) => NotificationScreen(),
          '/Profile': (context) => ProfileResto(),
          '/List': (context) => Liste(),
          '/historique': (context) => HistoryPage(),
          '/parametres': (context) => ParametresPage(),
          '/ordres': (context) => Liste(),
          '/rates': (context) => RatesPage(),
          '/ongoingOrders': (context) => OngoingOrdersPage(),
        },
      ),
    );
  }
}
