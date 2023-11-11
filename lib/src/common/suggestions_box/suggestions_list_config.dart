import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/src/common/suggestions_box/suggestions_controller.dart';
import 'package:flutter_typeahead/src/typedef.dart';

/// Configuration for the suggestions list.
class SuggestionsListConfig<T> {
  const SuggestionsListConfig({
    this.animationDuration,
    this.animationStart,
    this.autoFlipListDirection = true,
    required this.controller,
    this.debounceDuration,
    this.direction = AxisDirection.down,
    this.errorBuilder,
    this.hideKeyboardOnDrag = false,
    this.hideOnEmpty,
    this.hideOnError,
    this.hideOnLoading,
    required this.itemBuilder,
    this.itemSeparatorBuilder,
    this.keepSuggestionsOnLoading,
    this.hideOnSelect,
    this.layoutArchitecture,
    this.loadingBuilder,
    this.minCharsForSuggestions,
    this.noItemsFoundBuilder,
    this.onSuggestionSelected,
    this.scrollController,
    required this.suggestionsController,
    this.suggestionsCallback,
    this.transitionBuilder,
  });

  /// {@template flutter_typeahead.SuggestionsListConfig.animationDuration}
  /// Duration of the animation for showing and hiding the suggestions box.
  ///
  /// Defaults to 500 milliseconds.
  ///
  /// See also:
  /// * [animationStart], which is the value at which the list of suggestions should start animating.
  /// * [transitionBuilder], which is the builder function for custom animation transitions.
  /// {@endtemplate}
  final Duration? animationDuration;

  /// {@template flutter_typeahead.SuggestionsListConfig.animationStart}
  /// The value at which the list of suggestions should start animating.
  ///
  /// Defaults to 0.25.
  ///
  /// See also:
  ///  * [animationDuration], which is the duration of the animation.
  ///  * [transitionBuilder], which is the builder function for custom animation transitions.
  /// {@endtemplate}
  final double? animationStart;

  /// {@template flutter_typeahead.SuggestionsListConfig.autoFlipListDirection}
  /// Whether the suggestions list should be reversed if the suggestions box is flipped.
  ///
  /// Defaults to true.
  /// {@endtemplate}
  final bool autoFlipListDirection;

  /// Controller for the text field used for input.
  final TextEditingController controller;

  /// {@template flutter_typeahead.SuggestionsListConfig.debounce}
  /// Duration to wait for changes in the text field before updating suggestions.
  ///
  /// This prevents making unnecessary calls to [suggestionsCallback] while the
  /// user is still typing.
  ///
  /// If you want to update suggestions immediately, set this to Duration.zero.
  ///
  /// Defaults to 300 milliseconds.
  /// {@endtemplate}
  final Duration? debounceDuration;

  /// {@template flutter_typeahead.SuggestionsListConfig.direction}
  /// The direction in which the suggestions box opens.
  ///
  /// Must be either [AxisDirection.down] or [AxisDirection.up].
  ///
  /// Defaults to [AxisDirection.down].
  /// {@endtemplate}
  final AxisDirection direction;

  //// {@template flutter_typeahead.SuggestionsListConfig.errorBuilder}
  /// Builder function for displaying an error when [suggestionsCallback] throws an exception.
  ///
  /// Example usage:
  /// ```dart
  /// errorBuilder: (BuildContext context, Object error) => Text(
  ///   '$error',
  ///   style: TextStyle(color: Theme.of(context).errorColor),
  /// ),
  /// ```
  ///
  /// Defaults to a [Text] widget with [ThemeData.errorColor].
  ///
  /// See also:
  /// * [hideOnError], which is whether the suggestions box should be hidden on error.
  /// {@endtemplate}
  final ErrorBuilder? errorBuilder;

  /// {@template flutter_typeahead.SuggestionsListConfig.hideKeyboardOnDrag}
  /// Whether the keyboard should be hidden when the user scrolls the suggestions list.
  ///
  /// Cannot be used together with [hideSuggestionsOnKeyboardHide].
  ///
  /// Defaults to false.
  /// {@endtemplate}
  final bool hideKeyboardOnDrag;

