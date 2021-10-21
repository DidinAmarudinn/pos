class OrderModel {
  OrderModel({
    this.id,
    this.client,
    this.number,
    this.mplace,
    this.date,
    this.order,
    this.total,
    this.state,
    this.rname,
    this.rphone,
    this.raddr,
    this.rcity,
    this.product,
  });

  int? id;
  int? client;
  String? number;
  String? mplace;
  String? date;
  String? order;
  int? total;
  String? state;
  String? rname;
  String? rphone;
  String? raddr;
  String? rcity;
  String? product;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        client: json["client"],
        number: json["number"],
        mplace: json["mplace"],
        date: json["date"],
        order: json["order"],
        total: json["total"],
        state: json["state"],
        rname: json["rname"],
        rphone: json["rphone"],
        raddr: json["raddr"],
        rcity: json["rcity"],
        product: json["product"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client": client,
        "number": number,
        "mplace": mplace,
        "date": date,
        "order": order,
        "total": total,
        "state": state,
        "rname": rname,
        "rphone": rphone,
        "raddr": raddr,
        "rcity": rcity,
        "product": product,
      };
}
