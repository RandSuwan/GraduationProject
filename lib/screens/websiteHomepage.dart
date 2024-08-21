import 'package:flutter/material.dart';
import 'package:project1/screens/login1.dart';
import 'package:project1/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

enum SocialMedia { facebook, instagram }

class websiteHomePage extends StatefulWidget {
  const websiteHomePage({super.key});

  @override
  State<websiteHomePage> createState() => _websiteHomePageState();
}

class _websiteHomePageState extends State<websiteHomePage> {
  GlobalKey servicesKey = GlobalKey();
  GlobalKey contactUsKey = GlobalKey();
  GlobalKey MainKey = GlobalKey();

  /* // Add the methods to launch URLs
  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } */

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    double containerHieght = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kourcolor1.withOpacity(0.7),
          leading: Image(
            image: AssetImage(
              'images/diamondicon.png',
            ),
            color: Colors.white,
          ),
          title: Text(
            "I R I S",
            style: TextStyle(
                color: Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => scrollToSection(MainKey),
                child: Text(
                  "Main",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () => scrollToSection(servicesKey),
                child: Text(
                  "Services",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () => scrollToSection(contactUsKey),
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginpagee()));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: containerWidth * 0.3,
                  height: containerHieght * 0.75,
                  child: Image.asset('images/hp.PNG'),
                ),
                Column(
                  children: [
                    Container(
                      key: MainKey,
                      width: 480,
                      color: Colors.white,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w300,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Welcome",
                                style: TextStyle(
                                    color: kourcolor1.withOpacity(0.7))),
                            TextSpan(
                                text:
                                    " to IRIS, your premier destination for exquisite diamonds and gold. Explore our stunning collection and discover the perfect pieces to celebrate your special moments. Thank you for choosing IRIS, where brilliance meets elegance.",
                                style: TextStyle(color: kourcolor1)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Store Button
                        ElevatedButton.icon(
                          icon: Image.asset('images/app_store_icon.png',
                              height: 40),
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Available on",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              SizedBox(height: 2),
                              Text("App Store",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kourcolor1.withOpacity(0.7),
                            elevation: 7,
                            shadowColor: kourcolor1,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Google Play Button
                        ElevatedButton.icon(
                          icon: Image.asset('images/google_play_icon.png',
                              height: 40),
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Available on",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                              SizedBox(height: 2),
                              Text("Google Play",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kourcolor1.withOpacity(0.7),
                            elevation: 7,
                            shadowColor: kourcolor1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              key: servicesKey,
              width: containerWidth,
              color: kourcolor1.withOpacity(0.7),
              child: Center(
                child: Text(
                  "Services",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: containerWidth * 0.3,
                    height: containerHieght * 0.78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: kourcolor1.withOpacity(0.7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              //SizedBox(height: 80),
                              Text('Welcome to',
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white)),
                              Text('IRIS.',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              SizedBox(height: 40),
                              Image(
                                image: AssetImage('images/hello.png'),
                                height: 300,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'IRIS offers a unique marketplace for exquisite diamonds and gold, fostering a vibrant and beneficial community.',
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFffffff)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                Container(
                  width: containerWidth * 0.3,
                  height: containerHieght * 0.78,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: kourcolor1.withOpacity(0.7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('What You Can Do in',
                          style: TextStyle(fontSize: 35, color: Colors.white)),
                      Text('IRIS?',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 40),
                      Image(
                        image: AssetImage('images/question-mark.png'),
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Customers can utilize IRIS to either browse our stunning collection or purchase exquisite diamonds and gold.',
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFffffff)),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    width: containerWidth * 0.3,
                    height: containerHieght * 0.78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: kourcolor1.withOpacity(0.7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Features in',
                            style:
                                TextStyle(fontSize: 35, color: Colors.white)),
                        Text('IRIS.',
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 40),
                        Image(
                          image: AssetImage('images/features.png'),
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Key features of IRIS include the ability to chat with sellers, alongside a range of services designed to enhance the overall customer experience.',
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFFffffff)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              height: 40,
              key: contactUsKey,
              width: containerWidth,
              color: kourcolor1.withOpacity(0.7),
              child: Center(
                child: Text(
                  "Contact us",
                  style: TextStyle(
                      color: Color(0xFFffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0),
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              width: containerWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //SizedBox(height: 10),
                  Column(
                    children: [
                      Icon(
                        Icons.email,
                        color: kourcolor1,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "IRIS@gmail.com",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.phone,
                        color: kourcolor1,
                        size: 40,
                      ),
                      SizedBox(height: 8), 
                      Text(
                        "+97254168650",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.facebook),
                          color: kourcolor1,
                          iconSize: 40,
                          onPressed: () => share(SocialMedia.facebook)),
                      SizedBox(height: 8),
                      Text(
                        "Facebook",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          icon: Icon(Icons.camera_alt),
                          color: kourcolor1,
                          iconSize: 40,
                          onPressed: () => share(SocialMedia.instagram)),
                      SizedBox(height: 8),
                      Text(
                        "Instagram",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(seconds: 1));
    }
  }

  Future share(SocialMedia socialPlatform) async {
    final urls = {
      SocialMedia.facebook: 'https://www.facebook.com/IRISDiamonds',
      SocialMedia.instagram: 'https://www.instagram.com/iris_diamonds_/',
    };
    final url = urls[socialPlatform]!;
    // ignore: deprecated_member_use
    if (await launcher.canLaunch(url)) {
      // ignore: deprecated_member_use
      await launcher.launch(url);
    } else {
      print('error');
    }
  }
}
