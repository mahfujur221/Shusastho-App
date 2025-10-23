import 'package:ecommerce/containers/dashboard_text.dart';
import 'package:ecommerce/containers/home_button.dart';
import 'package:ecommerce/controllers/auth_service.dart';
import 'package:ecommerce/providers/admin_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/containers/dashboard_text.dart';
import 'package:ecommerce/containers/home_button.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard"),
        actions: [
          IconButton(onPressed: ()async{
            // Provider.of<AdminProvider>(context,listen: false).cancelProvider();
            await AuthService().logout();
            Navigator.pushNamedAndRemoveUntil(context, "/login",  (route)=> false);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(children: [
          Container(
              height: 260,
              padding:  EdgeInsets.all(12),
              margin:  EdgeInsets.only(left: 10,right:  10,bottom: 10),
              decoration:  BoxDecoration(color:  Colors.deepPurple.shade100,borderRadius:  BorderRadius.circular(10)),
              // child: Consumer<AdminProvider>(
              //   builder: (context, value, child) =>
          child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DashboardText(keyword: "Total Categories", value: "300",),
                        DashboardText(keyword: "Total Products", value: "400",),
                        // DashboardText(keyword: "Total Orders", value: "${value.totalOrders}",),
                        // DashboardText(keyword: "Order Not Shipped yet", value: "${value.orderPendingProcess}",),
                        // DashboardText(keyword: "Order Shipped", value: "${value.ordersOnTheWay}",),
                        // DashboardText(keyword: "Order Delivered", value: "${value.ordersDelivered}",),
                        // DashboardText(keyword: "Order Cancelled", value: "${value.ordersCancelled}",),

                      ],
                    ),
              )
       // ),
,
          // Buttons for admins
           Row(
            children: [
              HomeButton(onTap: (){
                // Navigator.pushNamed(context,"/orders");
              }, name: "Orders"),
              HomeButton(onTap: (){
                Navigator.pushNamed(context,"/products");
              }, name: "Products"),
            ],
          ),
          Row(
            children: [
              HomeButton(onTap: (){
                 Navigator.pushNamed(context,"/promos",arguments: {"promo":true});
              }, name: "Promos"),
              HomeButton(onTap: (){
                 Navigator.pushNamed(context,"/promos",arguments: {"promo":false});
              }, name: "Banners"),
            ],
          ),
          Row(
            children: [
              HomeButton(onTap: (){
                Navigator.pushNamed(context,"/category");
              }, name: "Categories"),
              HomeButton(onTap: (){
                Navigator.pushNamed(context, "/coupons");
              }, name: "Coupons"),
            ],
          ),
        ],),
      ),
    );
  }
}