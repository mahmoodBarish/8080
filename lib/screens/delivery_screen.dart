import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Added for go_router navigation

// Color Palette
const Color kDarkTextColor = Color(0xFF242424);
const Color kGreyTextColor = Color(0xFFA2A2A2);
const Color kMediumGreyTextColor = Color(0xFF808080);
const Color kOrangeBrownColor = Color(0xFFC67C4C);
const Color kGreenColor = Color(0xFF35C07E);
const Color kLightGreyColor = Color(0xFFE3E3E3);
const Color kLightButtonBgColor = Color(0xFFEDEEEE);
const Color kDarkBackgroundColor = Color(0xFF101010);
const Color kWhiteColor = Colors.white;

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Map Background (142:198)
          Positioned.fill(
            child: Image.asset(
              'assets/images/142_198.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Map Elements

          // Delivery Location Pin (142:224)
          Positioned(
            left: screenWidth * (66 / 375), // (1694 - 1628) / 375
            top: screenHeight * (211 / 812), // 211 / 812
            child: Icon(
              Icons.location_on,
              color: kOrangeBrownColor,
              size: screenWidth * (24 / 375), // 24px
            ),
          ),

          // Route Line (142:230) - Simplified representation
          Positioned(
            left: screenWidth * (81.5 / 375), // (1709.5 - 1628) / 375
            top: screenHeight * (168.5 / 812), // 168.5 / 812
            child: CustomPaint(
              size: Size(
                screenWidth * (170.5 / 375), // 170.5px
                screenHeight * (142.5 / 812), // 142.5px
              ),
              painter: RoutePainter(kOrangeBrownColor),
            ),
          ),

          // Driver Bike Icon (142:231)
          Positioned(
            left: screenWidth * (233 / 375), // (1861 - 1628) / 375
            top: screenHeight * (311 / 812), // 311 / 812
            child: Container(
              width: screenWidth * (40 / 375), // 40px
              height: screenHeight * (40 / 812), // 40px
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/I142_232_418_950.png', // Motorbike icon
                  width: screenWidth * (15 / 375), // 15px
                  height: screenHeight * (15 / 812), // 15px
                  fit: BoxFit.contain,
                  color: kOrangeBrownColor, // Apply color tint as per design
                ),
              ),
            ),
          ),

          // 3. Bottom Sheet (Detail Driver - 142:199)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * (322 / 812), // 322px height
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * (24 / 375), // From (1652 - 1628)
                  vertical: screenHeight * (16 / 812), // Estimated vertical padding
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indicator (142:223)
                    Container(
                      width: screenWidth * (45 / 375), // 45px width
                      height: screenHeight * (5 / 812), // 5px height
                      decoration: BoxDecoration(
                        color: kLightGreyColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(height: screenHeight * (20 / 812)), // Estimated spacing

                    // Delivery time and location (142:215)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '10 minutes left',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kDarkTextColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * (2 / 812)), // 2px spacing
                        Text(
                          'Delivery to Jl. Kpg Sutoyo',
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kMediumGreyTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * (20 / 812)), // Estimated spacing

                    // Progress Bar (142:218)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildProgressBarSegment(screenWidth, kGreenColor),
                        _buildProgressBarSegment(screenWidth, kGreenColor),
                        _buildProgressBarSegment(screenWidth, kGreenColor),
                        _buildProgressBarSegment(screenWidth, kLightGreyColor),
                      ],
                    ),
                    SizedBox(height: screenHeight * (20 / 812)), // Estimated spacing

                    // Delivered order info (142:210)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: kLightGreyColor, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * (12 / 375), // 12px
                        vertical: screenHeight * (8 / 812), // 8px
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * (56 / 375), // 56px
                            height: screenHeight * (56 / 812), // 56px
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/I142_211_418_950.png', // Motorbike icon
                                width: screenWidth * (27.5 / 375), // 27.5px
                                height: screenHeight * (27.5 / 812), // 27.5px
                                fit: BoxFit.contain,
                                color: kOrangeBrownColor,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * (16 / 375)), // 16px spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivered your order',
                                  style: GoogleFonts.sora(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkTextColor,
                                  ),
                                ),
                                SizedBox(height: screenHeight * (4 / 812)), // 4px spacing
                                Text(
                                  'We will deliver your goods to you in\nthe shortes possible time.',
                                  style: GoogleFonts.sora(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: kGreyTextColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * (20 / 812)), // Estimated spacing

                    // Driver Profile and Call Button (142:200)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Driver Profile Image (142:203)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                'assets/images/142_203.png', // Driver profile image
                                width: screenWidth * (56 / 375), // 56px
                                height: screenHeight * (56 / 812), // 56px
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: screenWidth * (16 / 375)), // 16px spacing
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Brooklyn Simmons',
                                  style: GoogleFonts.sora(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: kDarkTextColor,
                                  ),
                                ),
                                SizedBox(height: screenHeight * (4 / 812)), // 4px spacing
                                Text(
                                  'Personal Courier',
                                  style: GoogleFonts.sora(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kGreyTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Call Button (142:207)
                        GestureDetector(
                          onTap: () {
                            // Implement call functionality
                            debugPrint('Call button tapped!');
                          },
                          child: Container(
                            width: screenWidth * (44 / 375), // 44px
                            height: screenHeight * (44 / 812), // 44px
                            decoration: BoxDecoration(
                              border: Border.all(color: kLightGreyColor, width: 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.phone, // Standard phone icon
                                color: kDarkTextColor,
                                size: screenWidth * (24 / 375), // 24px
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Header (Delivery Info - 142:233)
          Positioned(
            top: screenHeight * (68 / 812), // 68px from top
            left: screenWidth * (24 / 375), // (1652 - 1628) / 375
            right: screenWidth * (24 / 375), // (1975 - (1628+327)) / 375
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button (142:234)
                GestureDetector(
                  onTap: () {
                    context.pop(); // Replaced Navigator.pop with context.pop
                  },
                  child: Container(
                    width: screenWidth * (44 / 375), // 44px
                    height: screenHeight * (44 / 812), // 44px
                    decoration: BoxDecoration(
                      color: kLightButtonBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new, // Standard back icon
                        color: kDarkTextColor,
                        size: screenWidth * (18 / 375), // Estimated size
                      ),
                    ),
                  ),
                ),
                // GPS Icon (142:237)
                GestureDetector(
                  onTap: () {
                    debugPrint('GPS icon tapped!');
                  },
                  child: Container(
                    width: screenWidth * (44 / 375), // 44px
                    height: screenHeight * (44 / 812), // 44px
                    decoration: BoxDecoration(
                      color: kLightButtonBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.gps_fixed, // Standard GPS icon
                        color: kDarkTextColor,
                        size: screenWidth * (24 / 375), // 24px
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 5. Status Bar (Iphone Time - 142:248)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildStatusBar(screenWidth, screenHeight),
          ),

          // 6. Home Indicator (Iphone Home Indicator - 142:249)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildHomeIndicator(screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBarSegment(double screenWidth, Color color) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildStatusBar(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * (44 / 812), // Figma height 44
      padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 375)), // Estimated padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '9:41',
            style: GoogleFonts.sora(
              fontSize: 15, // Estimated font size
              fontWeight: FontWeight.w600,
              color: kDarkTextColor,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_alt, size: 17, color: kDarkTextColor),
              SizedBox(width: screenWidth * 0.01),
              Icon(Icons.wifi, size: 17, color: kDarkTextColor),
              SizedBox(width: screenWidth * 0.01),
              Icon(Icons.battery_full, size: 17, color: kDarkTextColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHomeIndicator(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * (34 / 812), // Figma height 34
      alignment: Alignment.center,
      child: Container(
        width: screenWidth * (134 / 375), // 134px
        height: 5,
        decoration: BoxDecoration(
          color: kDarkBackgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}

// Custom Painter for the route line (simplified representation)
class RoutePainter extends CustomPainter {
  final Color routeColor;

  RoutePainter(this.routeColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = routeColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Approximate path based on bounding box from JSON
    // Start from top-left, curve down and right
    path.moveTo(size.width * 0.0, size.height * 0.0);
    path.cubicTo(
      size.width * 0.25, size.height * 0.5,
      size.width * 0.75, size.height * 0.5,
      size.width * 1.0, size.height * 1.0,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}