import 'package:flutter/material.dart';
import 'package:zeehome/model/houses/house.dart';
import 'package:zeehome/model/user.dart';

class HouseProvider with ChangeNotifier {
  String? _houseId;
  double? _latitude;
  double? _longitude;
  String? _title;
  String? _createdDate;
  String? _address;
  String? _ward;
  String? _district;
  String? _province;
  int? _houseCategory;
  int? _houseType;
  String? _thumbnail;
  List<String>? _images;
  double? _price;
  String? _video;
  bool? _visible;
  double? _square;
  String? _description;
  bool? _ac;
  bool? _parking;
  bool? _elevator;
  bool? _pet;
  int? _rooms;
  int? _bathRooms;
  int? _bedRooms;
  double? _maintenanceFee;
  bool? _furnished;
  Owner? _owner;

  void setBasicInfo (String title, String description, int houseType, int houseCategory, String province, String district, String ward, Owner owner) {
    _title = title;
    _description = description;
    _houseType = houseType;
    _houseCategory = houseCategory;
    _province = province;
    _district = district;
    _ward = ward;
    _owner = owner;
    notifyListeners();
  }

  void setInfo(House houseInfo, String houseId) {
    _houseId = houseId;

    _title = houseInfo.title;
    _description = houseInfo.description;
    _houseType = houseInfo.houseType;
    _houseCategory = houseInfo.houseCategory;
    _province = houseInfo.province;
    _district = houseInfo.district;
    _ward = houseInfo.ward;
    _owner = houseInfo.owner;

    _latitude = houseInfo.latitude;
    _longitude = houseInfo.longitude;
    _address = houseInfo.address;

    _price = houseInfo.price;
    _square = houseInfo.square;
    _ac = houseInfo.ac;
    _parking = houseInfo.parking;
    _elevator = houseInfo.elevator;
    _pet = houseInfo.pet;
    _bathRooms = houseInfo.bathRooms;
    _bedRooms = houseInfo.bedRooms;
    _maintenanceFee = houseInfo.maintenanceFee;
    _furnished = houseInfo.furnished;
    _thumbnail = houseInfo.thumbnail;
    _images = houseInfo.images;
    _video = houseInfo.video;
    _rooms = houseInfo.rooms;

    notifyListeners();
  }

  void editBasicInfo(String title, String description, int houseType, int houseCategory) {
    _title = title;
    _description = description;
    _houseType = houseType;
    _houseCategory = houseCategory;

    notifyListeners();
  }

  void editExtraInfo(double price, double square, bool ac, bool parking, bool elevator, bool pet, int rooms, int bathRooms, int bedRooms, double maintenanceFee, bool furnished, String? thumbnail, List<String>? images, String? video ) {
    _price = price;
    _square = square;
    _ac = ac;
    _parking = parking;
    _elevator = elevator;
    _pet = pet;
    _bathRooms = bathRooms;
    _bedRooms = bedRooms;
    _maintenanceFee = maintenanceFee;
    _furnished = furnished;
    _thumbnail = thumbnail;
    _images = images;
    _video = video;
    _rooms = rooms;

    notifyListeners();
  }

  void setPosition (double latitude, double longtitude, String address) {
    _latitude = latitude;
    _longitude = longtitude;
    _address = address;
    notifyListeners();
  }

  void setExtraInfo (double price, double square, bool ac, bool parking, bool elevator, bool pet, int rooms, int bathRooms, int bedRooms, double maintenanceFee, bool furnished, String? thumbnail, List<String>? images, String? video ) {
    _price = price;
    _square = square;
    _ac = ac;
    _parking = parking;
    _elevator = elevator;
    _pet = pet;
    _bathRooms = bathRooms;
    _bedRooms = bedRooms;
    _maintenanceFee = maintenanceFee;
    _furnished = furnished;
    _thumbnail = thumbnail;
    _images = images;
    _video = video;
    _rooms = rooms;
    notifyListeners();
  }

  void setOwner (String email, String userId, String userImage, double userRating, String lastName, String firstName, String phoneNumber) {
    _owner = Owner(email: email, userId: userId, userImage: userImage, userRating: userRating, lastName: lastName, firstName: firstName, phoneNumber: phoneNumber);
  }

  House getHouseInfor() {
    return House(
      houseId: _houseId,
      latitude: _latitude,
      longitude: _longitude,
      title: _title,
      description: _description,
      createdDate: '',
      address: _address,
      ward: _ward,
      district: _district,
      province: _province,
      houseType: _houseType,
      houseCategory: _houseCategory,
      price: _price,
      square: _square,
      ac: _ac,
      parking: _parking,
      elevator: _elevator,
      pet: _pet,
      bathRooms: _bathRooms,
      bedRooms: _bedRooms,
      maintenanceFee: _maintenanceFee,
      furnished: _furnished,
      images: _images,
      thumbnail: _thumbnail,
      video: _video,
      owner: _owner,
      rooms: _rooms,
    );
  }
}