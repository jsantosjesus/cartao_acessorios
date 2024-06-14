class IParamsRequest {
  final String? url;
  final String? token;
  final String collection;
  final String? subcollection;
  final String? document;
  final Map<String, String>? where;

  IParamsRequest(
      {this.url,
      this.token,
      required this.collection,
      this.subcollection,
      this.document,
      this.where});
}
