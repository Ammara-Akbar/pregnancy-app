import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'pregnant_ai_assistant_screen.dart';
import 'pregnant_community_group_screen.dart';

class _CommunityGroup {
  const _CommunityGroup({
    required this.name,
    required this.members,
    required this.image,
    this.verified = false,
  });

  final String name;
  final String members;
  final String image;
  final bool verified;
}

class _FeedPost {
  const _FeedPost({
    required this.author,
    required this.status,
    required this.timeAgo,
    required this.body,
    required this.likes,
    required this.comments,
    required this.avatarColor,
    this.followed = false,
  });

  final String author;
  final String status;
  final String timeAgo;
  final String body;
  final int likes;
  final int comments;
  final Color avatarColor;
  final bool followed;
}

const _groups = [
  _CommunityGroup(
    name: 'Pregnancy Support',
    members: '120K members',
    image: 'assets/images/community_group_pregnancy.png',
    verified: true,
  ),
  _CommunityGroup(
    name: 'Due in May 2026',
    members: '8.4K members',
    image: 'assets/images/journey_pregnant.png',
  ),
  _CommunityGroup(
    name: 'First Time Moms',
    members: '54K members',
    image: 'assets/images/community_group_pregnancy.png',
  ),
];

const _posts = [
  _FeedPost(
    author: 'Ayesha Khan',
    status: '18w Pregnant',
    timeAgo: '2h ago',
    body:
        'Feeling so many baby kicks today! Anyone else in the second trimester '
        'noticing more movement in the evenings? #Pregnancy #SecondTrimester',
    likes: 128,
    comments: 24,
    avatarColor: Color(0xFFE89AB8),
    followed: false,
  ),
  _FeedPost(
    author: 'Mehwish Ali',
    status: '26w Pregnant',
    timeAgo: '5h ago',
    body:
        'Back pain is getting real. What gentle stretches helped you most in '
        'the third trimester? Looking for tips that actually work.',
    likes: 86,
    comments: 41,
    avatarColor: Color(0xFF9B7BB8),
    followed: true,
  ),
  _FeedPost(
    author: 'Sara Ahmed',
    status: '12w Pregnant',
    timeAgo: '1d ago',
    body:
        'Just started my folic acid routine again after a busy week. Consistency '
        'is hard but so worth it. You\'ve got this, moms!',
    likes: 203,
    comments: 17,
    avatarColor: Color(0xFF5BA88A),
  ),
];

class PregnantCommunityScreen extends StatefulWidget {
  const PregnantCommunityScreen({super.key});

  @override
  State<PregnantCommunityScreen> createState() =>
      _PregnantCommunityScreenState();
}

class _PregnantCommunityScreenState extends State<PregnantCommunityScreen> {
  int _category = 0;
  int _feedTab = 0;
  final Set<String> _joined = {};
  final Set<String> _liked = {};
  final Set<String> _following = {'Mehwish Ali'};

  static const _categories = [
    (Icons.groups_rounded, 'Groups'),
    (Icons.forum_outlined, 'Discussions'),
    (Icons.psychology_outlined, 'Experts'),
    (Icons.event_outlined, 'Events'),
  ];

  static const _feedTabs = ['For You', 'Following', 'New', 'Trending'];

