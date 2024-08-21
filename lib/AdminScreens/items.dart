import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final TextEditingController _controller = TextEditingController();
  List<Item> items = [
    Item(
      name: 'Item 1',
      description: 'Description for Item 1',
      imageUrl: 'images/ring1.jpg', // Local asset image path
      price: 10.0,
      quantity: 5,
      soldCount: 2,
      reviews: ['Good item!', 'Worth the price.'],
    ),
    Item(
      name: 'Item 2',
      description: 'Description for Item 2',
      imageUrl: 'images/ring2.jpg', // Local asset image path
      price: 20.0,
      quantity: 10,
      soldCount: 5,
      reviews: ['Excellent!', 'Highly recommended.'],
    ),
    Item(
      name: 'Art Deco Elegance\nDiamond Bracelet',
      description:
          'Elevate your style with the Art Deco\nEleganceDiamond Bracelet,\na masterpiece that\nbrings the glamorous designs of the\npast into the modern day.\nCrafted in pure 18k white gold,\nthis bracelet features a series of\ngeometricallycut diamonds,\n meticulously\nset to showcase\na total of 2 carats. Each diamond is\nexpertly chosen for\nits clarity and cut,\nensuring that they shimmer\nbrilliantly under any light.\nThe intricate link design not\nonly secures the stones\nfirmly but also adds a touch of\nvintage charm to the piece.',
      imageUrl: 'images/brac.jpg', // Local asset image path
      price: 3500,
      quantity: 4,
      soldCount: 0,
      reviews: ['Good item!', 'Worth the price.'],
    ),
  ];

  List<Item> displayedItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search by name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchItem,
                ),
              ),
            ),
          ),
          Expanded(
            child: displayedItems.isEmpty
                ? Center(child: Text('No items found'))
                : ListView.builder(
                    itemCount: displayedItems.length,
                    itemBuilder: (context, index) =>
                        _buildItemCard(displayedItems[index]),
                  ),
          ),
        ],
      ),
    );
  }

  void _searchItem() {
    String searchText = _controller.text.toLowerCase();
    if (searchText.isEmpty) {
      setState(() {
        displayedItems.clear();
      });
    } else {
      setState(() {
        displayedItems = items
            .where((item) => item.name.toLowerCase().contains(searchText))
            .toList();
      });
    }
  }

  Widget _buildItemCard(Item item) {
    void _deleteitem() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Color(0xFFDFDED9),
              title: Text("Are you sure to delete this account?"),
              //content: Text("Please Try Again"),
              actions: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      displayedItems.remove(item);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'This item is deleted',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("Delete"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("Cancel"),
                ),
              ],
            );
          });
    }

    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController descriptionController =
        TextEditingController(text: item.description);
    TextEditingController priceController =
        TextEditingController(text: item.price.toString());
    TextEditingController quantityController =
        TextEditingController(text: item.quantity.toString());

    return Card(
      elevation: 4, // Add elevation for a raised look
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      _deleteitem();
                      /* setState(() {
                        displayedItems.remove(item);
                      }); */
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editFieldDialog(
                      context,
                      'Name',
                      nameController,
                      (newValue) {
                        setState(() {
                          item.name = newValue;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editFieldDialog(
                          context,
                          'Price',
                          priceController,
                          (newValue) {
                            setState(() {
                              item.price = double.parse(newValue);
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.inventory, size: 18, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      ' ${item.quantity} in stock',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editFieldDialog(
                          context,
                          'Quantity',
                          quantityController,
                          (newValue) {
                            setState(() {
                              item.quantity = int.parse(newValue);
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editFieldDialog(
                      context,
                      'Description',
                      descriptionController,
                      (newValue) {
                        setState(() {
                          item.description = newValue;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Sold: ${item.soldCount}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Reviews:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.reviews.asMap().entries.map((entry) {
                int index = entry.key;
                String review = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, size: 18, color: Colors.orange),
                          SizedBox(width: 4),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          review,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, size: 18, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            item.reviews.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _editFieldDialog(BuildContext context, String fieldName,
      TextEditingController controller, Function(String) onSave) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $fieldName'),
          content: TextField(
            controller: controller,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(controller.text);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Item {
  String name;
  String description;
  String imageUrl;
  double price;
  int quantity;
  int soldCount;
  List<String> reviews;

  Item({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.soldCount,
    required this.reviews,
  });
}
