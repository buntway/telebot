import 'package:telebot/Handlers/catalog_handler.dart';
import 'package:telebot/models/models/product.dart';
import 'package:televerse/televerse.dart';

class CatalogMenu {
  late Bot _bot;

  CatalogMenu(Bot bot) {
    _bot = bot;
  }

  final List<Product> catalog = [
    Product(
      id: 1,
      name: 'Феликс Ли',
      description: 'Брелок Stray Kids (3D автограф)',
      price: 191.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-g/wc1000/7902313612.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-4/wc1000/7902313924.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-x/wc1000/7902313485.jpg',
      ],
      availableColors: ['Синий кобальт'],
      availableMaterials: ['PLA пластик'],
      availableCount: '31',
    ),
    Product(
      id: 2,
      name: 'Бан Чан',
      description: 'Брелок Stray Kids (3D автограф)',
      price: 187.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-i/wc1000/7902297090.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-a/wc1000/7902297082.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-9/wc1000/7902297873.jpg',
      ],
      availableColors: ['Ультрамариновый'],
      availableMaterials: ['PLA пластик'],
      availableCount: '62',
    ),
    Product(
      id: 3,
      name: 'Хенджин',
      description: 'Брелок Stray Kids (3D автограф)',
      price: 173.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-7/wc1000/7902300787.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-9/wc1000/7902301257.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-z/wc1000/7902301211.jpg',
      ],
      availableColors: ['Синий, синий космос'],
      availableMaterials: ['PLA пластик'],
      availableCount: '45',
    ),
    Product(
      id: 4,
      name: 'STAY 3 шт',
      description: 'Набор брелоков Stray Kids',
      price: 143.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-y/wc1000/7618606234.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-w/wc1000/7618606268.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-z/wc1000/7618606307.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-d/wc1000/7618606249.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-a/wc1000/7618606246.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-c/wc1000/7618606284.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-m/wc1000/7618606294.jpg',
      ],
      availableColors: ['Синий', 'Градиент', 'Белый'],
      availableMaterials: ['PLA пластик'],
      availableCount: '77',
    ),
    Product(
      id: 5,
      name: 'BTS',
      description: 'Брелок BTS (3D градиент BTS)',
      price: 157.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-p/wc1000/7736132185.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-y/wc1000/7736132410.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-5/wc1000/7736132417.jpg',
      ],
      availableColors: ['Градиент'],
      availableMaterials: ['PLA пластик'],
      availableCount: '133',
    ),
    Product(
      id: 6,
      name: 'Пуговицы 25мм',
      description:
          'Пуговицы градиент декоративные для рукоделия и шитья (30 штук, 25 мм, 4 отверстия)',
      price: 251.0,
      photoUrl: [
        'https://ir.ozone.ru/s3/multimedia-1-5/wc1000/7116560357.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-d/wc1000/7116560329.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-e/wc1000/7116560366.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-c/wc1000/7116560364.jpg',
        'https://ir.ozone.ru/s3/multimedia-1-w/wc1000/7116560348.jpg',
      ],
      availableColors: ['Градиент'],
      availableMaterials: ['PLA пластик'],
      availableCount: '69',
    ),
  ];

  Future initialize() async {
    final CatalogHandler _catalogHandler = CatalogHandler(
      bot: _bot,
      catalog: catalog,
    );
    await _catalogHandler.setupHandler();
  }
}
