abstract class DataState<T> {
  final T ? data;
  final Exception ? error;
  final String ? loadingMessage;

  const DataState({this.data, this.error, this.loadingMessage});

}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T ? data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(Exception error) : super(error: error);
}

class DataEmpty<T> extends DataState<T> {
  const DataEmpty() : super();
}

class DataLoading<T> extends DataState<T> {
  const DataLoading(String loadingMessage) : super(loadingMessage: loadingMessage);
}
