import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../../../shared/index.dart';
import '../../components/index.dart';

import 'avatar.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController search;

  const Header({
    super.key,
    required this.search,
  });

  @override
  Size get preferredSize => const Size.fromHeight(136);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _welcome(),
                const Spacing.horizontal(8),
                const ThemeToggle(),
              ],
            ),
            const Spacing.vertical(20),
            AnimatedBuilder(
              animation: search,
              builder: (_, __) => _searchBar(search.text.isNotEmpty),
            ),
            const Spacing.vertical(20),
          ],
        ),
      ),
    );
  }

  Widget _welcome() {
    return Row(
      children: [
        Avatar(
          imageUrl: faker.image.loremPicsum(),
        ),
        const Spacing.horizontal(12),
        ThemeWrapper(
          builder: (__, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTime.now().goodWithDate(),
                style: TextStyle(
                  fontSize: 16,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
              Text(
                Strings.welcomeBack,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeNotifier.whiteOrBlackColor(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchBar(bool isSearching) {
    return TextFormField(
      controller: search,
      decoration: InputDecoration(
        filled: true,
        hintText: Strings.searchHint,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: ThemeNotifier.iconColorByMode(),
        ),
        suffixIcon: Visibility(
          visible: isSearching,
          child: IconButton(
            onPressed: search.clear,
            icon: Icon(Icons.close, color: ThemeNotifier.iconColorByMode()),
          ),
        ),
      ),
    );
  }
}
