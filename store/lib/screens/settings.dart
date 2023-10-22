import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/main.dart';
import 'package:store/screens/home.dart';
import 'package:store/screens/login_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    buildCardWidget(
                      title: 'Contact Us',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Share Your Love',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    buildCardWidget(
                      title: 'Rate Us',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 1),
                    ),
                    buildCardWidget(
                      title: 'Share The App',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'More',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    buildCardWidget(
                      title: 'Privacy Policy',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 3),
                    ),
                    buildCardWidget(
                      title: 'Shipping Policy',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 4),
                    ),
                    buildCardWidget(
                      title: 'Refund Policy',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 5),
                    ),
                    buildCardWidget(
                      title: 'Terms of Service',
                      trailing: Icons.arrow_forward_ios,
                      onclicked: () => selectedItem(context, 6),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    buildCardWidget(
                      title: 'Logout',
                      trailing: Icons.logout,
                      onclicked: () => selectedItem(context, 7),
                    ),
                  ],
                ))));
  }

  Widget buildCardWidget(
      {required String title, IconData? trailing, VoidCallback? onclicked}) {
    return Card(
      child: InkWell(
        onTap: onclicked,
        child: ListTile(
          title: Text(title),
          trailing: Icon(
            trailing,
            size: 20,
          ),
        ),
      ),
    );
  }

  selectedItem(BuildContext context, int i) {
    switch (i) {
      case 0:
        print("Clicked on menu 0");
        break;
      case 1:
        print("Clicked on menu 1");
        break;
      case 7:
        logout();
        break;
      default:
        break;
    }
  }

  logout() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    p.remove('token');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }
}
