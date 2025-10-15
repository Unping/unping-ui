Dropdown Components Implementation
Overview
We need to implement dropdown components to match our Figma design system. This includes select dropdowns, multi-select options, and other dropdown-style controls that allow users to choose from predefined options.
Requirements
Core Dropdown Components to Implement
Based on our Figma design system, implement the following dropdown components:
Basic Select Dropdown

* Single selection from a list of options
* Support for different sizes (sm, md, lg)
* Various states: default, focused, disabled, error
* Searchable option filtering
* Custom option rendering support

Multi-Select Dropdown

* Multiple selection with checkboxes
* Selected items display (chips/tags)
* Clear all functionality
* Select all/none options

Combobox

* Combination of input field and dropdown
* Type to filter options
* Add new option functionality
* Auto-complete suggestions

Menu Dropdown

* Action-based dropdown menu
* Dividers and group support
* Icons and descriptions
* Keyboard navigation

Design Reference
Figma File: figma.com/community/file/1545817431010952080
Component Section: Navigate to "Dropdowns" in the Figma file
Use the Figma MCP tools to extract design tokens and generate initial component structure
File Structure
Create the following files:
lib/src/components/dropdown/
├── base_dropdown.dart       # Core dropdown widget
├── dropdown_variants.dart   # Predefined dropdown configurations (Dropdowns class)
├── dropdown_types.dart      # Enums, option classes, and helpers
└── dropdown_menu.dart       # Menu-specific dropdown component

Implementation Checklist
1. Core Implementation
Create BaseDropdown widget with full customization options
Implement Dropdowns class with predefined variants:

* Dropdowns.select() - Single selection dropdown
* Dropdowns.multiSelect() - Multiple selection dropdown
* Dropdowns.combobox() - Searchable combo box
* Dropdowns.menu() - Action menu dropdown

Support all required states (default, open, focused, disabled, error)
Implement proper overlay positioning and scrolling
Keyboard navigation support (arrow keys, enter, escape)
Use foundation values from UiColors, UiTextStyles, UiSpacing, UiBorderRadius
2. Advanced Features

* Search/filter functionality for large option lists
* Virtual scrolling for performance with many options
* Custom option widgets support
* Grouping and divider support
* Icons and descriptions in options
* Loading states for async data

3. Testing Requirements
Create comprehensive widget tests in test/src/components/dropdown/
Test all dropdown variants and their states
Test user interactions (selection, search, keyboard navigation)
Test accessibility features (screen reader support)
Test overlay positioning and scrolling behavior
Ensure all tests pass with flutter test
4. Widgetbook Integration
Create widgetbook stories in widgetbook/lib/components/dropdown.widgetbook.dart
Show all dropdown variants with interactive examples
Demonstrate different states and configurations
Include knobs for testing different properties
Show examples with many options to test scrolling
Run:
bashDownloadCopy codecd widgetbook && dart run build_runner build -d
5. Library Integration
Export new components in lib/unping_ui.dart
Update documentation and examples
Ensure code follows Dart formatting:
bashDownloadCopy codedart format --line-length 80 lib test
Run dart analyze to ensure code quality
Development Guidelines
Using AI Tools (Encouraged!)

* Figma MCP: Use Figma MCP tools to extract design specifications and generate initial component structure
* Claude/GitHub Copilot: Use AI assistants to help with implementation, testing, and documentation
* Design Token Extraction: Use AI to help extract and implement proper design tokens from Figma

Technical Requirements
Follow Flutter/Dart best practices
Use proper state management (StatefulWidget for interactive components)
Implement proper overlay management (OverlayEntry, Positioned)
Ensure components are accessible (semantic labels, focus management)
Use consistent naming conventions (camelCase for variables, PascalCase for classes)
Handle edge cases (empty lists, loading states, errors)
Code Quality
Write comprehensive documentation comments (///) for public APIs
Follow single-responsibility principle
Reuse existing foundation components where possible
Avoid hardcoded values - use design system tokens
Implement proper error handling
Example Usage
The final implementation should support usage like:
Basic select dropdown
dartDownloadCopy codeDropdowns.select<String>(
  label: 'Country',
  options: ['USA', 'Canada', 'Mexico'],
  onChanged: (value) => print('Selected: $value'),
  placeholder: 'Choose a country',
)
Multi-select dropdown
dartDownloadCopy codeDropdowns.multiSelect<String>(
  label: 'Skills',
  options: ['Flutter', 'Dart', 'React', 'Node.js'],
  selectedValues: selectedSkills,
  onChanged: (values) => setState(() => selectedSkills = values),
)
Searchable combobox
dartDownloadCopy codeDropdowns.combobox<User>(
  label: 'Assign to',
  options: users,
  optionBuilder: (user) => Text(user.name),
  searchable: true,
  onSearch: (query) => filterUsers(query),
  onChanged: (user) => assignTask(user),
)
Action menu
dartDownloadCopy codeDropdowns.menu(
  trigger: IconButton(icon: Icon(Icons.more_vert)),
  items: [
    DropdownMenuItem(
      icon: Icon(Icons.edit),
      label: 'Edit',
      onTap: () => editItem(),
    ),
    DropdownMenuItem(
      icon: Icon(Icons.delete),
      label: 'Delete',
      onTap: () => deleteItem(),
      destructive: true,
    ),
  ],
)
Definition of Done
✅ All dropdown components implemented and working
✅ Comprehensive test coverage (run flutter test successfully)
✅ Widgetbook stories created and generated
✅ Components exported in main library
✅ Code formatted and analyzed without errors
✅ Documentation updated
✅ Accessibility features implemented and tested