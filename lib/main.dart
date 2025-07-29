import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pro_blog/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const defultFontFamily = 'Avenir';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primaryTextColor = Color(0xff0d253C);
    final secondaryTextColor = Color(0xff2D4379);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: defultFontFamily,
            fontSize: 24,
            color: primaryTextColor,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w200,
            fontFamily: defultFontFamily,
            color: secondaryTextColor,
            fontSize: 18,
          ),
          titleLarge: TextStyle(
            fontFamily: defultFontFamily,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: defultFontFamily,
            color: secondaryTextColor,
            fontSize: 12,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final stories = AppDatabase.stories;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Jonathan!',
                      style: themeData.textTheme.titleMedium,
                    ),
                    Image.asset(
                      'assets/img/icons/notification.png',
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 16.0),
                child: Text(
                  'Explore today\'s',
                  style: themeData.textTheme.headlineMedium,
                ),
              ),
              _StoryList(stories: stories),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({super.key, required this.stories});

  final List<StoryData> stories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 102.0,
      child: ListView.builder(
        itemCount: stories.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
        itemBuilder: (context, index) {
          final story = stories[index];
          return _story(story: story);
        },
      ),
    );
  }
}

class _story extends StatelessWidget {
  const _story({super.key, required this.story});

  final StoryData story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 0.0),
      child: Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _profileImageViewed() : _profileImageNormal(),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(story.name),
        ],
      ),
    );
  }

  Container _profileImageNormal() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff376AED), Color(0xff49B0E2), Color(0xff9CECFB)],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23.0),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(5.0),
        child: _profileImage(),
      ),
    );
  }

  Widget _profileImageViewed() {
    return SizedBox(
      width: 68,
      height: 68,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [6, 4],
          strokeWidth: 3,
          padding: const EdgeInsets.all(6.0),
          radius: const Radius.circular(23),
          color: const Color(0xff7B8BB2),
        ),

        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.0)),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Image.asset('assets/img/stories/${story.imageFileName}'),
    );
  }
}
