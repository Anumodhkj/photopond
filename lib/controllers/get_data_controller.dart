import 'dart:developer';
import 'package:get/get.dart';
import 'package:photopond/constants/strings.dart';
import 'package:photopond/controllers/base_controller.dart';
import 'package:photopond/models/get_data_model.dart';
import 'package:photopond/services/base_client.dart';

class GetDataController extends GetxController with BaseController {
  var getData = GetDataModel().obs;
  var isLoading = false.obs;
  var isData = true.obs;
  
  @override
  void dispose() {
    getData.close();
    isLoading.close();
    super.dispose();
  }

  getImages(searchkey, page) async {
    try {
      isLoading(true);
      isData(false);
      final response = await BaseClient()
          .get(Strings.baseURL, "api/?key=${Strings.authKEY}&q=$searchkey=$page").catchError(handleError);
      if (response == null) {
        log("no data , error");
      } else {
        var jsonString = response;
        var data = getDataModelFromJson(jsonString);
        if (data.hits!.isNotEmpty) {
          getData.value = data;
          isData(false);
          log("API call success");
          log(data.hits.toString());
        }
        if (data.hits!.isEmpty) {
          getData.value = data;
          isData(true);
          log("API call success , but not data [] ");
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
