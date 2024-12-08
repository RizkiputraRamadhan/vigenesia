import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 70,
            padding: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: () {
                    print('tes');
                  },
                  icon: Icon(
                    Icons.bookmark_add_rounded,
                    color: const Color.fromARGB(255, 46, 47, 48),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          "Qoutes",
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              letterSpacing: 1.2),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    makePost(
                      userName: 'Lorem Ipsum Dolor',
                      userImage: 'assets/images/azamat-zhanisov.jpg',
                      feedTime: '3 mins ago',
                      feedText: '"All the Lorem Ipsum generators on the"',
                    ),
                    makePost(
                      userName: 'Lorem Ipsum Dolor',
                      userImage: 'assets/images/azamat-zhanisov.jpg',
                      feedTime: '3 mins ago',
                      feedText:
                          '"All the Lorem Ipsum generators on the All the Lorem Ipsum generators on theAll the Lorem Ipsum generators on the"',
                    ),
                    makePost(
                      userName: 'Lorem Ipsum Dolor',
                      userImage: 'assets/images/azamat-zhanisov.jpg',
                      feedTime: '3 mins ago',
                      feedText: '"All the Lorem Ipsum generators on the"',
                    ),
                    makePost(
                      userName: 'Lorem Ipsum Dolor',
                      userImage: 'assets/images/azamat-zhanisov.jpg',
                      feedTime: '3 mins ago',
                      feedText:
                          '"All the Lorem Ipsum generators on the All the Lorem Ipsum generators on theAll the Lorem Ipsum generators on the"',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget makePost({userName, userImage, feedTime, feedText}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(userImage), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        userName,
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        feedTime,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.person_add,
                  size: 20,
                  color: const Color.fromARGB(255, 46, 47, 48),
                ),
                onPressed: () {
                  print('Follow button clicked');
                },
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            feedText,
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.5,
                letterSpacing: .7),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
