import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Colors used across the Home Screen (dark theme)
// ---------------------------------------------------------------------------
const Color _bgColor = Color(0xFF0B1020); // dark navy background
const Color _cardColor = Color(0xFF151B30); // card backgrou
const Color _borderColor = Color(0xFF262F50); // subtle card border
const Color _purple = Color(0xFF8B5CF6);
const Color _blue = Color(0xFF3B82F6);
const Color _cyan = Color(0xFF22D3EE);
const Color _mutedText = Color(0xFFA3ADC7);
const Color _textColor = Colors.white; // main text color
const Color _softBlue = Color(0xFF1E2A4F); // soft icon background

// Soft shadow shared by all cards
const List<BoxShadow> _cardShadow = [
  BoxShadow(
    color: Colors.black26,
    blurRadius: 10,
    offset: Offset(0, 3),
  ),
];

// ---------------------------------------------------------------------------
// Home Screen: top bar + 4 tabs + bottom navigation (all in this one file)
// ---------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  void _goTo(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _HomeTab(onOpenProgram: () => _goTo(1)),
      const _LearnTab(),
      const _ScheduleTab(),
      const _ProfileTab(),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Light status bar icons on the dark background
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _bgColor,
        appBar: AppBar(
          backgroundColor: _cardColor,
          surfaceTintColor: _cardColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 16,
          title: const Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [_purple, _cyan]),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SizedBox(
                  width: 34,
                  height: 34,
                  child: Icon(
                    Icons.terminal_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'ApnaCode',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {}, // visual only
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: _textColor,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16, left: 4),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: _softBlue,
                child: Icon(Icons.person_rounded, size: 20, color: _cyan),
              ),
            ),
          ],
          // Thin line under the app bar
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, thickness: 1, color: _borderColor),
          ),
        ),
        body: SafeArea(child: pages[_index]),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final bool selected = states.contains(WidgetState.selected);
              return TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected ? _cyan : _mutedText,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: _goTo,
            backgroundColor: _cardColor,
            surfaceTintColor: _cardColor,
            indicatorColor: _softBlue,
            height: 68,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: _mutedText),
                selectedIcon: Icon(Icons.home_rounded, color: _cyan),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined, color: _mutedText),
                selectedIcon: Icon(Icons.menu_book_rounded, color: _cyan),
                label: 'Learn',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined, color: _mutedText),
                selectedIcon: Icon(Icons.calendar_month_rounded, color: _cyan),
                label: 'Schedule',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded, color: _mutedText),
                selectedIcon: Icon(Icons.person_rounded, color: _cyan),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared page wrapper: scrolling, padding, max width
// ---------------------------------------------------------------------------
class _PageScroll extends StatelessWidget {
  final List<Widget> children;

