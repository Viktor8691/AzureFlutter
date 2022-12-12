abstract class BaseApiService {
  final String baseUrl = "https://org253660e9.api.crm4.dynamics.com/api/data/v9.2/";
  Future<dynamic> getResponse(String url);
}