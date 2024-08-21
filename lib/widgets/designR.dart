/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/utilities/constants.dart';

class designR extends StatefulWidget {
  const designR({super.key});

  @override
  State<designR> createState() => _designRState();
}

class _designRState extends State<designR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   body:  SingleChildScrollView(
 child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('   CENTER STONE',
                        style: TextStyle(
                          color: kourcolor1,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/csd.png"),
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/css.png"),
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/cse.png"),
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/cst.png"),
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/csr.png"),
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////////////////////////////////////////////////////////////////
            
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('   CENTER STONE SHAPE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kourcolor1,
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/rs.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/os.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/prs.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/ps.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //////////////////////////////////////////////////////////////////////////////////////
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('   SIDE SETTING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kourcolor1,
                          fontSize: 15,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/side_none.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/side_upave.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/side_channel.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                /*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesignRing()),
                                ); */
                              },
                              child: ClipOval(
                                child: Ink.image(
                                  image: AssetImage("images/side_bead.PNG"),
                                  height: 100,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                ),
              ),
      ]
    ),
   ),
    );
  }
} */