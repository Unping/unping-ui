import 'package:flutter/widgets.dart';
import 'package:unping_ui/unping_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(
  name: 'Badge with Image',
  type: BaseBadge,
)
Widget badgeWithImage(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
          ),
        ),
      ]),
      // Image with removable option
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Image with Counters
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 5),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 324),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 52),
          ),
        ),
      ]
      ),
      // Image with Checkbox
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
          ),
        ),
      ]
      ),
      // Image with Checkbox removable
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Image with Checkbox and Count
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 3),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeImage(
              imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
            ),
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 8754),
          ),
        ),
      ]
      ),
    ],
  );
}

@UseCase(
  name: 'Badge with Text',
  type: BaseBadge,
)
Widget badge(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.lg,
          ),
        ),
      ]),
      // Image with removable option
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Image with Counters
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 5),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 324),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 52),
          ),
        ),
      ]
      ),
      // Image with Checkbox
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.lg,
          ),
        ),
      ]
      ),
      // Image with Checkbox removable
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Image with Checkbox and Count
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 3),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 8754),
          ),
        ),
      ]
      ),
    ],
  );
}


@UseCase(
  name: 'Badge with Widget',
  type: BaseBadge,
)
Widget badgeWithWidget(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Basic dot examples
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.lg,
          ),
        ),
      ]),
      // Dot with removable option
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Dot with Counters
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 5),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 324),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: const BadgeDot(),
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 52),
          ),
        ),
      ]
      ),
      // Dot with Checkbox (matching Figma design)
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.sm,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.md,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.lg,
          ),
        ),
      ]
      ),
      // Dot with Checkbox removable
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.sm,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.md,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.lg,
            removable: true,
            onRemove: () {
              // Handle remove action
            },
          ),
        ),
      ]
      ),
      // Dot with Checkbox and Count (matching Figma design)
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.sm,
            rightWidget: const BadgeCount(count: 15),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: true),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.md,
            rightWidget: const BadgeCount(count: 3),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Badges.badge(
            text: 'Label',
            leftWidget1: Badges.checkbox(isChecked: false),
            leftWidget2: const BadgeDot(),
            size: BadgeSize.lg,
            rightWidget: const BadgeCount(count: 8754),
          ),
        ),
      ]
      ),
    ],
  );
}


@UseCase(
  name: 'Badge Checkbox Component',
  type: BaseCheckbox,
)
Widget badgeCheckboxComponent(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isChecked = false;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Interactive checkbox
          Container(
            padding: const EdgeInsets.all(16),
            child: Badges.checkbox(
              isChecked: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
          ),
          // Static checkboxes for visual reference
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Badges.checkbox(isChecked: false),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Badges.checkbox(isChecked: true),
              ),
            ],
          ),
        ],
      );
    },
  );
}

@UseCase(
  name: 'Badge Image Component',
  type: BadgeImage,
)
Widget badgeImageComponent(BuildContext context) {
  return const BadgeImage(
    imageUrl: 'http://localhost:3845/assets/08a3b47613f2d0f6aced2c3c467602e3aa1638f1.png',
  );
}

@UseCase(
  name: 'Badge Count Component',
  type: BadgeCount,
)
Widget badgeCountComponent(BuildContext context) {
  return const BadgeCount(count: 42);
}

@UseCase(
  name: 'Badge Dot Component',
  type: BadgeDot,
)
Widget badgeDotComponent(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 6.0,
            color: Color(0xFF17B26A), // Success green
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 8.0,
            color: Color(0xFF17B26A), // Success green
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 10.0,
            color: Color(0xFF17B26A), // Success green
          ),
        ),
      ]),
      // With different colors
      Row(children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 8.0,
            color: Color(0xFF17B26A), // Green
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 8.0,
            color: Color(0xFFF04438), // Red
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 8.0,
            color: Color(0xFF2E90FA), // Blue
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: const BadgeDot(
            size: 8.0,
            color: Color(0xFFF79009), // Orange
          ),
        ),
      ]),
    ],
  );
}

@UseCase(
  name: 'Interactive Badge with Checkbox',
  type: BaseBadge,
)
Widget interactiveBadgeWithCheckbox(BuildContext context) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isChecked1 = false;
      bool isChecked2 = true;
      bool isChecked3 = false;
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Click checkboxes to toggle state:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101828),
            ),
          ),
          SizedBox(height: 16),
          Row(children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Badges.badge(
                text: 'Interactive',
                leftWidget1: Badges.checkbox(
                  isChecked: isChecked1,
                  onChanged: (value) {
                    setState(() {
                      isChecked1 = value;
                    });
                  },
                ),
                size: BadgeSize.sm,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Badges.badge(
                text: 'Clickable',
                leftWidget1: Badges.checkbox(
                  isChecked: isChecked2,
                  onChanged: (value) {
                    setState(() {
                      isChecked2 = value;
                    });
                  },
                ),
                size: BadgeSize.md,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Badges.badge(
                text: 'Checkbox',
                leftWidget1: Badges.checkbox(
                  isChecked: isChecked3,
                  onChanged: (value) {
                    setState(() {
                      isChecked3 = value;
                    });
                  },
                ),
                size: BadgeSize.lg,
              ),
            ),
          ]),
          SizedBox(height: 16),
          // With removable and counter
          Row(children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Badges.badge(
                text: 'Advanced',
                leftWidget1: Badges.checkbox(
                  isChecked: isChecked1,
                  onChanged: (value) {
                    setState(() {
                      isChecked1 = value;
                    });
                  },
                ),
                leftWidget2: const BadgeDot(),
                rightWidget: const BadgeCount(count: 42),
                size: BadgeSize.md,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Badges.badge(
                text: 'Removable',
                leftWidget1: Badges.checkbox(
                  isChecked: isChecked2,
                  onChanged: (value) {
                    setState(() {
                      isChecked2 = value;
                    });
                  },
                ),
                size: BadgeSize.md,
                removable: true,
                onRemove: () {
                  // Handle remove action
                },
              ),
            ),
          ]),
        ],
      );
    },
  );
}
