// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProdukModelImpl _$$ProdukModelImplFromJson(Map<String, dynamic> json) =>
    _$ProdukModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      namaProduk: json['namaProduk'] as String,
      deskripsi: json['deskripsi'] as String,
      sku: json['sku'] as String,
      hargaPokok: (json['hargaPokok'] as num).toDouble(),
      hargaJual: (json['hargaJual'] as num).toDouble(),
      jumlah: (json['jumlah'] as num).toDouble(),
      jenis: json['jenis'] as String,
    );

Map<String, dynamic> _$$ProdukModelImplToJson(_$ProdukModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'namaProduk': instance.namaProduk,
      'deskripsi': instance.deskripsi,
      'sku': instance.sku,
      'hargaPokok': instance.hargaPokok,
      'hargaJual': instance.hargaJual,
      'jumlah': instance.jumlah,
      'jenis': instance.jenis,
    };
