
import 'package:pipes_online/buyer/app_constant/auth.dart';

class CartDtls{
  String? id;
  String? img;
  String? name;
  String? price;
  String? desc;
  CartDtls({this.id,this.price,this.desc,this.name,this.img});
}

class ItemDetailModel {
  String? id;
  String? img;
  String? name;
  String? price;
  String? desc;
  String? cat;

  ItemDetailModel(
      {this.img,this.id, this.desc,this.price,this.name,this.cat
      });

  ItemDetailModel.fromJson(Map<String, dynamic> map) {
    id = bFirebaseAuth.currentUser!.uid;
    img = map['imageProfile'];
    desc = map['dsc'];
    price = map['price'];
    name = map['prdName'];
    cat = map['category'];
  }
}