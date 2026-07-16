import 'package:flutter/material.dart';

import '../../core/preferences/user_preferences.dart';
import '../../core/theme/app_colors.dart';
import 'bride_discussion_detail_screen.dart';
import 'bride_groups_screen.dart';

class BrideCommunityScreen extends StatefulWidget {
  const BrideCommunityScreen({super.key});

  @override
  State<BrideCommunityScreen> createState() => _BrideCommunityScreenState();
}

class _BrideCommunityScreenState extends State<BrideCommunityScreen> {
  int _tabIndex = 0;
  final _tabs = const ['For You', 'Trending', 'Groups', 'Experts'];
  final _searchController = TextEditingController();
  bool _showSearch = false;
  final Set<String> _joinedGroups = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Discussion> get _discussions {
    final desi = UserPreferences.instance.isDesi;
    final q = _searchController.text.trim().toLowerCase();
    final all = <_Discussion>[
      _Discussion(
        id: 'd1',
        title: desi
            ? 'Best diet plan before marriage?'
            : 'Best meal plan before the wedding?',
        body: desi
            ? 'Looking for Desi-friendly iron-rich meals that are easy to cook at home.'
            : 'Looking for simple international meals that boost energy and glow.',
        meta: '24 replies · 2h ago',
        tag: 'Nutrition',
        tagColor: const Color(0xFF4CAF7A),
        avatarColor: const Color(0xFFE89AB8),
        author: 'Sara M.',
        replies: 24,
        trending: true,
      ),
      _Discussion(
        id: 'd2',
        title: 'How to improve skin before the big day?',
        body:
            'My wedding is in 2 months. What simple routines actually helped you?',
        meta: '18 replies · 5h ago',
        tag: 'Beauty',
        tagColor: const Color(0xFF7E57C2),
        avatarColor: const Color(0xFFFFB74D),
        author: 'Hina K.',
        replies: 18,
        trending: true,
      ),
      _Discussion(
        id: 'd3',
        title: desi
            ? 'Which blood tests are must before nikah?'
            : 'Which health screenings matter before marriage?',
        body:
            'Please share the checklist your doctor recommended and any tips for reports.',
        meta: '31 replies · 1d ago',
        tag: 'Health',
        tagColor: AppColors.magenta,
        avatarColor: const Color(0xFF64B5F6),
        author: 'Amna R.',
        replies: 31,
        trending: true,
      ),
      _Discussion(
        id: 'd4',
        title: 'Managing wedding stress & sleep',
        body: 'I feel overwhelmed with planning. What helped you stay calm?',
        meta: '12 replies · 3h ago',
        tag: 'Wellness',
        tagColor: const Color(0xFF5BA8D9),
        avatarColor: const Color(0xFF81C784),
        author: 'Noor A.',
        replies: 12,
        trending: false,
      ),
      _Discussion(
        id: 'd5',
        title: desi
            ? 'Folic acid timing with chai & meals'
            : 'Best time to take folic acid daily',
        body: 'Do you take it morning or night? Any side effects tips?',
        meta: '9 replies · 6h ago',
        tag: 'Supplements',
        tagColor: const Color(0xFFE07A4A),
        avatarColor: const Color(0xFFBA68C8),
        author: 'Zara S.',
        replies: 9,
        trending: false,
      ),
    ];

    var list = switch (_tabIndex) {
      1 => all.where((d) => d.trending).toList(),
      _ => all,
    };

    if (q.isNotEmpty) {
      list = list
          .where(
            (d) =>
                d.title.toLowerCase().contains(q) ||
                d.tag.toLowerCase().contains(q) ||
                d.body.toLowerCase().contains(q),
          )
          .toList();
    }
    return list;
  }

  List<_Group> get _groups => const [
        _Group(
          id: 'g1',
          title: 'Bride-to-Be Support Circle',
          members: '2.4k members',
          description: 'Daily motivation, Q&A, and emotional support.',
        ),
        _Group(
          id: 'g2',
          title: 'Healthy Bride Challenge',
          members: '1.8k members',
          description: 'Walks, water goals, and meal check-ins together.',
        ),
        _Group(
          id: 'g3',
          title: 'Pre-Marriage Health Tests',
          members: '960 members',
          description: 'Share reports tips and doctor visit experiences.',
        ),
        _Group(
          id: 'g4',
          title: 'Glow & Skincare Brides',
          members: '1.2k members',
          description: 'Gentle routines and product recommendations.',
        ),
      ];

