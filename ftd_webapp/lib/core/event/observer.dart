
/// This class is used to observe the output of a use case.

abstract class UseCaseObserver{
  void onUseCaseSuccess(
    dynamic useCaseOutput,
  );
}