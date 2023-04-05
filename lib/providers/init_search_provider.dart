import 'package:card_crm/model/init_search/init_search.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final initSearchProvider = StateProvider(
  (ref) => const InitSearch(
    search: '',
    schoolId: 0,
    showDeleted: false,
  ),
);
