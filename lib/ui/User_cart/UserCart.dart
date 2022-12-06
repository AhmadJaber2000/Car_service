class UserCart {
  final int id;
  final int index;

  final String title, image;

  UserCart({
    required this.index,
    required this.id,
    required this.title,
    required this.image,
  });
}

// list of products
List<UserCart> usercard = [
  UserCart(
      id: 1, title: "Profile", image: "assets/images/profile1.png", index: 1),
  UserCart(
      id: 2,
      title: "Call Mechanic",
      image: "assets/images/mechanic3.png",
      index: 2),
  UserCart(
      id: 3, title: "Call Winch", image: "assets/images/winch1.png", index: 3),
  UserCart(
      id: 4,
      title: "Enter Current Location",
      image: "assets/images/location3.png",
      index: 4),
];
