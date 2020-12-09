class AddTaskException {
  String message;

  AddTaskException(this.message);

  @override
  String toString() {
    return this.message;
  }
}