  /// {@template flutter_typeahead.SuggestionsListConfig.hideOnEmpty}
  /// Whether the suggestions box should be hidden when no suggestions are available.
  ///
  /// If enabled, [noItemsFoundBuilder] will be ignored.
  ///
  /// Defaults to `false`.
  /// {@endtemplate}
  final bool? hideOnEmpty;

  /// {@template flutter_typeahead.SuggestionsListConfig.hideOnError}
  /// Whether the suggestions box should be hidden on error.
  ///
  /// If enabled, [errorBuilder] will be ignored.
  ///
  /// Defaults to `false`.
  /// {@endtemplate}
  final bool? hideOnError;

  /// {@template flutter_typeahead.SuggestionsListConfig.hideOnLoading}
  /// Whether the suggestions box should be hidden during loading.
  ///
  /// If enabled, [loadingBuilder] will be ignored.
  ///
  /// Defaults to `false`.
  /// {@endtemplate}
  final bool? hideOnLoading;

  /// {@template flutter_typeahead.SuggestionsListConfig.itemBuilder}
  /// Called for each suggestion returned by [suggestionsCallback] to build the
  /// corresponding widget.
  ///
  /// Example usage:
  /// ```dart
  /// itemBuilder: (context, suggestion) {
  ///   return ListTile(
  ///     title: Text(suggestion.name),
  ///     subtitle: Text('\$${suggestion.price}')
  ///   );
  /// }
  /// ```
  /// {@endtemplate}
  final ItemBuilder<T> itemBuilder;

  /// {@template flutter_typeahead.SuggestionsListConfig.itemSeparatorBuilder}
  /// Optional builder function to add separators between suggestions.
  ///
  /// Example usage:
  /// ```dart
  /// itemSeparatorBuilder: (context, index) => Divider(),
  /// ```
  ///
  /// Equivalent to [ListView.separated.separatorBuilder].
  /// {@endtemplate}
  final IndexedWidgetBuilder? itemSeparatorBuilder;

  /// {@template flutter_typeahead.SuggestionsListConfig.keepSuggestionsOnLoading}
  /// Whether to keep the previous suggestions visible even during loading.
  ///
  /// If enabled, [loadingBuilder] will be ignored.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool? keepSuggestionsOnLoading;

  /// {@template flutter_typeahead.SuggestionsListConfig.hideOnSelect}
  /// Whether to keep the suggestions visible even after a suggestion has been selected.
  ///
  /// Note that if this is disabled, the only way
  /// to close the suggestions box is either via the
  /// [SuggestionsController] or when the user closes the software
  /// keyboard with [hideOnUnfocus] set to true.
  ///
  /// Users with a physical keyboard will be unable to close the
  /// box without additional logic.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool? hideOnSelect;

  /// {@template flutter_typeahead.SuggestionsListConfig.layoutArchitecture}
  /// Builder function for customizing the layout of the suggestions list.
  ///
  /// A custom layout may be used to display the suggestions in a grid,
  /// or to show a header or footer above or below the list, etc.
  ///
  /// Example usage:
  /// ```dart
  /// layoutArchitecture: (items, scrollContoller) => GridView.extent(
  ///   controller: scrollContoller,
  ///   maxCrossAxisExtent: 200,
  ///   crossAxisSpacing: 8,
  ///   mainAxisSpacing: 8,
  ///   primary: false,
  ///   shrinkWrap: true,
  ///   children: items.toList(),
  /// ),
  /// ```
  ///
  /// Defaults to a vertical list.
  /// {@endtemplate}
  final LayoutArchitecture? layoutArchitecture;

  /// {@template flutter_typeahead.SuggestionsListConfig.loadingBuilder}
  /// Builder function to display a loading indicator.
  ///
  /// Called when waiting for [suggestionsCallback] to return.
  ///
  /// Example usage:
  /// ```dart
  /// loadingBuilder: (context) => Text('Loading suggestions...'),
  /// ```
  ///
  /// Defaults to a [CircularProgressIndicator].
  ///
  /// See also:
  /// * [hideOnLoading], which is whether the suggestions box should be hidden during loading.
  /// {@endtemplate}
  final WidgetBuilder? loadingBuilder;

