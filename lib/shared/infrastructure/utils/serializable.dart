mixin Serializable<T> {
  Map<String, dynamic> toRequest();
  T fromJson(Map<String, dynamic> json);
}
