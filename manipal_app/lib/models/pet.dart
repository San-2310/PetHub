import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Pet {
  final String id;
  final String name;
  final String species;
  final String breed;
  final int age;
  final String ownerId;
  String qrCodeLink;
  final String? pic;

  Pet({
    required this.id,
    required this.name,
    required this.species,
    required this.breed,
    required this.age,
    required this.ownerId,
    required this.qrCodeLink,
    this.pic,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'species': species,
    'breed': breed,
    'age': age,
    'ownerId': ownerId,
    'qrCodeLink': qrCodeLink,
    'pic': pic,
  };

  static Pet fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Pet(
      id: snapshot['id'],
      name: snapshot['name'],
      species: snapshot['species'],
      breed: snapshot['breed'],
      age: snapshot['age'],
      ownerId: snapshot['ownerId'],
      qrCodeLink: snapshot['qrCodeLink'],
      pic: snapshot['pic'],
    );
  }
  Future<void> updateQRCode() async {
    // Generate a unique string based on pet information
    String qrData = "$id|$name|$species|$breed|$age|$ownerId";

    try {
      // Generate QR code image
      final qrValidationResult = QrValidator.validate(
        data: qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.L,
      );

      if (qrValidationResult.status != QrValidationStatus.valid) {
        throw Exception('Invalid QR code data');
      }

      final qrCode = qrValidationResult.qrCode;
      final painter = QrPainter.withQr(
        qr: qrCode!,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
        gapless: true,
      );

      // Convert painter to image
      final picSize = Size(200, 200);
      final image = await painter.toImage(picSize.width);

      // Convert image to bytes
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Get temporary directory to save the image
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/${Uuid().v4()}.png';
      final imageFile = File(imagePath);

      // Save the QR code image to a file
      await imageFile.writeAsBytes(pngBytes);

      // Upload the image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      final qrImageRef = storageRef.child('pet_qr_codes/${Uuid().v4()}.png');

      await qrImageRef.putFile(imageFile);

      // Get the download URL
      qrCodeLink = await qrImageRef.getDownloadURL();
    } catch (e) {
      // Handle errors, possibly log or rethrow
      print('Error generating QR code: $e');
    } finally {
      
    }
  }
}
