import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_fullname.freezed.dart';
part 'client_fullname.g.dart';

@freezed
class ClientFullname with _$ClientFullname {
  //@JsonSerializable(explicitToJson: true)
  const factory ClientFullname({
    @JsonKey(name: "last_name") required String lastName,
    required String name,
    required String surname,
  }) = _ClientFullname;

  factory ClientFullname.fromJson(Map<String, dynamic> json) =>
      _$ClientFullnameFromJson(json);
}
