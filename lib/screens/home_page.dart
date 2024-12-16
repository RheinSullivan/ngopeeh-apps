import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ngopeeh/theme.dart';
import 'menu_items.dart';

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void nextMenu() {
    setState(() {
      currentIndex = (currentIndex + 1) % menuItems.length;
    });
  }

  void previousMenu() {
    setState(() {
      currentIndex = (currentIndex - 1 + menuItems.length) % menuItems.length;
    });
  }

  void showOrderNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_box, color: primary, size: 24),
                SizedBox(width: 15),
                Text(
                  'Terimakasih pesanan anda \nakan segera kami antar, bro!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMenu = menuItems[currentIndex];
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20,
        ),
        title: const Text(
          "Menu Pesanan",
          style: TextStyle(
            fontSize: 18,
            color: primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  currentMenu['image']!,
                  height: 250,
                  width: 450,
                ),
                Positioned(
                  left: 0,
                  child: IconButton(
                    onPressed: previousMenu,
                    icon: const Icon(Icons.arrow_back_ios,
                        color: primary, size: 28),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: nextMenu,
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: primary, size: 28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              currentMenu['title']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              currentMenu['description']!,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff687a79),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: OrderUI(
                onOrder: () => showOrderNotification(context),
                currentIndex: currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderUI extends StatefulWidget {
  final VoidCallback onOrder;
  final int currentIndex;

  const OrderUI({required this.onOrder, required this.currentIndex, super.key});

  @override
  OrderUIState createState() => OrderUIState();
}

class OrderUIState extends State<OrderUI> {
  String selectedSize = 'S';
  int comboCount = 0;

  void selectSize(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  void addCombo() {
    setState(() {
      comboCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMenu = menuItems[widget.currentIndex];
    const sizes = ['S', 'M', 'L'];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SIZE",
            style: TextStyle(
              color: Color(0xff687A79),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: sizes.map((size) {
              return GestureDetector(
                onTap: () => selectSize(size),
                child: Container(
                  width: 85,
                  height: 60,
                  decoration: BoxDecoration(
                    color: selectedSize == size ? primary : Colors.transparent,
                    border: Border.all(
                      color:
                          selectedSize == size ? Colors.transparent : primary,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: TextStyle(
                        fontSize: 18,
                        color: selectedSize == size ? Colors.white : primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          const Text(
            "COMBO",
            style: TextStyle(
              color: Color(0xff687A79),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: ListTile(
              leading: Image.asset('assets/croissant.png', width: 48),
              title: const Text(
                "CROISSANT",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 2,
                ),
              ),
              subtitle: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    color: index < 4 ? Colors.amber : Colors.grey,
                    size: 16,
                  ),
                ),
              ),
              trailing: GestureDetector(
                onTap: addCombo,
                child: const CircleAvatar(
                  backgroundColor: Color(0xff687A79),
                  radius: 15,
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              Stack(
                children: [
                  const Icon(Icons.shopping_bag_rounded,
                      size: 55, color: primary),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          border: Border.all(color: background, width: 2),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 9,
                        backgroundColor: dark,
                        child: Text(
                          '$comboCount',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15, height: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: widget.onOrder,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ADD TO BAG        |",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Text(
                        currentMenu['price'] ?? '| Rp. 0',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
