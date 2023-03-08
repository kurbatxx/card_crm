import 'package:card_crm/model/organization.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orgSelectProvider = StateProvider<Organization>((_) {
  return const Organization(
    id: 0,
    shortName: "Все школы",
    fullName: "Все школы",
    address: "",
  );
});