  void _openGroup(_CommunityGroup group) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PregnantCommunityGroupScreen(
          name: group.name,
          members: group.members,
          image: group.image,
          verified: group.verified,
        ),
      ),
    );
  }

  void _openAi() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PregnantAiAssistantScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      floatingActionButton: FloatingActionButton(
        heroTag: 'pregnant_community_fab',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create post coming soon'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: AppColors.magenta,
        child: const Icon(Icons.add_rounded, color: AppColors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 88),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Community',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Connect, share & support each other',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textDark,
                  ),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.textDark,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
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
            const SizedBox(height: 14),
            Row(
              children: [
                for (var i = 0; i < _categories.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: _CategoryCard(
                      icon: _categories[i].$1,
                      label: _categories[i].$2,
                      selected: _category == i,
                      onTap: () {
                        setState(() => _category = i);
                        if (i == 2) _openAi();
                        if (i == 0 && _groups.isNotEmpty) {
                          _openGroup(_groups.first);
                        }
                      },
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                const Text(
                  'Popular Groups',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => _openGroup(_groups.first),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.magenta,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'See All',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _groups.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final group = _groups[index];
                  final joined = _joined.contains(group.name);
                  return _PopularGroupCard(
                    group: group,
                    joined: joined,
                    onOpen: () => _openGroup(group),
                    onJoin: () => setState(() {
                      if (joined) {
                        _joined.remove(group.name);
                      } else {
                        _joined.add(group.name);
                      }
                    }),
                  );
                },
              ),
            ),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < _feedTabs.length; i++) ...[
                    GestureDetector(
                      onTap: () => setState(() => _feedTab = i),
                      child: Container(
                        margin: const EdgeInsets.only(right: 18),
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: _feedTab == i
                                  ? AppColors.magenta
                                  : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                        ),
                        child: Text(
                          _feedTabs[i],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: _feedTab == i
                                ? FontWeight.w800
                                : FontWeight.w500,
                            color: _feedTab == i
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
            const SizedBox(height: 12),
            for (final post in _posts)
              if (_feedTab != 1 || _following.contains(post.author))
                _FeedPostCard(
                  post: post,
                  liked: _liked.contains(post.author + post.timeAgo),
                  following: _following.contains(post.author),
                  onLike: () => setState(() {
                    final key = post.author + post.timeAgo;
                    if (_liked.contains(key)) {
                      _liked.remove(key);
                    } else {
                      _liked.add(key);
                    }
                  }),
                  onFollow: () => setState(() {
                    if (_following.contains(post.author)) {
                      _following.remove(post.author);
                    } else {
                      _following.add(post.author);
                    }
                  }),
                ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: _openAi,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.magenta,
                side: const BorderSide(color: AppColors.ringPink),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.auto_awesome_rounded, size: 18),
              label: const Text(
                'Ask Sehat AI Assistant',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.blush : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.magenta : AppColors.mistPink,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? AppColors.magenta : AppColors.textMuted,
                size: 22,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.burgundy : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PopularGroupCard extends StatelessWidget {
  const _PopularGroupCard({
    required this.group,
    required this.joined,
    required this.onOpen,
    required this.onJoin,
  });

  final _CommunityGroup group;
  final bool joined;
  final VoidCallback onOpen;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 148,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.mistPink),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  group.image,
                  width: 68,
                  height: 68,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                group.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                group.members,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 30,
                child: FilledButton(
                  onPressed: onJoin,
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        joined ? AppColors.blush : AppColors.magenta,
                    foregroundColor:
                        joined ? AppColors.burgundy : AppColors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    joined ? 'Joined' : 'Join',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
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

class _FeedPostCard extends StatelessWidget {
  const _FeedPostCard({
    required this.post,
    required this.liked,
    required this.following,
    required this.onLike,
    required this.onFollow,
  });

  final _FeedPost post;
  final bool liked;
  final bool following;
  final VoidCallback onLike;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: post.avatarColor.withValues(alpha: 0.25),
                child: Text(
                  post.author[0],
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: post.avatarColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.author,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: onFollow,
                          borderRadius: BorderRadius.circular(8),
                          child: Text(
                            following ? 'Following' : 'Follow',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: following
                                  ? AppColors.textMuted
                                  : AppColors.magenta,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${post.status} · ${post.timeAgo}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz_rounded, color: AppColors.skipGrey),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            post.body,
            style: const TextStyle(
              fontSize: 13,
              height: 1.45,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InkWell(
                onTap: onLike,
                child: Row(
                  children: [
                    Icon(
                      liked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 18,
                      color: liked ? AppColors.magenta : AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.likes + (liked ? 1 : 0)} Likes',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 17,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: 4),
                ],
              ),
              Text(
                '${post.comments} Comments',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.bookmark_border_rounded,
                size: 18,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
