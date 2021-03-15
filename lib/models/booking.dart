class Booking {
  final token;
  final int cityId;
  final int treatmentId;
  final dynamic therapistIds;
  final int durationId;
  final String durationLength;
  final String durationPrice;
  final String date;
  final int timeKey;
  final String timeDisplayValue;
  final String firstName;
  final String lastName;
  final String postalCode;
  final String street;
  final String email;
  final String phoneNumber;
  final String specialInstructions;
  final String buildingType;
  final String source;
  final String city;
  final String province;
  final String discountCode;

  Booking(
      {this.token,
      this.cityId,
      this.treatmentId,
      this.therapistIds,
      this.durationId,
      this.durationLength,
      this.durationPrice,
      this.date,
      this.timeKey,
      this.timeDisplayValue,
      this.firstName,
      this.lastName,
      this.postalCode,
      this.street,
      this.email,
      this.phoneNumber,
      this.specialInstructions,
      this.buildingType,
      this.source,
      this.city,
      this.province,
      this.discountCode});

  Map<String, dynamic> toMap() {
    return {
      "token": {"hello": "hello"},
      "paymentData": {
        "cityId": cityId,
        "treatmentId": treatmentId,
        "therapistIds": [therapistIds],
        "duration": {
          "id": durationId,
          "length": durationLength,
          "price": durationPrice
        },
        "date": date,
        "time": {"key": timeKey, "displayValue": timeDisplayValue},
        "client": {
          "firstName": firstName,
          "lastName": lastName,
          "street": street,
          "postalCode": postalCode,
          "emailAddress": email,
          "phoneNumber": phoneNumber,
          "specialInstructions": specialInstructions,
          "buildingType": buildingType,
          "source": source,
          "city": city,
          "province": province
        },
        "discountCode": discountCode
      }
    };
  }
}
