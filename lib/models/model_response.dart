class ResponseModel {
  final bool? success;
  final List<String> messages;
  dynamic data;
  final int? status;

  ResponseModel({
    this.success,
    required this.messages,
    this.data,
    this.status,
  });

  factory ResponseModel.fromJson(dynamic json) => ResponseModel(
        success: json["success"],
        messages: List.from(json["messages"] ?? []),
        data: json["data"],
        status: json["status"],
      );
}
