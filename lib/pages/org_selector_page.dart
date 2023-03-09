import 'package:card_crm/ext/ext_log.dart';
import 'package:card_crm/model/organization.dart';
import 'package:card_crm/providers/org_list_provider.dart';
import 'package:card_crm/providers/org_select_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrgSelectorPage extends ConsumerWidget {
  const OrgSelectorPage({
    required this.overlay,
    super.key,
  });

  final OverlayEntry? overlay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrg = ref.watch(orgListProvider);

    return Scaffold(
      body: asyncOrg.when(
        data: (data) {
          return FilteredOrgWidget(
            overlay: overlay,
            data: data,
          );
        },
        error: (e, _) => const Text('ERROR'),
        loading: () => const Center(
          child: SizedBox.square(
            dimension: 16.0,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FilteredOrgWidget extends HookConsumerWidget {
  const FilteredOrgWidget({
    super.key,
    required this.overlay,
    required this.data,
  });

  final OverlayEntry? overlay;
  final List<Organization> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterController = useTextEditingController();
    final filteredList = useState(data);

    useEffect(() {
      filterController.addListener(() {
        if (filterController.text.isEmpty) {
          filteredList.value = data;
        } else {
          filteredList.value = data
              .where(
                (e) => e.fullName
                    .toLowerCase()
                    .contains(filterController.text.toLowerCase()),
              )
              .toList();
        }
      });
      return null;
    }, [filterController]);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: filterController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  filterController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.value.length,
            itemBuilder: (BuildContext context, int index) {
              final org = filteredList.value[index];
              return ListTile(
                onTap: () {
                  ref.read(orgSelectProvider.notifier).state = org;
                  overlay?.remove();
                },
                title: Text(org.fullName),
              );
            },
          ),
        )
      ],
    );
  }
}
