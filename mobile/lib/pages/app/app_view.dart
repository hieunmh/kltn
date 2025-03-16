import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mobile/pages/app/app_controller.dart';
import 'package:mobile/pages/app/post/post_view.dart';
import 'package:mobile/pages/app/profile/profile_view.dart';

class AppView extends GetView<AppController> {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value) => controller.changePage(value),
        children: [
          PostView(),
          ProfileView()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.5
            )
          )
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent
          ), 
          child: Obx(() =>
            BottomNavigationBar(
              backgroundColor: Colors.white,
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12
              ),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.blue,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome.rectangle_list),
                  activeIcon: Icon(FontAwesome.rectangle_list_solid),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesome.user),
                  activeIcon: Icon(FontAwesome.user_solid),
                  label: 'Profile'
                ),
              ],
              currentIndex: controller.currentPage.value,
              onTap: (value) => controller.handleNavBarTap(value),
            ),
          )
        ),
      ),
    );
  }
}