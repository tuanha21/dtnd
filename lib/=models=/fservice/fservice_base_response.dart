abstract class FServiceBaseResponse {
  late final num rc;
  late final String rs;
  late final String cmd;
  late final String oID;

  FServiceBaseResponse(
      {required this.rc,
      required this.rs,
      required this.cmd,
      required this.oID});
}
