import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class PregnantCommunityGroupScreen extends StatefulWidget {
  const PregnantCommunityGroupScreen({
    super.key,
    required this.name,
    required this.members,
    required this.image,
    this.verified = false,
  });

  final String name;
  final String members;
  final String image;
  final bool verified;

  @override
  State<PregnantCommunityGroupScreen> createState() =>
      _PregnantCommunityGroupScreenState();
}

class _PregnantCommunityGroupScreenState
    extends State<PregnantCommunityGroupScreen> {
  int _tab = 0;
  int _filter = 0;
  bool _joined = false;

  static const _tabs = ['Discussion', 'Members', 'Guides', 'About'];
  static const _filters = [
    'All',
    'Questions',
    'Experiences',
    'Tips',
    'Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softPink,
      appBar: AppBar(
        backgroundColor: AppColors.softPink,
        elevation: 0,
        foregroundColor: AppColors.burgundy,
        title: const Text(
          'Group',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.ios_share_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: AppColors.blush,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.ringPink, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(widget.image, fit: BoxFit.cover),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.burgundy,
                            ),
                          ),
                        ),
                        if (widget.verified) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.magenta,
                            size: 18,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Public Group',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'A safe space for pregnant moms to share tips, ask '
                      'questions and support each other.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SizedBox(
                width: 72,
                height: 28,
                child: Stack(
                  children: [
                    for (var i = 0; i < 3; i++)
                      Positioned(
                        left: i * 18.0,
                        child: CircleAvatar(
                          radius: 14,
                          backgroundColor: [
                            AppColors.magenta,
                            AppColors.iconBaby,
                            AppColors.iconHealth,
                          ][i],
                          child: Text(
                            ['A', 'M', 'S'][i],
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                widget.members,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => setState(() => _joined = !_joined),
                style: FilledButton.styleFrom(
                  backgroundColor: _joined
                      ? AppColors.blush
                      : AppColors.magenta,
                  foregroundColor: _joined
                      ? AppColors.burgundy
                      : AppColors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  minimumSize: const Size(0, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _joined ? 'Joined' : 'Join Group',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.blush,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.mistPink),
            ),
            child: Row(
              children: [
                for (var i = 0; i < _tabs.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () => setState(() => _tab = i),
                      borderRadius: BorderRadius.circular(11),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        decoration: BoxDecoration(
                          color: _tab == i
                              ? AppColors.magenta
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text(
                          _tabs[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: _tab == i
                                ? AppColors.white
                                : AppColors.burgundy,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (_tab == 0) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.magenta.withValues(
                          alpha: 0.15,
                        ),
                        child: const Text(
                          'Y',
                          style: TextStyle(
                            color: AppColors.magenta,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          "What's on your mind?",
                          style: TextStyle(
                            fontSize: 13.5,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      _ComposeChip(icon: Icons.photo_outlined, label: 'Photo'),
                      SizedBox(width: 8),
                      _ComposeChip(icon: Icons.poll_outlined, label: 'Poll'),
                      SizedBox(width: 8),
                      _ComposeChip(
                        icon: Icons.emoji_emotions_outlined,
                        label: 'Feeling',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < _filters.length; i++) ...[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_filters[i]),
                        selected: _filter == i,
                        onSelected: (_) => setState(() => _filter = i),
                        selectedColor: AppColors.magenta,
                        backgroundColor: AppColors.white,
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _filter == i
                              ? AppColors.white
                              : AppColors.burgundy,
                        ),
                        side: BorderSide(
                          color: _filter == i
                              ? AppColors.magenta
                              : AppColors.mistPink,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _PinnedPostCard(),
            const SizedBox(height: 10),
            const _GroupPostCard(
              author: 'Mehwish Ali',
              meta: '26w Pregnant · 3h ago',
              body:
                  'Has anyone tried sleeping with a pregnancy pillow? '
                  'My hips hurt every night and I need recommendations.',
              likes: 54,
              comments: 19,
              avatarColor: AppColors.iconBaby,
            ),
            const SizedBox(height: 10),
            const _GroupPostCard(
              author: 'Ayesha Khan',
              meta: '18w Pregnant · 6h ago',
              body:
                  'Shared a gentle walk routine that helped my energy this week. '
                  'Happy to send details if anyone wants them!',
              likes: 91,
              comments: 12,
              avatarColor: AppColors.magentaBright,
            ),
          ] else if (_tab == 1) ...[
            for (final member in const [
              ('Dr. Sarah Ahmed', 'OB/GYN · Moderator'),
              ('Ayesha Khan', '18w Pregnant'),
              ('Mehwish Ali', '26w Pregnant'),
              ('Sara Ahmed', '12w Pregnant'),
              ('Hina Raza', '32w Pregnant'),
            ])
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.blush,
                      child: Text(
                        member.$1[0],
                        style: const TextStyle(
                          color: AppColors.magenta,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            member.$1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            member.$2,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ] else if (_tab == 2) ...[
            for (final guide in const [
              ('Kick counting basics', '5 min read'),
              ('Safe second-trimester stretches', '7 min read'),
              ('When to call your doctor', '4 min read'),
            ])
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.mistPink),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.blush,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: AppColors.magenta,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guide.$1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            guide.$2,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.skipGrey,
                    ),
                  ],
                ),
              ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.mistPink),
              ),
              child: const Text(
                'Pregnancy Support is a moderated community for expecting '
                'mothers. Share experiences kindly, avoid medical diagnosis '
                'claims, and seek urgent care from your maternity team when '
                'needed.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ComposeChip extends StatelessWidget {
  const _ComposeChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.blush,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: AppColors.magenta),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: AppColors.burgundy,
            ),
          ),
        ],
      ),
    );
  }
}

class _PinnedPostCard extends StatelessWidget {
  const _PinnedPostCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ringPink),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.push_pin_rounded, size: 16, color: AppColors.magenta),
              SizedBox(width: 6),
              Text(
                'Pinned',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.magenta,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.blush,
                child: Text(
                  'S',
                  style: TextStyle(
                    color: AppColors.magenta,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Sarah Ahmed (OB/GYN)',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'Moderator · Welcome guide',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Welcome to Pregnancy Support! Please introduce yourself, share '
            'your week if you like, and ask questions kindly. This is a '
            'judgment-free space.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupPostCard extends StatelessWidget {
  const _GroupPostCard({
    required this.author,
    required this.meta,
    required this.body,
    required this.likes,
    required this.comments,
    required this.avatarColor,
  });

  final String author;
  final String meta;
  final String body;
  final int likes;
  final int comments;
  final Color avatarColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mistPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: avatarColor.withValues(alpha: 0.2),
                child: Text(
                  author[0],
                  style: TextStyle(
                    color: avatarColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      meta,
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
            body,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$likes Likes · $comments Comments',
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
