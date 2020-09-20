extension CloneList<T> on List<T> {
  List<T> clone() => new List.from(this);
}

extension CloneMap<T, U> on Map<T, U> {
  Map<T, U> clone() => new Map<T, U>.from(this);
}
