import 'package:dtnd/data/i_community_service.dart';

class CommunityService implements ICommunityService {
  static final CommunityService _instance = CommunityService._intern();

  CommunityService._intern();

  factory CommunityService() => _instance;

  @override
  void postPost() {
    // TODO: implement postPost
  }
}
