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
          titleMedium: TextStyle(
            fontFamily: defultFontFamily,
            color: secondaryTextColor,
            fontSize: 14,
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
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 24.0),
                child: Text(
                  'Explore today\'s',
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: ListView.builder(
                  itemCount: stories.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 0.0),
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xff376AED),
                                      Color(0xff49B0E2),
                                      Color(0xff9CECFB),
                                    ],
                                  ),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.asset(
                                      'assets/img/stories/${story.imageFileName}',
                                    ),
                                  ),
                                ),
                              ),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
