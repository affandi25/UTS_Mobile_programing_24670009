import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Background Full Gold Gradient Sesuai Figma (#319:992 - fill_14f1e659)
        decoration: const BoxDecoration(
          gradient: AppColors.goldGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ilustrasi / Logo Bulat Sesuai Figma (#319:995)
                Container(
                  width: 218,
                  height: 218,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x30000000),
                        blurRadius: 28,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'asset/onboarding_donut.png',
                      width: 218,
                      height: 218,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.bakery_dining_rounded,
                        size: 110,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 52),

                // Tagline "ENJOY YOUR FOOD" (#11:43)
                const Text(
                  'ENJOY YOUR FOOD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 56),

                // Tombol "GET STARTED" Semi-Transparan Glassmorphism Sesuai Figma (#11:53 & #11:52)
                Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                    boxShadow: const [
                      BoxShadow(
                        
                        color: Color(0x20000000),
                        blurRadius: 20,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                      child: const Center(
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