  /// {@template flutter_typeahead.SuggestionsListConfig.minCharsForSuggestions}
  /// Minimum number of characters required for showing suggestions.
  ///
  /// Defaults to 0.
  /// {@endtemplate}
  final int? minCharsForSuggestions;

  /// {@template flutter_typeahead.SuggestionsListConfig.noItemsFoundBuilder}
  /// Builder function to display when [suggestionsCallback] returns an empty array.
  ///
  /// Example usage:
  /// ```dart
  /// noItemsFoundBuilder: (context) => Text('No Items Found!'),
  /// ```
  ///
  /// Defaults to a [Text] widget.
  /// {@endtemplate}
  final WidgetBuilder? noItemsFoundBuilder;

  /// {@template flutter_typeahead.SuggestionsListConfig.onSuggestionSelected}
  /// Called when a suggestion is selected.
  /// Receives the value of the selected suggestion.
  ///
  /// Example usage to navigate to a new page with the selected item:
  /// ```dart
  /// onSuggestionSelected: (suggestion) {
  ///   Navigator.of(context).push(MaterialPageRoute(
  ///     builder: (context) => SearchResult(
  ///       searchItem: suggestion
  ///     )
  ///   ));
  /// }
  /// ```
  ///
  /// Example usage to set the value of the text field to the selected item:
  /// ```dart
  /// onSuggestionSelected: (suggestion) {
  ///   _controller.text = suggestion.name;
  /// }
  /// ```
  /// {@endtemplate}
  final SuggestionSelectionCallback<T>? onSuggestionSelected;

  /// {@template flutter_typeahead.SuggestionsListConfig.scrollController}
  /// Controller for the scroll view containing the suggestions.
  ///
  /// See also:
  /// * [ScrollController], which is the controller used by the scroll view.
  /// * [layoutArchitecture], which is the builder function for customizing the layout of the suggestions list.
  /// {@endtemplate}
  final ScrollController? scrollController;

  /// {@template flutter_typeahead.SuggestionsListConfig.suggestionsBox}
  /// Controller to manage the state of the suggestions box.
  ///
  /// This can be used to programmatically open and close the suggestions box,
  /// or to trigger a resize after a layout change.
  /// {@endtemplate}
  final SuggestionsController suggestionsController;

  /// {@template flutter_typeahead.SuggestionsListConfig.suggestionsCallback}
  /// Called with the search pattern to get the search suggestions.
  ///
  /// This callback must not be null. It is be called by the TypeAhead widget
  /// and provided with the search pattern. It should return a [List](https://api.dartlang.org/stable/2.0.0/dart-core/List-class.html)
  /// of suggestions either synchronously, or asynchronously (as the result of a
  /// [Future](https://api.dartlang.org/stable/dart-async/Future-class.html)).
  /// Typically, the list of suggestions should not contain more than 4 or 5
  /// entries. These entries will then be provided to [itemBuilder] to display
  /// the suggestions.
  ///
  /// Example:
  /// ```dart
  /// suggestionsCallback: (pattern) async {
  ///   return await _getSuggestions(pattern);
  /// }
  /// ```
  ///
  /// See also:
  /// * [debounceDuration], which is the duration to wait for changes in the text field before updating suggestions.
  /// {@endtemplate}
  final SuggestionsCallback<T>? suggestionsCallback;

  /// {@template flutter_typeahead.SuggestionsListConfig.transitionBuilder}
  /// Builder function for animating the suggestions list.
  ///
  /// Example usage:
  /// ```dart
  /// transitionBuilder: (context, suggestionsBox, animationController) {
  ///   return FadeTransition(
  ///     child: suggestionsBox,
  ///     opacity: CurvedAnimation(
  ///       parent: animationController,
  ///       curve: Curves.fastOutSlowIn,
  ///     ),
  ///   );
  /// }
  /// ```
  ///
  /// To disable the animation, simply return `suggestionsBox`
  ///
  /// Defaults to a [SizeTransition].
  ///
  /// See also:
  /// * [animationDuration], which is the duration of the animation.
  /// * [animationStart], which is the value at which the list of suggestions should start animating.
  /// {@endtemplate}
  final AnimationTransitionBuilder? transitionBuilder;
}