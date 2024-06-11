abstract class Error implements Exception {
  final String message;

  Error({required this.message});
}

class DatasourceError implements Error {
  @override
  final String message;

  DatasourceError({required this.message});
}

class RepositoryError implements Error {
  @override
  final String message;

  RepositoryError({required this.message});
}
