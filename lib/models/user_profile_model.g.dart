// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      nama: json['nama'] as String,
      email: json['email'] as String,
      nomor: json['nomor'] as String,
      alamat: json['alamat'] as String,
      kota: json['kota'] as String,
      provinsi: json['provinsi'] as String,
      kodePos: json['kodePos'] as String,
      logo: json['logo'] as String,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama': instance.nama,
      'email': instance.email,
      'nomor': instance.nomor,
      'alamat': instance.alamat,
      'kota': instance.kota,
      'provinsi': instance.provinsi,
      'kodePos': instance.kodePos,
      'logo': instance.logo,
    };
