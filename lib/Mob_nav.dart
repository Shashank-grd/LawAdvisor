import 'package:flutter/material.dart';
import 'package:lawadvisor/utils/colors.dart';
import 'package:lawadvisor/utils/variable.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;


  void initState(){
    super.initState();
    pageController = PageController();

  }
  void navigationTap(int page){
    pageController.jumpToPage(page);
  }

  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      _page= page;
    });
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: _page==0? primaryColor : secondaryColor,),label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: _page==1? primaryColor : secondaryColor,),label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded,color: _page==2? primaryColor : secondaryColor,),label: "",),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: _page==3? primaryColor : secondaryColor,),label: "",),
        ],
        onTap: navigationTap,
      ),

    );
  }
}