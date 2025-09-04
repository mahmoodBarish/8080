import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Added for go_router navigation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedIndex = 0; // For bottom navigation bar

  final List<String> _categories = [
    'All Coffee',
    'Machiato',
    'Latte',
    'Americano',
  ];

  final List<Map<String, dynamic>> _products = [
    {
      'id': 'I142:401;417:715',
      'name': 'Caffe Mocha',
      'description': 'Deep Foam',
      'price': '4.53',
      'rating': '4.8',
    },
    {
      'id': 'I142:417;417:717',
      'name': 'Flat White',
      'description': 'Espresso',
      'price': '3.53',
      'rating': '4.8',
    },
    {
      'id': 'I142:449;417:716',
      'name': 'Mocha Fusi',
      'description': 'Ice/Hot',
      'price': '7.53',
      'rating': '4.8',
    },
    {
      'id': 'I142:433;417:718',
      'name': 'Caffe Panna',
      'description': 'Ice/Hot',
      'price': '5.53',
      'rating': '4.8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Standard Figma screen size for ratio calculations
    const double figmaWidth = 375;
    const double figmaHeight = 812;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, // For white status bar icons/text
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9), // Light background for the scrollable content area
        body: Stack(
          children: [
            // Top Gradient Background (fixed, behind scrollable content)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * (280 / figmaHeight),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      const Color(0xFF111111), // Darkest Grey
                      const Color(0xFF313131), // Dark Grey
                    ],
                  ),
                ),
              ),
            ),

            // Main Scrollable Content
            Positioned(
              top: screenHeight * (44 / figmaHeight), // Below status bar
              left: 0,
              right: 0,
              // Account for bottom nav bar (99px) + home indicator (34px) = 133px
              bottom: screenHeight * (133 / figmaHeight),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * (24 / figmaWidth)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * (24 / figmaHeight)), // Space from top of scrollable area to Location
                    _buildLocationAndProfile(screenWidth, figmaWidth),
                    SizedBox(height: screenHeight * (17 / figmaHeight)),
                    _buildSearchBar(screenWidth, figmaWidth, figmaHeight),
                    SizedBox(height: screenHeight * (26 / figmaHeight)),
                    _buildPromoBanner(screenWidth, screenHeight, figmaWidth, figmaHeight),
                    SizedBox(height: screenHeight * (24 / figmaHeight)),
                    _buildCategoryChips(screenWidth, figmaWidth),
                    SizedBox(height: screenHeight * (16 / figmaHeight)),
                    _buildProductGrid(screenWidth, screenHeight, figmaWidth, figmaHeight),
                    SizedBox(height: screenHeight * (16 / figmaHeight)), // Ensure some padding at the very bottom of scrollable content
                  ],
                ),
              ),
            ),

            // Custom Status Bar (Replicated from Figma, for dark background)
            _buildStatusBar(screenWidth, figmaWidth),

            // Bottom Navigation Bar
            _buildBottomNavigationBar(screenWidth, screenHeight, figmaWidth, figmaHeight),

            // Home Indicator (at the very bottom)
            _buildHomeIndicator(screenWidth, screenHeight, figmaWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(double screenWidth, double figmaWidth) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * (24 / figmaWidth)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9:41',
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_alt, color: Colors.white, size: 17),
                  SizedBox(width: screenWidth * (4 / figmaWidth)), // Approx spacing
                  Icon(Icons.wifi, color: Colors.white, size: 17),
                  SizedBox(width: screenWidth * (4 / figmaWidth)), // Approx spacing
                  Icon(Icons.battery_full, color: Colors.white, size: 17),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationAndProfile(double screenWidth, double figmaWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: GoogleFonts.sora(
                color: const Color(0xFFA2A2A2), // Medium Grey
                fontSize: 12,
                letterSpacing: 0.12,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Bilzen, Tanjungbalai',
                  style: GoogleFonts.sora(
                    color: const Color(0xFFD8D8D8), // Light Grey
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: screenWidth * (4 / figmaWidth)),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: const Color(0xFFD8D8D8), // Light Grey
                  size: 14,
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            context.push('/profile'); // Navigates to profile screen using go_router
          },
          child: CircleAvatar(
            radius: screenWidth * (21.5 / figmaWidth), // 43 / 2 for radius of 43px height avatar
            backgroundColor: Colors.grey.shade700,
            child: Icon(Icons.person, color: Colors.white, size: screenWidth * (24 / figmaWidth)),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(double screenWidth, double figmaWidth, double figmaHeight) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: screenHeight * (52 / figmaHeight),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A), // Dark Grey
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFFA2A2A2), size: 20),
                SizedBox(width: screenWidth * (8 / figmaWidth)),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search coffee',
                      hintStyle: GoogleFonts.sora(
                        color: const Color(0xFFA2A2A2), // Medium Grey
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    style: GoogleFonts.sora(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: screenWidth * (16 / figmaWidth)),
        GestureDetector(
          onTap: () {
            context.push('/filter'); // Navigates to filter screen using go_router
          },
          child: Container(
            height: screenHeight * (52 / figmaHeight),
            width: screenHeight * (52 / figmaHeight), // Square container
            decoration: BoxDecoration(
              color: const Color(0xFFE57B4E), // Primary/Accent
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.filter_list, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner(double screenWidth, double screenHeight, double figmaWidth, double figmaHeight) {
    return Container(
      width: screenWidth * (327 / figmaWidth), // Max width inside padding
      height: screenHeight * (140 / figmaHeight),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/142_467.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * (24 / figmaWidth),
              top: screenHeight * (22 / figmaHeight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFED5151), // Promo Red
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Promo',
                    style: GoogleFonts.sora(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * (8 / figmaHeight)),
                Text(
                  'Buy one get one FREE',
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(double screenWidth, double figmaWidth) {
    return SizedBox(
      height: 29, // Fixed height for category chips from Figma
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => SizedBox(width: screenWidth * (16 / figmaWidth)),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE57B4E) // Primary/Accent
                    : const Color(0xFFEDEEEE).withOpacity(0.35), // Light Grey with opacity
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _categories[index],
                style: GoogleFonts.sora(
                  color: isSelected ? Colors.white : const Color(0xFF313131), // Dark Grey
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(double screenWidth, double screenHeight, double figmaWidth, double figmaHeight) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Important to disable grid scrolling
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenWidth * (16 / figmaWidth),
        mainAxisSpacing: screenHeight * (16 / figmaHeight),
        childAspectRatio: (156 / 238), // Based on product card Figma dimensions (width/height)
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () {
            context.push('/productDetail', extra: product); // Navigates to product detail using go_router with extra
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/${product['id'].replaceAll(':', '_').replaceAll(';', '_')}.png',
                        height: screenHeight * (128 / figmaHeight),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Color(0xFFFACC21), size: 12), // Star Yellow
                            SizedBox(width: screenWidth * (4 / figmaWidth)),
                            Text(
                              product['rating'],
                              style: GoogleFonts.sora(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * (8 / figmaHeight)),
                Text(
                  product['name'],
                  style: GoogleFonts.sora(
                    color: const Color(0xFF242424), // Almost Black
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * (4 / figmaHeight)),
                Text(
                  product['description'],
                  style: GoogleFonts.sora(
                    color: const Color(0xFFA2A2A2), // Medium Grey
                    fontSize: 12,
                  ),
                ),
                const Spacer(), // Pushes price and add button to bottom
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${product['price']}',
                      style: GoogleFonts.sora(
                        color: const Color(0xFF050505), // Very Dark Grey
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Add to cart logic
                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE57B4E), // Primary/Accent
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(double screenWidth, double screenHeight, double figmaWidth, double figmaHeight) {
    return Positioned(
      bottom: screenHeight * (34 / figmaHeight), // Above Home indicator
      left: 0,
      right: 0,
      child: Container(
        height: screenHeight * (99 / figmaHeight),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * (24 / figmaWidth),
          vertical: screenHeight * (24 / figmaHeight),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomNavItem(
              icon: Icons.home,
              index: 0,
              route: '/home',
              iconSize: 20,
            ),
            _buildBottomNavItem(
              icon: Icons.favorite_border,
              index: 1,
              route: '/favorites',
              iconSize: 20,
            ),
            _buildBottomNavItem(
              icon: Icons.shopping_bag_outlined,
              index: 2,
              route: '/cart',
              iconSize: 20,
            ),
            _buildBottomNavItem(
              icon: Icons.notifications_none,
              index: 3,
              route: '/notifications',
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required int index,
    required String route,
    required double iconSize,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        context.go(route); // Navigates to the specified route using go_router
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFFE57B4E) : const Color(0xFFA2A2A2),
            size: iconSize,
          ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Container(
                width: 10,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE57B4E),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHomeIndicator(double screenWidth, double screenHeight, double figmaWidth) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: screenHeight * (34 / figmaHeight),
        color: Colors.transparent, // Background of the home indicator area
        alignment: Alignment.center,
        child: Container(
          width: screenWidth * (134 / figmaWidth),
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFF242424), // Almost Black
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}