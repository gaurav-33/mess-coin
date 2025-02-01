import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:messcoin/services/firestore_ref_service.dart';
import 'package:messcoin/utils/toast_snack_bar.dart';

import '../models/extra_meal_model.dart';
import '../models/mess_menu_model.dart';

class MenuServices {
  late final FirestoreRefService firestoreRefService;

  MenuServices() {
    firestoreRefService = FirestoreRefService();
  }

  Future<ExtraMealModel?> fetchExtraMeal(String hostelId) async {
    try {
      final DocumentSnapshot<ExtraMealModel> extraMealDoc =
          await firestoreRefService
              .getCollectionRef<ExtraMealModel>(
                  basePath: 'hostel_mess/$hostelId/extra_meal',
                  fromJson: (json) => ExtraMealModel.fromJson(json),
                  toJson: (model) => model.toJson())
              .doc(DateFormat.EEEE().format(DateTime.now()).toLowerCase())
              .get();

      if (extraMealDoc.exists) {
        return extraMealDoc.data();
      } else {
        AppSnackBar.error("Today's Extra Meal Record Not Found");
      }
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
    return null;
  }

  Future<MessMenuModel?> fetchMenuMeal(String hostelId, String day) async {
    try {
      DocumentSnapshot<MessMenuModel> messMenuDoc = await firestoreRefService
          .getCollectionRef<MessMenuModel>(
              basePath: "hostel_mess/$hostelId/mess_menu",
              fromJson: (json) => MessMenuModel.fromJson(json),
              toJson: (model) => model.toJson())
          .doc(day)
          .get();

      
      if (messMenuDoc.exists) {
        return messMenuDoc.data();
      } else {
        AppSnackBar.error("Today's Mess Menu Record Not Found");
      }
    } catch (e) {
      if (e is FirebaseException) {
        AppSnackBar.error(e.message ?? "An error occurred.", errorCode: e.code);
      } else {
        AppSnackBar.error("An unexpected error occurred.");
      }
    }
    return null;
  }
}
