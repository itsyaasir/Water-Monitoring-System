import "package:flutter/foundation.dart";

mixin PrintLogMixin {
  void printLog(dynamic data) {
    if (kDebugMode) {
      print("********** LOG START *********");
      if (data != null) {
        print("");
        print(data.toString());
        print("");
      } else {
        print("nothing to print");
      }
      print("********** LOG END *********");
    }
  }
}
