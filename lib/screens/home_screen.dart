import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Home screen with bottom navigation
// ---------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // One page for each bottom navigation item
  final List<Widget> _pages = const [
    _HomeTab(),
    _PlaceholderPage(
      icon: Icons.menu_book_outlined,
      title: 'Courses',
      message: 'Your courses will appear here.',
    ),
    _PlaceholderPage(
      icon: Icons.fitness_center_outlined,
      title: 'Practice',
      message: 'Practice problems will appear here.',
    ),
    _ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            activeIcon: Icon(Icons.fitness_center),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data for the Explore cards
// ---------------------------------------------------------------------------
class _ExploreItem {
  final String title;
  final IconData icon;

  const _ExploreItem(this.title, this.icon);
}

const List<_ExploreItem> _exploreItems = [
  _ExploreItem('Courses', Icons.menu_book),
  _ExploreItem('Practice', Icons.fitness_center),
  _ExploreItem('Projects', Icons.folder_open),
  _ExploreItem('Challenges', Icons.emoji_events),
];

// ---------------------------------------------------------------------------
// Home tab (main content)
// ---------------------------------------------------------------------------
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    final Color blue = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              Text(
                'Hello, Learner!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Continue your coding journey.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Search bar
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Search courses, topics...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 28),

              // Explore section
              const _SectionTitle('Explore'),
              const SizedBox(height: 12),
              LayoutBuilder(
                builder: (context, constraints) {
                  // 2 columns on phones, 4 columns on wide screens
                  final int columns = constraints.maxWidth > 600 ? 4 : 2;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _exploreItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 120,
                    ),
                    itemBuilder: (context, index) {
                      final item = _exploreItems[index];
                      return _ExploreCard(title: item.title, icon: item.icon);
                    },
                  );
                },
              ),
              const SizedBox(height: 28),

              // Recent Activity section
              const _SectionTitle('Recent Activity'),
              const SizedBox(height: 12),
              const _ActivityTile(
                title: 'Dart Basics',
                subtitle: 'Lesson 4 • 60% complete',
                icon: Icons.flutter_dash,
                progress: 0.6,
              ),
              const SizedBox(height: 12),
              const _ActivityTile(
                title: 'Java Programming',
                subtitle: 'Lesson 2 • 30% complete',
                icon: Icons.coffee,
                progress: 0.3,
              ),
              const SizedBox(height: 12),
              const _ActivityTile(
                title: 'DSA Practice',
                subtitle: '12 problems solved',
                icon: Icons.account_tree,
                progress: 0.45,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small reusable widgets
// ---------------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ExploreCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final Color blue = Theme.of(context).colorScheme.primary;

    return Material(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$title coming soon')),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final double progress;

  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final Color blue = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: blue),
          ),
          const SizedBox(width: 14),
          // Expanded stops the text from overflowing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.blue.shade50,
                    color: blue,
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
// Placeholder pages
// ---------------------------------------------------------------------------
class _PlaceholderPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _PlaceholderPage({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final Color blue = Theme.of(context).colorScheme.primary;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: blue),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    final Color blue = Theme.of(context).colorScheme.primary;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: blue,
                child: const Icon(Icons.person, size: 48, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Learner',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Profile details will appear here.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
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