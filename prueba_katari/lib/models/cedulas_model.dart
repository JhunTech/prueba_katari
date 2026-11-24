import 'dart:convert';

List<Cedulas> cedulasFromJson(String str) =>
    List<Cedulas>.from(json.decode(str).map((x) => Cedulas.fromJson(x)));

class Cedulas {
  final String cedula;
  final List<Pulsera> pulseras;

  Cedulas({
    required this.cedula,
    required this.pulseras,
  });

  factory Cedulas.fromJson(Map<String, dynamic> json) => Cedulas(
        cedula: json["cedula"] ?? "",
        pulseras: json["pulseras"] == null
            ? []
            : List<Pulsera>.from(
                json["pulseras"].map((x) => Pulsera.fromJson(x))),
      );
}

class Pulsera {
  final int id;
  final String local;
  final String estado;
  final double total;
  final List<Item> items;

  Pulsera({
    required this.id,
    required this.local,
    required this.estado,
    required this.total,
    required this.items,
  });

  factory Pulsera.fromJson(Map<String, dynamic> json) => Pulsera(
        id: json["id"] ?? 0,
        local: json["local"] ?? "",
        estado: json["estado"] ?? "",
        total: (json["total"] ?? 0).toDouble(),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );
}

class Item {
  final String producto;
  final int cantidad;
  final double precio;

  Item({
    required this.producto,
    required this.cantidad,
    required this.precio,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        producto: json["producto"] ?? "",
        cantidad: json["cantidad"] ?? 0,
        precio: (json["precio"] ?? 0).toDouble(),
      );
}
