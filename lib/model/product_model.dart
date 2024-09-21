class Product {
  final int id;
  final String title;
  final double price;
  final String image;  // Add this field for image URL
  final double discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,  // Include image in the constructor
    required this.discountPercentage,
  });

  // Assuming your API data is a JSON object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['thumbnail'],  // Use 'thumbnail' or 'image' field from the API
      discountPercentage: json['discountPercentage'].toDouble(),
    );
  }

  // Method to calculate discounted price
  double getDiscountedPrice() {
    return price - (price * discountPercentage / 100);
  }
}
