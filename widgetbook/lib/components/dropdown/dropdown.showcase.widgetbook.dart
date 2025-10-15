import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_workspace/utils/container.widgetbook.dart';

/// Sample data for dropdown options
final _countriesShort = ['USA', 'Canada', 'Mexico', 'UK', 'France'];

final _countriesLong = [
  'United States',
  'Canada',
  'Mexico',
  'United Kingdom',
  'France',
  'Germany',
  'Spain',
  'Italy',
  'Netherlands',
  'Belgium',
  'Switzerland',
  'Austria',
  'Sweden',
  'Norway',
  'Denmark',
  'Finland',
  'Poland',
  'Portugal',
  'Greece',
  'Ireland',
  'Czech Republic',
  'Hungary',
  'Romania',
  'Bulgaria',
  'Croatia',
  'Slovenia',
  'Slovakia',
  'Estonia',
  'Latvia',
  'Lithuania',
  'Luxembourg',
  'Malta',
  'Cyprus',
];

final _skills = [
  'Flutter',
  'Dart',
  'React',
  'TypeScript',
  'JavaScript',
  'Python',
  'Java',
  'Kotlin',
  'Swift',
  'Go',
];

@widgetbook.UseCase(
  name: 'Single Select',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildDropdownSingleSelect(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Single Select'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic single select
        _SectionTitle(title: 'Basic Single Select'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Country',
                placeholder: 'Select a country',
                options: _countriesShort,
                selectedValue: null,
                onChanged: (value) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Country',
                placeholder: 'Select a country',
                options: _countriesShort,
                selectedValue: 'USA',
                onChanged: (value) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Country',
                placeholder: 'Select a country',
                helperText: 'Choose your country',
                options: _countriesShort,
                selectedValue: null,
                onChanged: (value) {},
              ),
            ),
          ],
        ),

        // Different sizes
        _SectionTitle(title: 'Sizes'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Small',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                size: DropdownSize.sm,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Medium',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                size: DropdownSize.md,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Large',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                size: DropdownSize.lg,
              ),
            ),
          ],
        ),

        // States
        _SectionTitle(title: 'States'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Normal',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                forceState: DropdownState.normal,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Focused',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                forceState: DropdownState.focused,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Disabled',
                placeholder: 'Select...',
                options: _countriesShort,
                onChanged: (value) {},
                enabled: false,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Error',
                placeholder: 'Select...',
                errorText: 'This field is required',
                options: _countriesShort,
                onChanged: (value) {},
              ),
            ),
          ],
        ),

        // With icons/prefix
        _SectionTitle(title: 'With Prefix Icons'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Country',
                placeholder: 'Search country...',
                options: _countriesShort,
                onChanged: (value) {},
                prefix:
                    Icon(Icons.search, size: 20, color: UiColors.neutral400),
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Location',
                placeholder: 'Choose location...',
                options: _countriesShort,
                onChanged: (value) {},
                prefix: Icon(Icons.location_on,
                    size: 20, color: UiColors.neutral400),
              ),
            ),
          ],
        ),

        // Searchable with many options
        _SectionTitle(title: 'Searchable (Many Options)'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Country',
                placeholder: 'Search countries...',
                helperText:
                    'Type to search from ${_countriesLong.length} countries',
                options: _countriesLong,
                onChanged: (value) {},
                searchable: true,
                searchPlaceholder: 'Search...',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Multi Select',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildDropdownMultiSelect(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Multi Select'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic multi select
        _SectionTitle(title: 'Basic Multi Select'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Skills',
                placeholder: 'Select skills...',
                options: _skills,
                selectedValues: [],
                onChanged: (values) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Skills',
                placeholder: 'Select skills...',
                options: _skills,
                selectedValues: ['Flutter', 'Dart'],
                onChanged: (values) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Skills',
                placeholder: 'Select skills...',
                helperText: '3 selected',
                options: _skills,
                selectedValues: ['Flutter', 'Dart', 'React'],
                onChanged: (values) {},
              ),
            ),
          ],
        ),

        // Different sizes
        _SectionTitle(title: 'Sizes'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Small',
                placeholder: 'Select...',
                options: _skills,
                onChanged: (values) {},
                size: DropdownSize.sm,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Medium',
                placeholder: 'Select...',
                options: _skills,
                onChanged: (values) {},
                size: DropdownSize.md,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Large',
                placeholder: 'Select...',
                options: _skills,
                onChanged: (values) {},
                size: DropdownSize.lg,
              ),
            ),
          ],
        ),

        // States
        _SectionTitle(title: 'States'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Normal',
                placeholder: 'Select...',
                options: _skills,
                onChanged: (values) {},
                forceState: DropdownState.normal,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Focused',
                placeholder: 'Select...',
                options: _skills,
                onChanged: (values) {},
                forceState: DropdownState.focused,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Disabled',
                placeholder: 'Select...',
                options: _skills,
                selectedValues: ['Flutter', 'Dart'],
                onChanged: (values) {},
                enabled: false,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Error',
                placeholder: 'Select...',
                errorText: 'At least one required',
                options: _skills,
                onChanged: (values) {},
              ),
            ),
          ],
        ),

        // Searchable
        _SectionTitle(title: 'Searchable Multi Select'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Countries',
                placeholder: 'Search and select...',
                helperText: 'Select multiple countries',
                options: _countriesLong,
                selectedValues: ['United States', 'Canada'],
                onChanged: (values) {},
                searchable: true,
                searchPlaceholder: 'Type to search...',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Combobox',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildDropdownCombobox(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Combobox'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic combobox
        _SectionTitle(title: 'Searchable Combobox'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Assign to',
                placeholder: 'Search users...',
                options: [
                  'John Doe',
                  'Jane Smith',
                  'Bob Johnson',
                  'Alice Williams',
                  'Charlie Brown',
                ],
                optionBuilder: (user) => Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: UiColors.primary600,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          user[0],
                          style: UiTextStyles.textSm.copyWith(
                            color: UiColors.neutral800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      user,
                      style: UiTextStyles.textMd.copyWith(
                        color: UiColors.onPrimary,
                      ),
                    ),
                  ],
                ),
                onChanged: (value) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Assign to',
                placeholder: 'Search users...',
                options: [
                  'John Doe',
                  'Jane Smith',
                  'Bob Johnson',
                ],
                selectedValue: 'John Doe',
                optionBuilder: (user) => Text(
                  user,
                  style:
                      UiTextStyles.textMd.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),

        // Different sizes
        _SectionTitle(title: 'Sizes'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Small',
                placeholder: 'Search...',
                options: _countriesShort,
                size: DropdownSize.sm,
                optionBuilder: (country) => Text(
                  country,
                  style:
                      UiTextStyles.textSm.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Medium',
                placeholder: 'Search...',
                options: _countriesShort,
                size: DropdownSize.md,
                optionBuilder: (country) => Text(
                  country,
                  style:
                      UiTextStyles.textMd.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Large',
                placeholder: 'Search...',
                options: _countriesShort,
                size: DropdownSize.lg,
                optionBuilder: (country) => Text(
                  country,
                  style:
                      UiTextStyles.textLg.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
              ),
            ),
          ],
        ),

        // States
        _SectionTitle(title: 'States'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Normal',
                placeholder: 'Search...',
                options: _countriesShort,
                optionBuilder: (c) => Text(c,
                    style: UiTextStyles.textMd
                        .copyWith(color: UiColors.onPrimary)),
                onChanged: (value) {},
                forceState: DropdownState.normal,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Focused',
                placeholder: 'Search...',
                options: _countriesShort,
                optionBuilder: (c) => Text(c,
                    style: UiTextStyles.textMd
                        .copyWith(color: UiColors.onPrimary)),
                onChanged: (value) {},
                forceState: DropdownState.focused,
              ),
            ),
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Disabled',
                placeholder: 'Search...',
                options: _countriesShort,
                selectedValue: 'USA',
                optionBuilder: (c) => Text(c,
                    style: UiTextStyles.textMd
                        .copyWith(color: UiColors.onPrimary)),
                onChanged: (value) {},
                enabled: false,
              ),
            ),
          ],
        ),

        // With many options
        _SectionTitle(title: 'Many Options (Scrollable)'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Country',
                placeholder: 'Type to search...',
                helperText: 'Search from ${_countriesLong.length} countries',
                options: _countriesLong,
                optionBuilder: (country) => Text(
                  country,
                  style:
                      UiTextStyles.textMd.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
                menuMaxHeight: 300,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Action Menu',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildDropdownActionMenu(BuildContext context) {
  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Action Menu'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Basic action menu
        _SectionTitle(title: 'Basic Action Menu'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Dropdowns.menu(
                trigger: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: UiColors.neutral600,
                    borderRadius: BorderRadius.circular(UiRadius.sm),
                    border: Border.all(color: UiColors.neutral500),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.more_vert,
                          size: 20, color: UiColors.onPrimary),
                    ],
                  ),
                ),
                items: [
                  DropdownMenuAction(
                    icon: Icon(Icons.edit, size: 16, color: UiColors.onPrimary),
                    label: 'Edit',
                    onTap: () => debugPrint('Edit'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.copy, size: 16, color: UiColors.onPrimary),
                    label: 'Duplicate',
                    onTap: () => debugPrint('Duplicate'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.archive,
                        size: 16, color: UiColors.onPrimary),
                    label: 'Archive',
                    onTap: () => debugPrint('Archive'),
                    showDivider: true,
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.delete, size: 16, color: UiColors.error),
                    label: 'Delete',
                    onTap: () => debugPrint('Delete'),
                    destructive: true,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Dropdowns.menu(
                trigger: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: UiColors.primary600,
                    borderRadius: BorderRadius.circular(UiRadius.sm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Actions',
                        style: UiTextStyles.textMd.copyWith(
                          color: UiColors.neutral800,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_drop_down,
                          size: 20, color: UiColors.neutral800),
                    ],
                  ),
                ),
                items: [
                  DropdownMenuAction(
                    icon: Icon(Icons.download,
                        size: 16, color: UiColors.onPrimary),
                    label: 'Download',
                    shortcut: '⌘D',
                    onTap: () => debugPrint('Download'),
                  ),
                  DropdownMenuAction(
                    icon:
                        Icon(Icons.share, size: 16, color: UiColors.onPrimary),
                    label: 'Share',
                    shortcut: '⌘S',
                    onTap: () => debugPrint('Share'),
                  ),
                  DropdownMenuAction(
                    icon:
                        Icon(Icons.print, size: 16, color: UiColors.onPrimary),
                    label: 'Print',
                    shortcut: '⌘P',
                    onTap: () => debugPrint('Print'),
                  ),
                ],
              ),
            ),
          ],
        ),

        // With keyboard shortcuts
        _SectionTitle(title: 'With Keyboard Shortcuts'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Dropdowns.menu(
                trigger: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: UiColors.neutral600,
                    borderRadius: BorderRadius.circular(UiRadius.sm),
                    border: Border.all(color: UiColors.neutral500),
                  ),
                  child:
                      Icon(Icons.settings, size: 20, color: UiColors.onPrimary),
                ),
                items: [
                  DropdownMenuAction(
                    icon: Icon(Icons.save, size: 16, color: UiColors.onPrimary),
                    label: 'Save',
                    shortcut: '⌘S',
                    onTap: () => debugPrint('Save'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.undo, size: 16, color: UiColors.onPrimary),
                    label: 'Undo',
                    shortcut: '⌘Z',
                    onTap: () => debugPrint('Undo'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.redo, size: 16, color: UiColors.onPrimary),
                    label: 'Redo',
                    shortcut: '⌘⇧Z',
                    onTap: () => debugPrint('Redo'),
                    showDivider: true,
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.settings,
                        size: 16, color: UiColors.onPrimary),
                    label: 'Preferences',
                    shortcut: '⌘,',
                    onTap: () => debugPrint('Preferences'),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Disabled items
        _SectionTitle(title: 'With Disabled Items'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Dropdowns.menu(
                trigger: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: UiColors.neutral600,
                    borderRadius: BorderRadius.circular(UiRadius.sm),
                    border: Border.all(color: UiColors.neutral500),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'File',
                        style: UiTextStyles.textMd
                            .copyWith(color: UiColors.onPrimary),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_drop_down,
                          size: 20, color: UiColors.onPrimary),
                    ],
                  ),
                ),
                items: [
                  DropdownMenuAction(
                    icon: Icon(Icons.create_new_folder,
                        size: 16, color: UiColors.onPrimary),
                    label: 'New',
                    onTap: () => debugPrint('New'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.file_open,
                        size: 16, color: UiColors.neutral400),
                    label: 'Open',
                    enabled: false,
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.save, size: 16, color: UiColors.onPrimary),
                    label: 'Save',
                    onTap: () => debugPrint('Save'),
                  ),
                  DropdownMenuAction(
                    icon: Icon(Icons.save_as,
                        size: 16, color: UiColors.neutral400),
                    label: 'Save As',
                    enabled: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Scrolling Examples',
  type: BaseDropdown,
  path: 'Components/Dropdown/Showcase',
)
Widget buildDropdownScrolling(BuildContext context) {
  // Generate many options for testing scrolling
  final manyOptions = List.generate(50, (index) => 'Option ${index + 1}');
  final manyCountries = List.generate(100, (index) => 'Country ${index + 1}');

  return UnpingUIContainer(
    breadcrumbs: ['Components', 'Dropdown', 'Scrolling Examples'],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: '50 Options (Single Select)'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.select<String>(
                label: 'Select from 50 options',
                placeholder: 'Choose an option...',
                helperText: 'Scroll to see all options',
                options: manyOptions,
                onChanged: (value) {},
                menuMaxHeight: 300,
              ),
            ),
          ],
        ),
        _SectionTitle(title: '100 Options with Search (Multi Select)'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.multiSelect<String>(
                label: 'Select countries',
                placeholder: 'Search and select...',
                helperText: 'Use search to filter 100 countries',
                options: manyCountries,
                selectedValues: ['Country 1', 'Country 5', 'Country 10'],
                onChanged: (values) {},
                searchable: true,
                searchPlaceholder: 'Type to search...',
                menuMaxHeight: 350,
              ),
            ),
          ],
        ),
        _SectionTitle(title: 'Combobox with 50 Options'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DropdownWrapper(
              child: Dropdowns.combobox<String>(
                label: 'Search from 50 options',
                placeholder: 'Type to filter...',
                helperText: 'Searchable dropdown with many items',
                options: manyOptions,
                optionBuilder: (option) => Text(
                  option,
                  style:
                      UiTextStyles.textMd.copyWith(color: UiColors.onPrimary),
                ),
                onChanged: (value) {},
                menuMaxHeight: 280,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Helper widgets

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, bottom: 12),
      child: Text(
        title,
        style: UiTextStyles.textLg.copyWith(
          color: UiColors.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DropdownWrapper extends StatelessWidget {
  final Widget child;

  const _DropdownWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(maxWidth: 320),
      child: child,
    );
  }
}
