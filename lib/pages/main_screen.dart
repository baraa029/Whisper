import 'package:facebook_app/my_provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: Provider.of<MyProvider>(context).screens[Provider.of<MyProvider>(context).currentIndex],


      bottomNavigationBar: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), ),
          child: BottomNavigationBar(
            elevation: 20,
              iconSize: 30,
              unselectedItemColor: Colors.grey[500],
              selectedItemColor: Colors.deepOrange,
              currentIndex: Provider.of<MyProvider>(context).currentIndex  ,
              onTap: (value){
                Provider.of<MyProvider>(context,listen: false).ChangePage(value);
              },

              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '' ,),
                BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '' ,),
                BottomNavigationBarItem(icon: Icon(Icons.bookmark_border_outlined), label: '' ,),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '' ,),

              ],
            ),

        ),
      ),

    );
  }
}
