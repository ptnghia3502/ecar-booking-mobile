import 'package:ecar_booking_mobile/pages/main_pages/profile_pages/change_pass_page.dart';
import 'package:ecar_booking_mobile/pages/main_pages/profile_pages/version_page.dart';
import 'package:flutter/material.dart';

import '../../services/local_variables.dart';
import '../login_page.dart';
import 'profile_pages/profile_details_page.dart';

class ProfilePage extends StatelessWidget {
  void handleLogout(BuildContext context) {
    // Clear static variables
    LocalVariables.jwtToken = '';
    LocalVariables.currentEmail = '';
    LocalVariables.currentUserId = '';
    LocalVariables.currentUserName = '';
    // Navigate to the login page
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // This clears all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 214, 117),
                    Colors.orangeAccent
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors
                                .black, // Set the background color of the circular container to black
                          ),
                        ),
                        const Center(
                          child:
                              Icon(Icons.person, size: 70, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    LocalVariables.currentUserName,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    LocalVariables.currentEmail,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                ),
                title: const Text('Profile Information'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileDetailsPage()),
                  );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.password_outlined,
                  size: 30,
                ),
                title: const Text('Change Password?'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassPage()),
                  );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  size: 30,
                ),
                title: const Text('Version'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VersionPage()),
                  );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: const Text('Logout'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  handleLogout(context);
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
