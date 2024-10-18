import 'package:flutter/material.dart';

class EcommerceHomeScreen extends StatefulWidget {
  @override
  State<EcommerceHomeScreen> createState() => _EcommerceHomeScreenState();
}

class _EcommerceHomeScreenState extends State<EcommerceHomeScreen> {
  final Map<String, bool> _favoriteItems = {};
  final Map<String, int> _cartItems = {};

  final List<Map<String, dynamic>> categories = [
    {'name': 'QR Code', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'Custom Pet Portraits', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'Pet Subscription Boxes', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'Pet DNA Test Kits', 'imageUrl': 'assets/ecommerceImage.png'},
    {
      'name': 'Pet Memory Foam Mattresses',
      'imageUrl': 'assets/ecommerceImage.png'
    },
    {
      'name': 'Interactive AI Pet Toys',
      'imageUrl': 'assets/ecommerceImage.png'
    },
    {
      'name': 'Pet-Safe Indoor Herb Gardens',
      'imageUrl': 'assets/ecommerceImage.png'
    },
    {'name': 'Pet Fitness Trackers', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'Customized Pet Apparel', 'imageUrl': 'assets/ecommerceImage.png'},
    {
      'name': 'Pet Spa & Grooming Kits',
      'imageUrl': 'assets/ecommerceImage.png'
    },
    {'name': 'Pet Puzzle Feeders', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'Pet Aromatherapy Kits', 'imageUrl': 'assets/ecommerceImage.png'},
    {'name': 'GPS-Enabled Collars', 'imageUrl': 'assets/ecommerceImage.png'},
    {
      'name': 'Pet Carriers for Travel',
      'imageUrl': 'assets/ecommerceImage.png'
    },
    {'name': 'Pet Playhouse Kits', 'imageUrl': 'assets/ecommerceImage.png'},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'id': '1',
      'name': 'Interactive AI Pet Toy',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 29.99
    },
    {
      'id': '2',
      'name': 'Pet Memory Foam Mattress',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 89.99
    },
    {
      'id': '3',
      'name': 'Pet Fitness Tracker',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 49.99
    },
    {
      'id': '4',
      'name': 'Pet Puzzle Feeder',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 19.99
    },
    {
      'id': '5',
      'name': 'Customized Pet Apparel',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 39.99
    },
    {
      'id': '6',
      'name': 'Pet Spa & Grooming Kit',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 59.99
    },
    {
      'id': '7',
      'name': 'GPS-Enabled Collar',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 74.99
    },
    {
      'id': '8',
      'name': 'Pet DNA Test Kit',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 99.99
    },
    {
      'id': '9',
      'name': 'Pet Playhouse Kit',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 89.99
    },
    {
      'id': '10',
      'name': 'Pet Aromatherapy Kit',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 34.99
    },
    {
      'id': '11',
      'name': 'Pet Carrier for Travel',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 59.99
    },
    {
      'id': '12',
      'name': 'Pet-Safe Indoor Herb Garden',
      'imageUrl': 'assets/ecommerceImage.png',
      'price': 49.99
    },
  ];

  void _updateFavoriteStatus(String itemId, bool isFavorite) {
    setState(() {
      _favoriteItems[itemId] = isFavorite;
    });
  }

  void _addToCart(String itemId) {
    setState(() {
      _cartItems[itemId] = (_cartItems[itemId] ?? 0) + 1;
    });
  }

  void _removeFromCart(String itemId) {
    setState(() {
      if (_cartItems.containsKey(itemId)) {
        if (_cartItems[itemId]! > 1) {
          _cartItems[itemId] = _cartItems[itemId]! - 1;
        } else {
          _cartItems.remove(itemId);
        }
      }
    });
  }

  int get _cartItemCount {
    return _cartItems.values.fold(0, (sum, count) => sum + count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text('Categories', style: TextStyle(fontSize: 24)),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              category['imageUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              category['name'],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllCategoriesScreen(categories: categories)),
                  );
                },
                child: Text('View All Categories'),
              ),
            ),

            // Products section
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text('Products', style: TextStyle(fontSize: 24)),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                final product = products[index];
                final itemId = product['id'];
                return ItemCard(
                  itemData: product,
                  isFavorite: _favoriteItems[itemId] ?? false,
                  onFavoriteChanged: (isFavorite) {
                    _updateFavoriteStatus(itemId, isFavorite);
                  },
                  onAddToCart: () {
                    _addToCart(itemId);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: product,
                          onAddToCart: () => _addToCart(itemId),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AllProductsScreen(products: products)),
                  );
                },
                child: Text('View All Products'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartScreen(
                    cartItems: _cartItems,
                    products: products,
                    onRemoveFromCart: _removeFromCart)),
          );
        },
        label: Text('Cart'),
        icon: Stack(
          children: [
            Icon(Icons.shopping_cart),
            if (_cartItemCount > 0)
              Positioned(
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: Text(
                    '$_cartItemCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Map<String, dynamic> itemData;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  ItemCard({
    required this.itemData,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(itemData['imageUrl'], fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(itemData['name']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('\$${itemData['price']}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    onFavoriteChanged(!isFavorite);
                  },
                ),
                ElevatedButton(
                  onPressed: onAddToCart,
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AllCategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  AllCategoriesScreen({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Categories'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(category['imageUrl'], height: 80, width: 80),
                SizedBox(height: 8),
                Text(category['name'], textAlign: TextAlign.center),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AllProductsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  AllProductsScreen({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Products'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ItemCard(
            itemData: product,
            isFavorite: false,
            onFavoriteChanged: (_) {},
            onAddToCart: () {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    product: product,
                    onAddToCart: () {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onAddToCart;

  ProductDetailScreen({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.green[100],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['imageUrl'],
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Product Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a placeholder description for the ${product['name']}. It provides details about the product\'s features, benefits, and specifications.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: onAddToCart,
                    child: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final Map<String, int> cartItems;
  final List<Map<String, dynamic>> products;
  final Function(String) onRemoveFromCart;

  CartScreen({
    required this.cartItems,
    required this.products,
    required this.onRemoveFromCart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    return widget.cartItems.entries.fold(0, (total, entry) {
      final product = widget.products.firstWhere((p) => p['id'] == entry.key);
      return total + (product['price'] * entry.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Colors.green[100],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final String productId = widget.cartItems.keys.elementAt(index);
                final int quantity = widget.cartItems[productId]!;
                final product =
                    widget.products.firstWhere((p) => p['id'] == productId);

                return Card(
                  margin: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          product['imageUrl'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${product['price']}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.green),
                              ),
                              Text('Quantity: $quantity'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => widget.onRemoveFromCart(productId),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement checkout logic
                  },
                  child: Text('Proceed to Checkout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}