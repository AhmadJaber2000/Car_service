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
      id: 1,
      title: "Edit Profile",
      image: "assets/images/profile edit.png",
      index: 1),
  UserCart(
      id: 2,
      title: "Call Mechanic",
      image: "assets/images/call M.png",
      index: 2),
  UserCart(
      id: 3, title: "Call Winch", image: "assets/images/call W.jpg", index: 3),
  UserCart(
      id: 4,
      title: "Enter Current Location",
      image: "assets/images/Location.png",
      index: 4),
];
