import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Added for go_router navigation

class DetailItemScreen extends StatefulWidget {
  static const String routeName = '/detailItem';

  const DetailItemScreen({super.key});

  @override
  State<DetailItemScreen> createState() => _DetailItemScreenState();
}

class _DetailItemScreenState extends State<DetailItemScreen> {
  String _selectedSize = 'M'; // Default selected size

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: screenHeight * 0.15, // Adjust for the top bar
                bottom: screenHeight * 0.15, // Adjust for the bottom button bar
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064), // 24/375
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/I142_377_417_715.png',
                        width: double.infinity,
                        height: screenHeight * 0.25, // Approx 202/812
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03), // ~24px spacing
                    // Product Name and Type
                    Text(
                      'Caffe Mocha',
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF242424),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005), // ~4px spacing
                    Text(
                      'Ice/Hot',
                      style: GoogleFonts.sora(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFA2A2A2),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // ~16px spacing
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: const Color(0xFFFBCF21),
                          size: screenWidth * 0.053, // 20/375
                        ),
                        SizedBox(width: screenWidth * 0.01), // ~4px spacing
                        Text(
                          '4.8',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2A2A2A),
                          ),
                        ),
                        Text(
                          ' (230)',
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFA2A2A2),
                          ),
                        ),
                        const Spacer(),
                        // Superiority icons
                        _buildSuperiorityIcon(
                          'assets/images/I142_371_418_950.png',
                          const Color(0xFFC67C4E), // Primary Accent color
                        ),
                        SizedBox(width: screenWidth * 0.032), // 12px
                        _buildSuperiorityIcon(
                          'assets/images/I142_373_418_971.png',
                          const Color(0xFFC67C4E), // Primary Accent color
                        ),
                        SizedBox(width: screenWidth * 0.032), // 12px
                        _buildSuperiorityIcon(
                          'assets/images/I142_375_418_967.png',
                          const Color(0xFFC67C4E), // Primary Accent color
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02), // 16px
                    // Divider
                    const Divider(
                      color: Color(0xFFE3E3E3),
                      thickness: 1,
                    ),
                    SizedBox(height: screenHeight * 0.02), // 16px

                    // Description
                    Text(
                      'Description',
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF242424),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01), // 8px
                    Text(
                      'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo..',
                      style: GoogleFonts.sora(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFA2A2A2),
                        height: 1.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          // Handle Read More tap
                        },
                        child: Text(
                          'Read More',
                          style: GoogleFonts.sora(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFC67C4E),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // ~16px spacing
                    // Size selection
                    Text(
                      'Size',
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF242424),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02), // 16px
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['S', 'M', 'L'].map((size) {
                        bool isSelected = _selectedSize == size;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSize = size;
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.256, // 96/375
                            height: screenHeight * 0.05, // 41/812
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFF7F2EE) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFC67C4E) : const Color(0xFFE3E3E3),
                                width: 1,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: isSelected ? const Color(0xFFC67C4E) : const Color(0xFF242424),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white, // Background for the top bar
                padding: EdgeInsets.only(
                  top: mediaQuery.padding.top + screenHeight * 0.022, // 18px top padding + status bar height
                  bottom: screenHeight * 0.015, // 12px bottom padding
                  left: screenWidth * 0.064, // 24px left padding
                  right: screenWidth * 0.064, // 24px right padding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop(); // Replaced Navigator.pop with context.pop
                      },
                      child: Container(
                        width: screenWidth * 0.117, // 44/375
                        height: screenWidth * 0.117, // 44/375
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.transparent), // No border, just for tap area
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: const Color(0xFF2A2A2A),
                          size: screenWidth * 0.05, // Approx 18px
                        ),
                      ),
                    ),
                    Text(
                      'Detail',
                      style: GoogleFonts.sora(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF242424),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Handle favourite tap
                      },
                      child: Container(
                        width: screenWidth * 0.117, // 44/375
                        height: screenWidth * 0.117, // 44/375
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.transparent), // No border, just for tap area
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: const Color(0xFF2A2A2A),
                          size: screenWidth * 0.05, // Approx 20px
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom Action Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: screenWidth * 0.064, // 24px
                  right: screenWidth * 0.064, // 24px
                  top: screenHeight * 0.02, // 16px
                  bottom: mediaQuery.padding.bottom + screenHeight * 0.02, // 46px + bottom safe area
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price',
                          style: GoogleFonts.sora(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF909090),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005), // 4px
                        Text(
                          '\$ 4.53',
                          style: GoogleFonts.sora(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFC67C4E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.09), // 34px
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/cart'); // Replaced Navigator.pushNamed with context.push
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC67C4E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02), // 16px
                          elevation: 0,
                        ),
                        child: Text(
                          'Buy Now',
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuperiorityIcon(String assetPath, Color iconColor) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Container(
      width: screenWidth * 0.117, // 44/375
      height: screenWidth * 0.117, // 44/375
      decoration: BoxDecoration(
        color: const Color(0xFFEDEEEE).withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10), // 6px padding around icon itself
      child: Image.asset(
        assetPath,
        color: iconColor,
        width: screenWidth * 0.064, // 24/375 (icon size)
        height: screenWidth * 0.064, // 24/375 (icon size)
      ),
    );
  }
}