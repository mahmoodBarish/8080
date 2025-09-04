import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Added for go_router navigation

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _selectedDeliveryType = 0; // 0 for Deliver, 1 for Pick Up

  // Color Constants
  static const Color primaryColor = Color(0xFFC67C4E);
  static const Color darkTextColor = Color(0xFF2F2D2C);
  static const Color mediumGreyTextColor = Color(0xFF3B3B3B);
  static const Color lightGreyTextColor = Color(0xFFA9A9A9);
  static const Color toggleBgColor = Color(0xFFEAEAEA);
  static const Color lightDividerColor = Color(0xFFF9F2ED);
  static const Color thinDividerColor = Color(0xFFE3E3E3);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 10), // For status bar content and initial padding
                _buildAppBar(context),
                SizedBox(height: 20),
                _buildDeliveryTypeToggle(screenWidth),
                SizedBox(height: 20),
                _buildDeliveryAddress(),
                SizedBox(height: 20),
                _buildLineDivider(screenWidth, height: 4, color: lightDividerColor),
                SizedBox(height: 20),
                _buildCheckoutProduct(context),
                SizedBox(height: 20),
                _buildDiscountSection(context),
                SizedBox(height: 20),
                _buildPaymentSummary(screenWidth),
                SizedBox(height: 20), // Padding to ensure scrollability above the fixed bottom sheet
                SizedBox(height: 180), // To ensure content above fixed bottom sheet is visible
              ],
            ),
          ),
          // Fixed Bottom Content
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildFixedBottomSection(context, screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pop(); // Replaced Navigator.pop with context.pop
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // Assuming this is a default back button styling
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: mediumGreyTextColor,
                size: 20,
              ),
            ),
          ),
          Text(
            'Order',
            style: GoogleFonts.sora(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          SizedBox(width: 44), // Placeholder for alignment
        ],
      ),
    );
  }

  Widget _buildDeliveryTypeToggle(double screenWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: toggleBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDeliveryType = 0;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedDeliveryType == 0 ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Deliver',
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _selectedDeliveryType == 0 ? Colors.white : darkTextColor,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDeliveryType = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedDeliveryType == 1 ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Pick Up',
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: _selectedDeliveryType == 1 ? Colors.white : darkTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Address',
            style: GoogleFonts.sora(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Jl. Kpg Sutoyo',
            style: GoogleFonts.sora(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: mediumGreyTextColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
            style: GoogleFonts.sora(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lightGreyTextColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildSmallButton(
                icon: Icons.edit_outlined,
                text: 'Edit Address',
                onTap: () {
                  context.push('/editAddress'); // Replaced Navigator.pushNamed with context.push
                },
              ),
              SizedBox(width: 8),
              _buildSmallButton(
                icon: Icons.description_outlined,
                text: 'Add Note',
                onTap: () {
                  context.push('/addNote'); // Replaced Navigator.pushNamed with context.push
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallButton({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: lightGreyTextColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: mediumGreyTextColor),
            SizedBox(width: 4),
            Text(
              text,
              style: GoogleFonts.sora(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: mediumGreyTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineDivider(double screenWidth, {double height = 1, Color color = thinDividerColor}) {
    return Container(
      width: screenWidth,
      height: height,
      color: color,
    );
  }

  Widget _buildCheckoutProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/I142_286_417_715.png', // Coffee image
              width: 54,
              height: 54,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Caffe Mocha',
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: darkTextColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Deep Foam',
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: lightGreyTextColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildQuantityButton(
                icon: Icons.remove_circle_outline,
                onTap: () {
                  // Handle decrease quantity
                },
              ),
              SizedBox(width: 18),
              Text(
                '1', // Current quantity
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: mediumGreyTextColor,
                ),
              ),
              SizedBox(width: 18),
              _buildQuantityButton(
                icon: Icons.add_circle_outline,
                onTap: () {
                  // Handle increase quantity
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: thinDividerColor),
        ),
        child: Icon(icon, size: 16, color: mediumGreyTextColor),
      ),
    );
  }

  Widget _buildDiscountSection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/discount'); // Replaced Navigator.pushNamed with context.push
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: toggleBgColor), // EAEAEA is for toggle, 0.929
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_offer_outlined, // Discount icon
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: 16),
                Text(
                  '1 Discount is Applies',
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: mediumGreyTextColor,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: mediumGreyTextColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: GoogleFonts.sora(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: darkTextColor,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: mediumGreyTextColor,
                ),
              ),
              Text(
                '\$ 4.53',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: darkTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fee',
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: mediumGreyTextColor,
                ),
              ),
              Row(
                children: [
                  Text(
                    '\$ 2.0',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: mediumGreyTextColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '\$ 1.0',
                    style: GoogleFonts.sora(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: darkTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFixedBottomSection(BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(24, 16, 24, MediaQuery.of(context).padding.bottom + 20), // Adjusted bottom padding for home indicator
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.push('/paymentMethod'); // Replaced Navigator.pushNamed with context.push
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined, // Wallet icon
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cash/Wallet',
                          style: GoogleFonts.sora(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: darkTextColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$ 5.53',
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_down, // Down arrow icon
                  color: mediumGreyTextColor,
                  size: 20,
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                context.push('/orderConfirmation'); // Replaced Navigator.pushNamed with context.push
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Order',
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
    );
  }
}