import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_constants.dart';
import '../models/onboarding_data.dart';
import '../providers/onboarding_provider.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';
import '../../home/screens/home_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final List<OnboardingData> _pages = OnboardingData.pages;

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(currentPageProvider);
    final isLastPage = ref.watch(isLastPageProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // SVG de fondo en la parte inferior
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(
                'assets/images/onbbg.svg',
                width: screenWidth,
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
                colorFilter: ColorFilter.mode(
                  _pages[currentPage].bgColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            // Contenido principal
            Column(
              children: [
                _buildSkipButton(),
                _buildPageView(),
                const SizedBox(height: 20),
                PageIndicator(
                  currentPage: currentPage,
                  pages: _pages,
                ),
                const SizedBox(height: 40),
                _buildNavigationButton(isLastPage, currentPage),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: _goToHome,
          child: const Text(AppConstants.onboardingSkip),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(currentPageProvider.notifier).state = index;
        },
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return OnboardingPage(data: _pages[index]);
        },
      ),
    );
  }

  Widget _buildNavigationButton(bool isLastPage, int currentPage) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: AppConstants.buttonHeight,
        child: ElevatedButton(
          onPressed: () => _handleNavigationButton(isLastPage),
          style: ElevatedButton.styleFrom(
            backgroundColor: _pages[currentPage].color,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isLastPage
                ? AppConstants.onboardingStart
                : AppConstants.onboardingNext,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigationButton(bool isLastPage) {
    if (isLastPage) {
      _goToHome();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}