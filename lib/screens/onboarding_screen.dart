import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Added for go_router navigation

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // The design is based on a screen height of 812. We'll use this for responsive scaling.
    const double designScreenHeight = 812;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Image Onboarding frame)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // Height based on Figma's absoluteBoundingBox for the image frame (536px)
            height: screenHeight * (536 / designScreenHeight),
            child: Image.asset(
              'assets/images/I142_500_417_719.png',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay and content at the bottom (Container frame)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            // Height based on Figma's absoluteBoundingBox for the container (360px)
            height: screenHeight * (360 / designScreenHeight),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Gradient stops from Figma's "Shadow Container" fill properties
                  stops: const [0.0, 0.2367],
                  colors: [
                    const Color(0x00050505), // r:0.0196 g:0.0196 b:0.0196 a:0
                    const Color(0xFF050505), // r:0.0196 g:0.0196 b:0.0196 a:1
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Align content to the bottom
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Fall in Love with Coffee in Blissful Delight!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 32,
                        fontWeight: FontWeight.w600, // SemiBold
                        color: Colors.white,
                        letterSpacing: 0.16,
                        height: 48 / 32, // Figma lineHeightPx: 48, fontSize: 32
                      ),
                    ),
                    SizedBox(
                        height: screenHeight *
                            (8 / designScreenHeight)), // Spacing between title and description
                    Text(
                      'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 14,
                        fontWeight: FontWeight.w400, // Regular
                        color: const Color(0xFFA2A2A2), // r:0.635 g:0.635 b:0.635 a:1
                        letterSpacing: 0.14,
                        height: 21 / 14, // Figma lineHeightPx: 21, fontSize: 14
                      ),
                    ),
                    SizedBox(
                        height: screenHeight *
                            (32 /
                                designScreenHeight)), // Spacing between description and button (702-628-42 = 32px)
                    SizedBox(
                      width: double.infinity, // Occupy full width within padding
                      height: 56, // Fixed height from Figma's "Button" frame
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/home'); // Navigate to home screen using go_router
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFC67C4E), // r:0.776 g:0.486 b:0.305 a:1
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Get Started',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // SemiBold
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: screenHeight *
                            (54 /
                                designScreenHeight)), // Spacing from bottom of button to screen edge (812 - (702+56) = 54px)
                  ],
                ),
              ),
            ),
          ),
          // Status bar (Iphone frame, type 'Time')
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false, // Don't apply safe area to the bottom of this widget, only top
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '9:41', // Text from Figma's "9:41" vector
                      style: GoogleFonts.sora(
                        fontSize: 15, // Inferred from common status bar sizes
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: const [
                        // Representing "Mobile Signal" I142:509;417:339
                        Icon(Icons.signal_cellular_alt, color: Colors.white, size: 17),
                        SizedBox(width: 4),
                        // Representing "Wifi" I142:509;417:335
                        Icon(Icons.wifi, color: Colors.white, size: 17),
                        SizedBox(width: 4),
                        // Representing "Battery" I142:509;417:331
                        Icon(Icons.battery_full, color: Colors.white, size: 17),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Home Indicator (Iphone frame, type 'Home Indicator')
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false, // Only apply bottom safe area to prevent double padding with status bar
              child: Center(
                child: Container(
                  // Figma shows Home Indicator at y=799, height=5, screenHeight=812.
                  // This means 812 - 799 - 5 = 8px margin from the bottom of the screen.
                  margin: const EdgeInsets.only(bottom: 8.0),
                  width: 134, // From Figma I142:508;417:328 width
                  height: 5, // From Figma I142:508;417:328 height
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424), // r:0.141 g:0.141 b:0.141 a:1
                    borderRadius: BorderRadius.circular(100), // Very rounded corners
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}