import 'package:auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const List<Map<String, String>> content = [
  {
    'image': 'lib/assets/images/onboard-1.png',
    'title': 'The Simple Way to',
    'subtitle': 'find the best! 👌',
    'description':
        'Aenean eu lacinia ligula. Quisque eu risus erat. Aenean placerat sollicitudin lectus.',
  },
  {
    'image': 'lib/assets/images/onboard-2.png',
    'title': 'The Best Design',
    'subtitle': 'Strategy! ✍️',
    'description':
        'Aenean eu lacinia ligula. Quisque eu risus erat. Aenean placerat sollicitudin lectus.',
  },
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  SharedPreferences? prefs;
  int _currentPageIndex = 0;
  final PageController _pageController = PageController(
    keepPage: true,
  );

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.setBool('hasOpenedApp', true);
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3B4054),
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff3B4054),
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: content.length,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPageIndex = value;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            content[_currentPageIndex]['image'] ??
                                'lib/assets/images/onboard-1.png',
                            height: 302,
                          ),
                          const SizedBox(height: 50),
                          Text(
                            content[_currentPageIndex]['title'] ?? 'Kosong',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            content[_currentPageIndex]['subtitle'] ?? 'Kosong',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            content[_currentPageIndex]['description'] ??
                                'Kosong',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xffC8D2DE),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: content.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Color(0xffD6DFFF),
                      activeDotColor: Color(0xff5D81FD),
                      dotWidth: 15,
                      dotHeight: 4,
                    ),
                  ),
                  const Spacer(flex: 1),
                  TextButton(
                    onPressed: () {
                      if (_currentPageIndex + 1 == content.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        _currentPageIndex++;
                        return;
                      }
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                    },
                    child: Text(
                      _currentPageIndex + 1 == content.length ? 'Done' : 'Next',
                      style: const TextStyle(
                        color: Color(0xffC8D2DE),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
