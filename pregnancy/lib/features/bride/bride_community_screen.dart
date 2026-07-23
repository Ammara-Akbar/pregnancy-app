import 'package:flutter/material.dart';

import 'bride_discussion_detail_screen.dart';
import 'bride_groups_screen.dart';

class BrideCommunityScreen extends StatefulWidget {
  const BrideCommunityScreen({super.key});

  @override
  State<BrideCommunityScreen> createState() => _BrideCommunityScreenState();
}

class _BrideCommunityScreenState extends State<BrideCommunityScreen> {
  int _tabIndex = 0;
  final _tabs = const ['For You', 'Groups', 'Q&A', 'Experts'];
  final Set<String> _joinedGroups = {};

  static const _pink = Color(0xFFE91E63);
  static const _navy = Color(0xFF1A1C3D);

  void _openDiscussion(_Discussion d) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BrideDiscussionDetailScreen(
          title: d.title,
          body: d.body,
          author: d.author,
          tag: d.tag,
          tagColor: _pink,
          meta: d.meta,
        ),
      ),
    );
  }

  void _askExpert() {
    final controller = TextEditingController();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
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
                'Ask Dr. Ayesha Malik',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _navy,
                ),
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(content: Text('Question sent to expert')),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: _pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Send'),
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        heroTag: 'bride_community_fab',
        backgroundColor: _pink,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Start a new discussion')),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 88),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Community',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _navy,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded, color: _navy),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: _navy,
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
            const SizedBox(height: 8),
            const _HeroBanner(),
            const SizedBox(height: 16),
            _TabBar(
              tabs: _tabs,
              index: _tabIndex,
              onChanged: (i) => setState(() => _tabIndex = i),
            ),
            const SizedBox(height: 18),
            if (_tabIndex == 0 || _tabIndex == 2) ...[
              _SectionHeader(
                title: 'Trending Discussions',
                onSeeAll: () {},
              ),
              const SizedBox(height: 10),
              ..._discussions.map(
                (d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _DiscussionTile(
                    discussion: d,
                    onTap: () => _openDiscussion(d),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            if (_tabIndex == 0 || _tabIndex == 1) ...[
              _SectionHeader(
                title: 'Popular Groups',
                onSeeAll: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BrideGroupsScreen(
                        groups: _groups
                            .map(
                              (g) => BrideGroupItem(
                                id: g.id,
                                title: g.title,
                                members: g.members,
                                description: 'Connect with fellow brides.',
                              ),
                            )
                            .toList(),
                        joinedIds: Set.of(_joinedGroups),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 132,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _groups.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final g = _groups[index];
                    final joined = _joinedGroups.contains(g.id);
                    return _GroupCard(
                      group: g,
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
            ],
            if (_tabIndex == 0 || _tabIndex == 3) ...[
              _SectionHeader(title: 'Ask an Expert', onSeeAll: () {}),
              const SizedBox(height: 10),
              _ExpertCard(onAsk: _askExpert),
            ],
          ],
        ),
      ),
    );
  }

  static const _discussions = [
    _Discussion(
      title: 'What diet helped you get glowing skin before the wedding?',
      meta: '128 replies • 2h ago',
      tag: 'Nutrition',
      author: 'Sara M.',
      body:
          'Looking for simple Desi-friendly meals that helped with glow and energy.',
      avatar: 'assets/images/bride_community_avatar1.png',
    ),
    _Discussion(
      title: 'How do you manage wedding stress without burning out?',
      meta: '96 replies • 5h ago',
      tag: 'Wellness',
      author: 'Hina K.',
      body: 'Share routines that helped you stay calm during planning.',
      avatar: 'assets/images/bride_community_avatar2.png',
    ),
    _Discussion(
      title: 'Best skincare routine 60 days before the big day?',
      meta: '74 replies • 1d ago',
      tag: 'Beauty',
      author: 'Noor A.',
      body: 'Gentle products and habits that actually worked for you.',
      avatar: 'assets/images/bride_community_avatar3.png',
    ),
  ];

  static const _groups = [
    _Group(
      id: 'g1',
      title: 'Bride-to-Be Support Circle',
      members: '12.5K members',
    ),
    _Group(
      id: 'g2',
      title: 'Healthy Bride Challenge',
      members: '8.2K members',
    ),
    _Group(
      id: 'g3',
      title: 'Glow & Skincare Brides',
      members: '6.1K members',
    ),
  ];
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF0F5), Color(0xFFFDE2E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -8,
            top: 0,
            bottom: 0,
            width: 150,
            child: Image.asset(
              'assets/images/bride_community_hero.png',
              fit: BoxFit.cover,
              alignment: Alignment.centerRight,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFFFF0F5),
                    const Color(0xFFFFF0F5).withValues(alpha: 0.9),
                    const Color(0xFFFFF0F5).withValues(alpha: 0.25),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.42, 0.62, 0.85],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 140, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You are not alone 💕',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1C3D),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Connect, share and learn with brides on the same beautiful journey.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: Color(0xFF5A5660),
                    fontWeight: FontWeight.w500,
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

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.tabs,
    required this.index,
    required this.onChanged,
  });

  final List<String> tabs;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < tabs.length; i++)
          Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      tabs[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight:
                            i == index ? FontWeight.w800 : FontWeight.w500,
                        color: i == index
                            ? const Color(0xFFE91E63)
                            : const Color(0xFF8A8490),
                      ),
                    ),
                  ),
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: i == index
                          ? const Color(0xFFE91E63)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1C3D),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: onSeeAll,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFFE91E63),
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'See all',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _DiscussionTile extends StatelessWidget {
  const _DiscussionTile({required this.discussion, required this.onTap});

  final _Discussion discussion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(discussion.avatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discussion.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1C3D),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  discussion.meta,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8A8490),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              discussion.tag,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFFE91E63),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({
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
      width: 188,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A1C3D),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            group.members,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF8A8490),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: onJoin,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE91E63),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE91E63)),
              minimumSize: const Size(double.infinity, 32),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              joined ? 'Joined' : 'Join',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpertCard extends StatelessWidget {
  const _ExpertCard({required this.onAsk});

  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3E8ED)),
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
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/bride_community_expert.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Ayesha Malik',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1C3D),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Nutritionist',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5A5660),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '8 yrs experience',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF8A8490),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onAsk,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFE91E63),
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFE91E63)),
              minimumSize: const Size(0, 34),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Ask Now',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _Discussion {
  const _Discussion({
    required this.title,
    required this.meta,
    required this.tag,
    required this.author,
    required this.body,
    required this.avatar,
  });

  final String title;
  final String meta;
  final String tag;
  final String author;
  final String body;
  final String avatar;
}

class _Group {
  const _Group({
    required this.id,
    required this.title,
    required this.members,
  });

  final String id;
  final String title;
  final String members;
}