  List<_Expert> get _experts => const [
        _Expert(
          name: 'Dr. Ayesha Malik',
          specialty: 'Gynecologist',
          meta: 'MBBS, FCPS · 12 yrs exp.',
          image: 'assets/images/journey_mother_in_law.png',
        ),
        _Expert(
          name: 'Dr. Sara Khan',
          specialty: 'Nutritionist',
          meta: 'RD · Bridal wellness plans',
          image: 'assets/images/journey_bride.png',
        ),
        _Expert(
          name: 'Coach Mehwish',
          specialty: 'Fitness Coach',
          meta: 'Pre-wedding strength & mobility',
          image: 'assets/images/floral_encouragement.png',
        ),
      ];

  void _openDiscussion(_Discussion d) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BrideDiscussionDetailScreen(
          title: d.title,
          body: d.body,
          author: d.author,
          tag: d.tag,
          tagColor: d.tagColor,
          meta: d.meta,
        ),
      ),
    );
  }

  void _askExpert(_Expert expert) {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DDE2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ask ${expert.name}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                expert.specialty,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.magenta,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Type your question…',
                  filled: true,
                  fillColor: const Color(0xFFFFF5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Question sent to ${expert.name}. They usually reply within 24h.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Send question',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _createPost() {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start a discussion',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3A55),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your question or tip with other brides…',
                  filled: true,
                  fillColor: const Color(0xFFFFF5F7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your discussion was posted to For You.'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.magenta,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Post',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFF5F7),
          floatingActionButton: FloatingActionButton(
            onPressed: _createPost,
            backgroundColor: AppColors.magenta,
            child: const Icon(Icons.edit_rounded, color: Colors.white),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 88),
              children: [
                Row(
                  children: [
                    const Text(
                      'Community',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () =>
                          setState(() => _showSearch = !_showSearch),
                      icon: Icon(
                        _showSearch
                            ? Icons.close_rounded
                            : Icons.search_rounded,
                        color: const Color(0xFF2C3A55),
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  '2 new replies in your discussions',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF2C3A55),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_showSearch) ...[
                  const SizedBox(height: 4),
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search discussions, tags, groups…',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF0F5), Color(0xFFF8D7E4)],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You are not alone',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2C3A55),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              UserPreferences.instance.isDesi
                                  ? 'Connect with Desi brides — share meals, tests, and wedding-prep tips.'
                                  : 'Connect with brides worldwide — share meals, tests, and wedding-prep tips.',
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.textMuted,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/journey_bride.png',
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < _tabs.length; i++) ...[
                        GestureDetector(
                          onTap: () => setState(() => _tabIndex = i),
                          child: Container(
                            margin: const EdgeInsets.only(right: 18),
                            padding: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: _tabIndex == i
                                      ? AppColors.magenta
                                      : Colors.transparent,
                                  width: 2.5,
                                ),
                              ),
                            ),
                            child: Text(
                              _tabs[i],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: _tabIndex == i
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: _tabIndex == i
                                    ? AppColors.magenta
                                    : AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                if (_tabIndex == 2) ...[
                  _sectionHeader(
                    'Popular Groups',
                    action: 'See all',
                    onAction: () async {
                      final joined = await Navigator.of(context).push<Set<String>>(
                        MaterialPageRoute(
                          builder: (_) => BrideGroupsScreen(
                            groups: _groups
                                .map(
                                  (g) => BrideGroupItem(
                                    id: g.id,
                                    title: g.title,
                                    members: g.members,
                                    description: g.description,
                                  ),
                                )
                                .toList(),
                            joinedIds: _joinedGroups,
                          ),
                        ),
                      );
                      if (joined != null && mounted) {
                        setState(() {
                          _joinedGroups
                            ..clear()
                            ..addAll(joined);
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  for (final g in _groups) ...[
                    _GroupListTile(
                      group: g,
                      joined: _joinedGroups.contains(g.id),
                      onJoin: () {
                        setState(() {
                          if (_joinedGroups.contains(g.id)) {
                            _joinedGroups.remove(g.id);
                          } else {
                            _joinedGroups.add(g.id);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ] else if (_tabIndex == 3) ...[
                  const Text(
                    'Ask an Expert',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final expert in _experts) ...[
                    _ExpertCard(
                      expert: expert,
                      onAsk: () => _askExpert(expert),
                    ),
                    const SizedBox(height: 10),
                  ],
                ] else ...[
                  Text(
                    _tabIndex == 1 ? 'Trending now' : 'Top Discussions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3A55),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_discussions.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No discussions match your search.',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      ),
                    )
                  else
                    for (final d in _discussions)
                      _DiscussionTile(
                        discussion: d,
                        onTap: () => _openDiscussion(d),
                      ),
                  if (_tabIndex == 0) ...[
                    const SizedBox(height: 8),
                    _sectionHeader(
                      'Popular Groups',
                      action: 'See all',
                      onAction: () {
                        setState(() => _tabIndex = 2);
                      },
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 126,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _groups.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final g = _groups[index];
                          final joined = _joinedGroups.contains(g.id);
                          return _GroupCard(
                            title: g.title,
                            members: g.members,
                            joined: joined,
                            onJoin: () {
                              setState(() {
                                if (joined) {
                                  _joinedGroups.remove(g.id);
                                } else {
                                  _joinedGroups.add(g.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Ask an Expert',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _ExpertCard(
                      expert: _experts.first,
                      onAsk: () => _askExpert(_experts.first),
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sectionHeader(
    String title, {
    required String action,
    required VoidCallback onAction,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3A55),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.magenta,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            action,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _Discussion {
  const _Discussion({
    required this.id,
    required this.title,
    required this.body,
    required this.meta,
    required this.tag,
    required this.tagColor,
    required this.avatarColor,
    required this.author,
    required this.replies,
    required this.trending,
  });

  final String id;
  final String title;
  final String body;
  final String meta;
  final String tag;
  final Color tagColor;
  final Color avatarColor;
  final String author;
  final int replies;
  final bool trending;
}

class _Group {
  const _Group({
    required this.id,
    required this.title,
    required this.members,
    required this.description,
  });

  final String id;
  final String title;
  final String members;
  final String description;
}

class _Expert {
  const _Expert({
    required this.name,
    required this.specialty,
    required this.meta,
    required this.image,
  });

  final String name;
  final String specialty;
  final String meta;
  final String image;
}

class _DiscussionTile extends StatelessWidget {
  const _DiscussionTile({required this.discussion, required this.onTap});

  final _Discussion discussion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: discussion.avatarColor.withValues(alpha: 0.35),
                child: Icon(
                  Icons.person,
                  color: discussion.avatarColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      discussion.title,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2C3A55),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      discussion.meta,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: discussion.tagColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  discussion.tag,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: discussion.tagColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
    required this.title,
    required this.members,
    required this.joined,
    required this.onJoin,
  });

  final String title;
  final String members;
  final bool joined;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3A55),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            members,
            style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onJoin,
              style: TextButton.styleFrom(
                backgroundColor:
                    joined ? AppColors.magenta : const Color(0xFFFCE8EF),
                foregroundColor: joined ? Colors.white : AppColors.magenta,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                joined ? 'Joined' : 'Join',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupListTile extends StatelessWidget {
  const _GroupListTile({
    required this.group,
    required this.joined,
    required this.onJoin,
  });

  final _Group group;
  final bool joined;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFFCE8EF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.groups_rounded, color: AppColors.magenta),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${group.members} · ${group.description}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onJoin,
            style: TextButton.styleFrom(
              backgroundColor:
                  joined ? AppColors.magenta : const Color(0xFFFCE8EF),
              foregroundColor: joined ? Colors.white : AppColors.magenta,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              joined ? 'Joined' : 'Join',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpertCard extends StatelessWidget {
  const _ExpertCard({required this.expert, required this.onAsk});

  final _Expert expert;
  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.blush,
            backgroundImage: AssetImage(expert.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expert.name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3A55),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  expert.specialty,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.magenta,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  expert.meta,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onAsk,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.magenta,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Ask Now',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}
