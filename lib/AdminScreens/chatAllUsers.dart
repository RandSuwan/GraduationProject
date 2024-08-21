import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1/ipaddress.dart';
import 'package:project1/screens/chat.dart';
import 'package:project1/utilities/constants.dart';
import 'package:project1/widgets/UserPreferences.dart';

class ChatAllUsers extends StatefulWidget {
  const ChatAllUsers({super.key});

  @override
  State<ChatAllUsers> createState() => _ChatAllUsersState();
}

class _ChatAllUsersState extends State<ChatAllUsers> {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsersExcluding();
  }

  Future<void> fetchUsersExcluding() async {
    final String excludeEmail = 'rand.nabil.2019@gmail.com';
    final ipAddress = await getLocalIPv4Address();

    final response = await http.get(
        Uri.parse('http://$ipAddress:5000/fetchUsersExcluding/$excludeEmail'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        users = data.map((user) => user as Map<String, dynamic>).toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            size: 30,
            Icons.arrow_back_ios,
            color: kourcolor1,
          ),
        ),
        title: Text(
          'All Chats',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: kourcolor1,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: users.length,
                      separatorBuilder: ((context, index) => Divider(
                            indent: 25,
                            endIndent: 25,
                            color: Colors.grey.withOpacity(0.4),
                            height: 1,
                          )),
                      itemBuilder: ((context, index) {
                        var user = users[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Chat(
                                    isAdmin: true,
                                    userId: user['_id'].toString()),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: index % 2 == 0
                                    ? Colors.white
                                    : const Color.fromARGB(255, 222, 214, 214)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: kourcolor1,
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user["email"] ?? '',
                                        style: TextStyle(
                                            color: kourcolor1,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        user["username"] ?? '',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
