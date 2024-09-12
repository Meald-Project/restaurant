import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meald/viewmodels/footer_view_model.dart'; // Assurez-vous d'importer le ViewModel

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final footerViewModel = Provider.of<FooterViewModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              footerViewModel.selectIndex(0);
              Navigator.of(context).pushNamed('/homePage_restaurant');
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.home,
                size: 30,
                color: footerViewModel.selectedIndex == 0
                    ? Color.fromARGB(255, 8, 86, 11)
                    : Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              footerViewModel.selectIndex(1);
              Navigator.of(context).pushNamed('/List');
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.list,
                size: 30,
                color: footerViewModel.selectedIndex == 1
                    ? Color.fromARGB(255, 8, 86, 11)
                    : Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              footerViewModel.selectIndex(2);
              Navigator.of(context).pushNamed('/creation_article');
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: footerViewModel.selectedIndex == 2
                    ? Color.fromARGB(48, 3, 255, 62)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.add,
                size: 30,
                color: footerViewModel.selectedIndex == 2
                    ? Color.fromARGB(255, 8, 86, 11)
                    : Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              footerViewModel.selectIndex(3);
              Navigator.of(context).pushNamed('/Notif');
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.notifications,
                size: 30,
                color: footerViewModel.selectedIndex == 3
                    ? Color.fromARGB(255, 8, 86, 11)
                    : Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              footerViewModel.selectIndex(4);
              Navigator.of(context).pushNamed('/Profile');
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              child: Icon(
                Icons.person,
                size: 30,
                color: footerViewModel.selectedIndex == 4
                    ? Color.fromARGB(255, 8, 86, 11)
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
