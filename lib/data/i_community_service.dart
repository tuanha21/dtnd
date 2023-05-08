import 'implementations/community_service.dart';

abstract class ICommunityService {
  factory ICommunityService() => CommunityService();

  void postPost() {}
}
