class VirtualAssistantController {
  VirtualAssistantController._internal();

  static final VirtualAssistantController _instance =
      VirtualAssistantController._internal();

  factory VirtualAssistantController() => _instance;

  static get instance => _instance;

  bool get registered => true;
}
