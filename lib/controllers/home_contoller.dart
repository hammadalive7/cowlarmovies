import 'package:cowlarmovies/services/client/base_client.dart';
import 'package:get/get.dart';
import '../models/home_response_model.dart';

abstract class HomeScreenRepo {
  Future<HomeScreenResponse> getHomeScreenResponse();
}

class HomeScreenController extends GetxController implements HomeScreenRepo{

  var isLoading = true.obs;


  @override
  void onInit() {
    fetchHomeScreenResponse();
    super.onInit();
  }

  @override
  Future<HomeScreenResponse> getHomeScreenResponse() async {

    HomeScreenResponse homeScreenResponse;
    final Map<String, dynamic> response = await BaseClient().getHomeFromMovieDB();
    print(response);
    homeScreenResponse = HomeScreenResponse.fromJson(response);
    return homeScreenResponse;
  }

  Future<HomeScreenResponse> fetchHomeScreenResponse() async {
    isLoading(true);
    try {
      final response = await getHomeScreenResponse();
      print(response);
      return response;
    } finally {
      isLoading(false);
    }
  }



}