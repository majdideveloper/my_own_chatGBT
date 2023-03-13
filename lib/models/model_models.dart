class ModelModels {
  final String id;

  const ModelModels({
    required this.id,
  });

  factory ModelModels.fromJson(Map<String, dynamic> json) {
    return ModelModels(
      id: json['id'],
    );
  }
}
