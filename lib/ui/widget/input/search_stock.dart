import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchStockField<T> extends StatelessWidget {
  const SearchStockField({
    super.key,
    this.focusNode,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
  });
  final FocusNode? focusNode;
  final SuggestionsCallback<T> suggestionsCallback;
  final ItemBuilder<T> itemBuilder;
  final SuggestionSelectionCallback<T> onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      suggestionsCallback: suggestionsCallback,
      itemBuilder: itemBuilder,
      onSuggestionSelected: onSuggestionSelected,
      keepSuggestionsOnLoading: false,
      textFieldConfiguration: TextFieldConfiguration(
        focusNode: focusNode,
        decoration: InputDecoration(
            hintText: S.of(context).search_stock,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                AppImages.search_icon,
              ),
            ),
            suffixIconConstraints:
                const BoxConstraints(maxWidth: 52, maxHeight: 20)),
      ),
    );
  }
}
