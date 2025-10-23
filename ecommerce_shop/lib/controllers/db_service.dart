// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_shop/models/cart_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// // class DbService {
// //   User? user = FirebaseAuth.instance.currentUser;
// //
// //   // USER DATA
// //   // save user data after creating new account
// //   Future saveUserData({required String name, required String email}) async {
// //     try {
// //       Map<String, dynamic> data = {
// //         "name": name,
// //         "email": email,
// //       };
// //       await FirebaseFirestore.instance
// //           .collection("shop_users")
// //           .doc(user!.uid)
// //           .set(data);
// //     } catch (e) {
// //       print("error on saving user data: $e");
// //     }
// //   }
// //
// //   // update other data in database
// //   Future updateUserData({required Map<String, dynamic> extraData}) async {
// //     await FirebaseFirestore.instance
// //         .collection("shop_users")
// //         .doc(user!.uid)
// //         .update(extraData);
// //   }
// //
// //   // read user current  user data
// //   Stream<DocumentSnapshot> readUserData() {
// //     return FirebaseFirestore.instance
// //         .collection("shop_users")
// //         .doc(user!.uid)
// //         .snapshots();
// //   }
//
//
//
//
//
// class DbService {
//   // Save user data after creating a new account
//   Future<void> saveUserData({
//     required String uid,
//     required String name,
//     required String email,
//   }) async {
//     try {
//       Map<String, dynamic> data = {
//         "name": name,
//         "email": email,
//       };
//       await FirebaseFirestore.instance
//           .collection("shop_users")
//           .doc(uid)  // Store the data with the user's UID as the document ID
//           .set(data);
//     } catch (e) {
//       print("Error saving user data: $e");
//     }
//   }
//
//   // Update user data
//   Future<void> updateUserData({required Map<String, dynamic> extraData}) async {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;  // Fetch the current user
//       if (user != null) {
//         await FirebaseFirestore.instance
//             .collection("shop_users")
//             .doc(user.uid)
//             .update(extraData);
//       } else {
//         print("No authenticated user found.");
//       }
//     } catch (e) {
//       print("Error updating user data: $e");
//     }
//   }
//
//   // Read user data
//   Stream<DocumentSnapshot> readUserData() {
//     try {
//       User? user = FirebaseAuth.instance.currentUser;  // Fetch the current user
//       if (user != null) {
//         return FirebaseFirestore.instance
//             .collection("shop_users")
//             .doc(user.uid)
//             .snapshots();
//       } else {
//         print("No authenticated user found.");
//         return Stream.empty();  // Return an empty stream if the user is not authenticated
//       }
//     } catch (e) {
//       print("Error reading user data: $e");
//       return Stream.empty();  // Return an empty stream in case of an error
//     }
//   }
//
//
//
//
//   //  READ PROMOS AND BANNERS
//   Stream<QuerySnapshot> readPromos() {
//     return FirebaseFirestore.instance.collection("shop_promos").snapshots();
//   }
//
//   Stream<QuerySnapshot> readBanners() {
//     return FirebaseFirestore.instance.collection("shop_banners").snapshots();
//   }
//
//   // DISCOUNTS
// // read discount coupons
//   Stream<QuerySnapshot> readDiscounts() {
//     return FirebaseFirestore.instance
//         .collection("shop_coupons")
//         .orderBy("discount", descending: true)
//         .snapshots();
//   }
//
//   // verify the coupon
//   Future<QuerySnapshot> verifyDiscount({required String code}) {
//     print("seraching for code : $code");
//     return FirebaseFirestore.instance
//         .collection("shop_coupons")
//         .where("code", isEqualTo: code)
//         .get();
//   }
//
//   // CATEGORIES
//   Stream<QuerySnapshot> readCategories() {
//     return FirebaseFirestore.instance
//         .collection("shop_categories")
//         .orderBy("priority", descending: true)
//         .snapshots();
//   }
//
//   // PRODUCTS
//   // read products of specific categories
//   Stream<QuerySnapshot> readProducts(String category) {
//     return FirebaseFirestore.instance
//         .collection("shop_products")
//         .where("category", isEqualTo: category.toLowerCase())
//         .snapshots();
//   }
//
//   // // search products by doc ids
//   Stream<QuerySnapshot> searchProducts(List<String> docIds) {
//     return FirebaseFirestore.instance
//         .collection("shop_products")
//         .where(FieldPath.documentId, whereIn: docIds)
//         .snapshots();
//   }
//
//   // reduce the count of products after purchase
//   Future reduceQuantity(
//       {required String productId, required int quantity}) async {
//     await FirebaseFirestore.instance
//         .collection("shop_products")
//         .doc(productId)
//         .update({"quantity": FieldValue.increment(-quantity)});
//   }
//
//   // // CART
//   // // display the user cart
//
//   Stream<QuerySnapshot> readUserCart() {
//     return FirebaseFirestore.instance
//         .collection("shop_users")
//         .doc(user!.uid)
//         .collection("cart")
//         .snapshots();
//   }
//
//   // adding product to the cart
//   Future addToCart({required CartModel cartData}) async {
//     try {
//       // update
//       await FirebaseFirestore.instance
//           .collection("shop_users")
//           .doc(user!.uid)
//           .collection("cart")
//           .doc(cartData.productId)
//           .update({
//         "product_id": cartData.productId,
//         "quantity": FieldValue.increment(1)
//       });
//     } on FirebaseException catch (e) {
//       print("firebase exception : ${e.code}");
//       if (e.code == "not-found") {
//         // insert
//         await FirebaseFirestore.instance
//             .collection("shop_users")
//             .doc(user!.uid)
//             .collection("cart")
//             .doc(cartData.productId)
//             .set({"product_id": cartData.productId, "quantity": 1});
//       }
//     }
//   }
//
//   // delete specific product from cart
//   Future deleteItemFromCart({required String productId}) async {
//     await FirebaseFirestore.instance
//         .collection("shop_users")
//         .doc(user!.uid)
//         .collection("cart")
//         .doc(productId)
//         .delete();
//   }
//
//   // // empty users cart
//   Future emptyCart() async {
//     await FirebaseFirestore.instance
//         .collection("shop_users")
//         .doc(user!.uid)
//         .collection("cart")
//         .get()
//         .then((value) {
//       for (DocumentSnapshot ds in value.docs) {
//         ds.reference.delete();
//       }
//     });
//   }
//
//   // decrease count of item
//   Future decreaseCount({required String productId}) async {
//     await FirebaseFirestore.instance
//         .collection("shop_users")
//         .doc(user!.uid)
//         .collection("cart")
//         .doc(productId)
//         .update({"quantity": FieldValue.increment(-1)});
//   }
//   //
//   // // ORDERS
//   // // create a new order
//   // Future createOrder({required Map<String, dynamic> data}) async {
//   //   await FirebaseFirestore.instance.collection("shop_orders").add(data);
//   // }
//   //
//   // // update the status of order
//   // Future updateOrderStatus(
//   //     {required String docId, required Map<String, dynamic> data}) async {
//   //   await FirebaseFirestore.instance
//   //       .collection("shop_orders")
//   //       .doc(docId)
//   //       .update(data);
//   // }
//   //
//   // // read the order data of specific user
//   // Stream<QuerySnapshot> readOrders() {
//   //   return FirebaseFirestore.instance
//   //       .collection("shop_orders")
//   //       .where("user_id", isEqualTo: user!.uid)
//   //       .orderBy("created_at", descending: true)
//   //       .snapshots();
//   // }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_shop/models/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  // Save user data after creating a new account
  Future<void> saveUserData({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      Map<String, dynamic> data = {
        "name": name,
        "email": email,
      };
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(uid)
          .set(data);
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // Update user data
  Future<void> updateUserData({required Map<String, dynamic> extraData}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection("shop_users")
            .doc(user.uid)
            .update(extraData);
      } else {
        print("No authenticated user found.");
      }
    } catch (e) {
      print("Error updating user data: $e");
    }
  }

  // Read user data
  Stream<DocumentSnapshot> readUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .snapshots();
    } else {
      print("No authenticated user found.");
      return const Stream.empty();
    }
  }

  // Read Promos and Banners
  Stream<QuerySnapshot> readPromos() {
    return FirebaseFirestore.instance.collection("shop_promos").snapshots();
  }

  Stream<QuerySnapshot> readBanners() {
    return FirebaseFirestore.instance.collection("shop_banners").snapshots();
  }

  // Discounts
  Stream<QuerySnapshot> readDiscounts() {
    return FirebaseFirestore.instance
        .collection("shop_coupons")
        .orderBy("discount", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> verifyDiscount({required String code}) {
    print("Searching for code : $code");
    return FirebaseFirestore.instance
        .collection("shop_coupons")
        .where("code", isEqualTo: code)
        .get();
  }

  // Categories
  Stream<QuerySnapshot> readCategories() {
    return FirebaseFirestore.instance
        .collection("shop_categories")
        .orderBy("priority", descending: true)
        .snapshots();
  }

  // Products
  Stream<QuerySnapshot> readProducts(String category) {
    return FirebaseFirestore.instance
        .collection("shop_products")
        .where("category", isEqualTo: category.toLowerCase())
        .snapshots();
  }

  Stream<QuerySnapshot> searchProducts(List<String> docIds) {
    return FirebaseFirestore.instance
        .collection("shop_products")
        .where(FieldPath.documentId, whereIn: docIds)
        .snapshots();
  }

  Future reduceQuantity({
    required String productId,
    required int quantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("shop_products")
        .doc(productId)
        .update({"quantity": FieldValue.increment(-quantity)});
  }

  // Cart
  Stream<QuerySnapshot> readUserCart() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .collection("cart")
          .snapshots();
    } else {
      print("No authenticated user found.");
      return const Stream.empty();
    }
  }

  Future addToCart({required CartModel cartData}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No authenticated user found.");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .collection("cart")
          .doc(cartData.productId)
          .update({
        "product_id": cartData.productId,
        "quantity": FieldValue.increment(1)
      });
    } on FirebaseException catch (e) {
      print("Firebase exception: ${e.code}");
      if (e.code == "not-found") {
        await FirebaseFirestore.instance
            .collection("shop_users")
            .doc(user.uid)
            .collection("cart")
            .doc(cartData.productId)
            .set({"product_id": cartData.productId, "quantity": 1});
      }
    }
  }

  Future deleteItemFromCart({required String productId}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .collection("cart")
          .doc(productId)
          .delete();
    }
  }

  Future emptyCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .collection("cart")
          .get()
          .then((value) {
        for (DocumentSnapshot ds in value.docs) {
          ds.reference.delete();
        }
      });
    }
  }

  Future decreaseCount({required String productId}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("shop_users")
          .doc(user.uid)
          .collection("cart")
          .doc(productId)
          .update({"quantity": FieldValue.increment(-1)});
    }
  }

  // Orders
  Future createOrder({required Map<String, dynamic> data}) async {
    await FirebaseFirestore.instance.collection("shop_orders").add(data);
  }

  Future updateOrderStatus({
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await FirebaseFirestore.instance
        .collection("shop_orders")
        .doc(docId)
        .update(data);
  }

  Stream<QuerySnapshot> readOrders() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection("shop_orders")
          .where("user_id", isEqualTo: user.uid)
          .orderBy("created_at", descending: true)
          .snapshots();
    } else {
      print("No authenticated user found.");
      return const Stream.empty();
    }
  }
}
