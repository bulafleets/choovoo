import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/ui/barber_ui/barber_appointment_list.dart';
import 'package:choovoo/ui/barber_ui/barber_profile.dart';
import 'package:choovoo/ui/navigationDrawer.dart';
import 'package:flutter/material.dart';

class FeedDetails extends StatefulWidget {
  @override
  _FeedDetailsState createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> {
  TextEditingController editingController = TextEditingController();
  int selectedpage = 1;
  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
      if (selectedpage == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BarberProfile()));
      }
      if (selectedpage == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BarberAppointmentList()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
        title: Image.asset(
          "assets/round_logo.png",
          height: 50,
          width: 50,
        ),
        centerTitle: true,
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(
                0xff363636), //This will change the drawer background to blue.
            //other styles
          ),
          child: navigationDrawer()),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color(0xff1a1c1d),
        unselectedItemColor: Color(0xff696e71),
        showUnselectedLabels: true,
        selectedFontSize: 18,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedpage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff465258),
            icon: Icon(Icons.favorite),
            label: 'Shop feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Appointment',
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 220,
        child: ListView(
          children: [
            _spacer(),
            ListTile(
              onTap: () {},
              leading: CircleAvatar(),
              title: Text('Profile Name',
                  style: TextStyle(
                      color: Color.fromRGBO(39, 159, 178, 1),
                      fontWeight: FontWeight.bold)),
              subtitle: Text('time'),
              trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromRGBO(112, 112, 112, 1)),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Add Friend',
                      style:
                          TextStyle(color: Color.fromRGBO(112, 112, 112, 1)))),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'some description about feed and post',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(98, 125, 129, 1)),
              ),
            ),
            Container(
                color: Theme.of(context).primaryColor,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://st2.depositphotos.com/2931363/9695/i/950/depositphotos_96952028-stock-photo-young-handsome-man-in-barbershop.jpg',
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  fit: BoxFit.cover,
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey[400])),
                              child: Icon(Icons.thumb_up,
                                  color: Colors.grey[400])),
                          SizedBox(width: 10),
                          Text(
                            '24.6K Likes',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      Row(children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.thumb_up,
                                color: Colors.blue, size: 30)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.chat_rounded,
                                color: Color.fromRGBO(13, 222, 206, 1),
                                size: 30)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share_outlined,
                                color: Colors.grey[400], size: 30)),
                      ])
                    ])),
            _spacer(),
            ListTile(
              // isThreeLine: true,
              leading: CircleAvatar(radius: 25),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'PaulMacy8',
                  style: TextStyle(color: Color.fromRGBO(75, 75, 82, 1)),
                ),
              ),
              subtitle: Text(
                'Thank you for commenting this post',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.favorite, color: Colors.pink),
            ),
            _spacer(),
            ListTile(
              leading: CircleAvatar(radius: 25),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Luckytwoshoes',
                  style: TextStyle(
                    color: Color.fromRGBO(75, 75, 82, 1),
                  ),
                ),
              ),
              subtitle: Text(
                'With this online tool you can upload an image or provide a website URL and get the RGB Color, HEX Color and HSL Color code',
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.favorite_border),
            ),
            Divider(color: Colors.grey, thickness: 1)
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(5),
        color: Colors.black,
        child: TextField(
          controller: editingController,
          keyboardType: TextInputType.text,
          cursorColor: Colors.grey,
          style: TextStyle(color: Color(0xFF4d5060), fontFamily: 'RobotoBold'),
          onChanged: (val) {},
          onTap: () {},
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFffffff),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFedf0fd)),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFedf0fd)),
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: Icon(Icons.arrow_forward_ios, color: Color(0xffb7c2d5)),
            // labelText: "Search Barber Community....",
            contentPadding: EdgeInsets.all(20.0),
            hintText: ' Write comment...',
            hintStyle: TextStyle(color: Color(0xffb7c2d5)),
            labelStyle: TextStyle(color: Color(0xffb7c2d5)),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _spacer() {
    return SizedBox(height: 15);
  }
}
