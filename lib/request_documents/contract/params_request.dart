class IParamsRequest {
  final String? url;
  final String? token;
  final String collection;
  final String? document;
  final String? where;

  IParamsRequest(
      {this.url,
      this.token,
      required this.collection,
      this.document,
      this.where});
}
