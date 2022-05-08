import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mkdao/home/homecontroller.dart';
import 'package:mkdao/home/notifications/notificationsview.dart';
import 'package:mkdao/home/report/reportview.dart';
import 'package:mkdao/settings/settingsview.dart';

import 'activity/activityview.dart';
import 'community/communityview.dart';
import 'dashboard/dashboardview.dart';
import 'invoice/invoiceview.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  HomeViewController controller = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            left: 10,
            top: 10,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.9,
            child: SideBar(
              controller: controller,
            )),
        Positioned(
            right: 0,
            width: MediaQuery.of(context).size.width * 0.78,
            height: MediaQuery.of(context).size.height * 0.9,
            child: mainContent())
      ],
    ));
  }

  Widget mainContent() {
    return Obx(() {
      switch (controller.currentPage.value) {
        case pages.dashboard:
          return DashboardView();
        case pages.activity:
          return ActivityView();
        case pages.community:
          return CommunityView();
        case pages.invoice:
          return InvoiceView();
        case pages.report:
          return ReportView();
        case pages.notifications:
          return NotificationsView();
        default:
          return Container(child: const Text('failed to get page'));
      }
    });
  }
}

class SideBar extends StatelessWidget {
  SideBar({Key? key, required this.controller}) : super(key: key);
  HomeViewController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
            child: Column(children: [
          Text(
            'MR DAO',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Total MR Tokens: 20 000",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ])),
        ListTile(
          title: const Text('Dashboard'),
          onTap: () => controller.currentPage.value = pages.dashboard,
        ),
        ListTile(
          title: const Text('Activity'),
          onTap: () => controller.currentPage.value = pages.activity,
        ),
        ListTile(
          title: const Text('Community'),
          onTap: () => controller.currentPage.value = pages.community,
        ),
        ListTile(
          title: const Text('Invoice'),
          onTap: () => controller.currentPage.value = pages.invoice,
        ),
        ListTile(
          title: const Text('Report'),
          onTap: () => controller.currentPage.value = pages.report,
        ),
        ListTile(
          title: const Text('Notifications'),
          onTap: () => controller.currentPage.value = pages.notifications,
        ),
        SizedBox(
          height: 100,
        ),
        TextButton(
            onPressed: () async {
              await Get.defaultDialog(
                  content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: SettingsView()));
            },
            child: Text('Settings'))
      ],
    ));
  }
}
