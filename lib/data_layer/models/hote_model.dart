class HotelModel {
  String name, currency, image, review, address;

  num reviewScore, price;
   num stars;
  HotelModel({
    required this.name,
    required this.currency,
    required this.image,
    required this.review,
    required this.reviewScore,
    required this.address,
    required this.stars,
    required this.price,
  });

  // no need for to json constructor as there is no post or put actions are held in this task

  factory HotelModel.fromJson(Map<String, dynamic> h) {
    return HotelModel(
      name: h["name"],
      currency: h['currency'],
      image: h['image'],
      review: h['review'],
      reviewScore: h['review_score'] ,
      address: h['address'],
      stars: h['starts'] ,
      price: h['price'],
    );
  }
}
