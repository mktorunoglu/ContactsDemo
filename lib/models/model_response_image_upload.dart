class UploadImageResponseModel {
  final String? imageUrl;

  UploadImageResponseModel({
    this.imageUrl,
  });

  factory UploadImageResponseModel.fromJson(dynamic json) =>
      UploadImageResponseModel(
        imageUrl: json["imageUrl"],
      );
}
