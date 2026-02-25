class Item {
  final String name;
  final String description;
  final String imageUrl;
  final bool isEquipped;
  final int price;

  const Item({
    required this.name,
    required this.description,
    required this.imageUrl,
    this.isEquipped = false,
    required this.price,
  });

  Item equippedItem() {
    return Item(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isEquipped: true,
      price: price,
    );
  }

  Item unequippedItem() {
    return Item(
      name: name,
      description: description,
      imageUrl: imageUrl,
      isEquipped: false,
      price: price,
    );
  }
}
