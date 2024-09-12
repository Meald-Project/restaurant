import 'package:flutter/material.dart';
import 'package:meald/viewmodels/user_view_model.dart';
import 'package:meald/views/login.dart';
import 'views/welcome_page.dart';
import 'views/signup.dart';
import 'views/pages/creation_de_restaurant.dart';
import 'views/pages/creation_d_article.dart';
import 'views/pages/liste.dart';
import 'views/pages/article_details.dart';
import 'views/pages/tableau_debord.dart';
import 'views/pages/notification.dart';
import 'views/pages/profile_resto.dart';
import 'package:meald/viewmodels/footer_view_model.dart'; // Assurez-vous d'importer le ViewModel
import 'package:provider/provider.dart';
import '../widgets/themes/theme_provider.dart';
import 'views/pages/historique_page.dart';
import 'views/pages/parametres.dart';
import 'views/pages/liste.dart';
import 'views/pages/rates.dart';
import 'views/pages/articles_encours.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<FooterViewModel>(
          create: (_) => FooterViewModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'meald',
          theme: themeProvider.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => WelcomePage(),
            '/creation_article': (context) => const CreationDArticle(),
            '/homePage_restaurant': (context) => const TableauDebord(),
            '/Signup': (context) => Signup(),
            '/Login': (context) => Login(),
            '/Creatresto': (context) => CreationDeRestaurant(),
            '/Notif': (context) => NotificationScreen(),
            '/Profile': (context) => ProfileResto(),
            '/List': (context) => Liste(),
            '/historique': (context) => HistoryPage(),
            '/parametres': (context) => ParametresPage(),
            '/ordres': (context) => Liste(),
            '/rates': (context) => RatesPage(),
            '/ongoingOrders': (context) => OngoingOrdersPage(),
            
          },
        );
      },
    );
  }
}