  const _PageScroll({required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 1: Home
// ---------------------------------------------------------------------------
class _HomeTab extends StatelessWidget {
  final VoidCallback onOpenProgram;

  const _HomeTab({required this.onOpenProgram});

  @override
  Widget build(BuildContext context) {
    return _PageScroll(
      children: [
        const _WelcomeSection(),
        const SizedBox(height: 18),
        const _SearchBar(),
        const SizedBox(height: 24),
        const _SectionTitle('Explore Skills'),
        const SizedBox(height: 12),
        const _CategoryList(),
        const SizedBox(height: 24),
        const _SectionTitle('Your Learning Program'),
        const SizedBox(height: 12),
        _ProgramCard(onTap: onOpenProgram),
        const SizedBox(height: 24),
        const _SectionTitle('Learning Modules'),
        const SizedBox(height: 12),
        const _ModulesGrid(),
        const SizedBox(height: 24),
        const _SectionTitle('Weekly Schedule'),
        const SizedBox(height: 12),
        const _ScheduleList(),
        const SizedBox(height: 24),
        const _SectionTitle('Learning Journey'),
        const SizedBox(height: 12),
        const _JourneyCard(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 2: Learn (modules)
// ---------------------------------------------------------------------------
class _LearnTab extends StatelessWidget {
  const _LearnTab();

  @override
  Widget build(BuildContext context) {
    return const _PageScroll(
      children: [
        _SectionTitle('Learning Modules'),
        SizedBox(height: 12),
        _ModulesGrid(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 3: Schedule
// ---------------------------------------------------------------------------
class _ScheduleTab extends StatelessWidget {
  const _ScheduleTab();

  @override
  Widget build(BuildContext context) {
    return const _PageScroll(
      children: [
        _SectionTitle('Weekly Schedule'),
        SizedBox(height: 12),
        _ScheduleList(),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// TAB 4: Profile (simple placeholder)
// ---------------------------------------------------------------------------
class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: _softBlue,
                child: Icon(Icons.person_rounded, size: 44, color: _cyan),
              ),
              const SizedBox(height: 14),
              const Text(
                'Learner',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Profile details will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: _mutedText),
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable: section title
// ---------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: _textColor,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable: small rounded icon box
// ---------------------------------------------------------------------------
class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const _IconBox({required this.icon, required this.color, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: size * 0.55),
    );
  }
}

// ---------------------------------------------------------------------------
// Welcome section
// ---------------------------------------------------------------------------
class _WelcomeSection extends StatelessWidget {
  const _WelcomeSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Learner! 👋',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Ready to continue your coding journey?',
          style: TextStyle(fontSize: 14, color: _mutedText),
        ),
        SizedBox(height: 6),
        Text(
          'ApnaCode Premium Batch',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _cyan,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Search bar (visual only)
// ---------------------------------------------------------------------------
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: _borderColor),
    );

    return TextField(
      style: const TextStyle(color: _textColor),
      cursorColor: _cyan,
      decoration: InputDecoration(
        hintText: 'Search topics, skills...',
        hintStyle: const TextStyle(color: _mutedText, fontSize: 14),
        prefixIcon: const Icon(Icons.search_rounded, color: _mutedText),
        filled: true,
        fillColor: _cardColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: border,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _cyan, width: 1.5),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Explore Skills: horizontally scrollable category chips (visual only)
// ---------------------------------------------------------------------------
class _Category {
  final String title;
  final IconData icon;

  const _Category(this.title, this.icon);
}

const List<_Category> _categories = [
  _Category('Java', Icons.coffee_rounded),
  _Category('DSA', Icons.account_tree_rounded),
  _Category('Problem Solving', Icons.lightbulb_rounded),
  _Category('Competitive Programming', Icons.emoji_events_rounded),
  _Category('Interview Preparation', Icons.record_voice_over_rounded),
];

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        physics: const BouncingScrollPhysics(),
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return _CategoryChip(category: _categories[index]);
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final _Category category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _borderColor),
        boxShadow: _cardShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(category.icon, size: 18, color: _cyan),
          const SizedBox(width: 8),
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Your Learning Program: course-style card
// ---------------------------------------------------------------------------
class _ProgramCard extends StatelessWidget {
  final VoidCallback onTap;

  const _ProgramCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _cardColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _borderColor),
            boxShadow: _cardShadow,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Small coding-themed icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_purple, _blue],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Premium badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _purple.withAlpha(50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.workspace_premium_rounded,
                            size: 12,
                            color: _purple,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Premium',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ApnaCode Premium Batch',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Coding + DSA + Placement Preparation',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _cyan,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'A complete program to build coding skills, practice problem solving and get ready for placements.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: _mutedText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Icon(Icons.chevron_right_rounded, color: _mutedText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Learning Modules: compact grid
// ---------------------------------------------------------------------------
class _Module {
  final String title;
  final IconData icon;

  const _Module(this.title, this.icon);
}

const List<_Module> _modules = [
  _Module('Java Programming', Icons.coffee_rounded),
  _Module('DSA & Problem Solving', Icons.account_tree_rounded),
  _Module('LeetCode + Codeforces', Icons.code_rounded),
  _Module('Competitive Programming', Icons.emoji_events_rounded),
  _Module('Mock Interviews', Icons.mic_rounded),
  _Module('Resume Building', Icons.description_rounded),
  _Module('Communication Skills', Icons.forum_rounded),
  _Module('Technical Interview Preparation', Icons.psychology_rounded),
];

const List<Color> _accents = [_blue, _purple, _cyan];

class _ModulesGrid extends StatelessWidget {
  const _ModulesGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 2 columns on phones, 4 columns on wider screens
        final int columns = constraints.maxWidth > 560 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _modules.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 116,
          ),
          itemBuilder: (context, index) {
            return _ModuleCard(
              module: _modules[index],
              accent: _accents[index % _accents.length],
            );
          },
        );
      },
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final _Module module;
  final Color accent;

  const _ModuleCard({required this.module, required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: _cardShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon: module.icon, color: accent, size: 38),
          const SizedBox(height: 10),
          Text(
            module.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _textColor,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Weekly Schedule: two compact horizontal cards
// ---------------------------------------------------------------------------
class _ScheduleList extends StatelessWidget {
  const _ScheduleList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ScheduleCard(
          label: 'Weekdays',
          days: 'Monday – Friday',
          icon: Icons.school_rounded,
          accent: _cyan,
          items: ['DSA', 'Coding Practice'],
        ),
        SizedBox(height: 12),
        _ScheduleCard(
          label: 'Weekends',
          days: 'Saturday – Sunday',
          icon: Icons.event_available_rounded,
          accent: _purple,
          items: ['Interviews', 'Resume', 'Placement Preparation'],
        ),
      ],
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String label;
  final String days;
  final IconData icon;
  final Color accent;
  final List<String> items;

  const _ScheduleCard({
    required this.label,
    required this.days,
    required this.icon,
    required this.accent,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: _cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBox(icon: icon, color: accent, size: 44),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: accent,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  days,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 10),
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16,
                          color: accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 13.5,
                              color: _textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Learning Journey: compact step-style card
// ---------------------------------------------------------------------------
class _Step {
  final String label;
  final IconData icon;

  const _Step(this.label, this.icon);
}

const List<_Step> _steps = [
  _Step('Learn', Icons.menu_book_rounded),
  _Step('Practice', Icons.code_rounded),
  _Step('Compete', Icons.emoji_events_rounded),
  _Step('Interview Ready', Icons.work_rounded),
];

class _JourneyCard extends StatelessWidget {
  const _JourneyCard();

  @override
  Widget build(BuildContext context) {
    final List<Widget> row = [];

    for (int i = 0; i < _steps.length; i++) {
      row.add(Expanded(child: _StepItem(step: _steps[i])));

      // Small arrow between steps
      if (i != _steps.length - 1) {
        row.add(
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: _mutedText,
            ),
          ),
        );
      }
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor),
        boxShadow: _cardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: row,
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final _Step step;

  const _StepItem({required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: _softBlue,
            shape: BoxShape.circle,
          ),
          child: Icon(step.icon, size: 20, color: _cyan),
        ),
        const SizedBox(height: 8),
        Text(
          step.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: _textColor,
          ),
        ),
      ],
    );
  }
}