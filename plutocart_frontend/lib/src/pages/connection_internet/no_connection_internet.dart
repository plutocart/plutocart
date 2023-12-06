import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:plutocart/src/app.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please check your internet connection\nand try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult != ConnectivityResult.none) {
                  // If internet connection is available, navigate back to the app
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => plutocartApp(),
                    ),
                  );
                }
                // You can add a message here to inform the user
                // that the retry failed due to no internet connection.
              },
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
