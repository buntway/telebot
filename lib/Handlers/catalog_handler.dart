import 'package:telebot/models/models/product.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class CatalogHandler {
  late Bot _bot;
  late List<Product> _catalog;

  CatalogHandler({required Bot bot, required List<Product> catalog}) {
    _bot = bot;
    _catalog = catalog;
  }

  Future setupHandler() async {
    _bot.text('📦 Каталог', (context) async {
      await context.api.sendMessage(
        ChatID(context.message!.chat.id),
        '📚 Загружаем каталог товаров...',
      );

      // Отправляем карточки товаров
      for (var product in _catalog) {
        try {
          // Создаем inline клавиатуру с кнопкой "Заказать"
          final keyboard = InlineKeyboardMarkup(
            inlineKeyboard: [
              [
                InlineKeyboardButton(
                  text: '🛒 Заказать',
                  callbackData: 'order_${product.id}',
                ),
              ],
            ],
          );

          // Отправляем карточку товара с фото
          await context.api.sendMediaGroup(
            ChatID(context.message!.chat.id),
            List.generate(product.photoUrl.length, (i) {
              return InputMedia.photo(
                media: InputFile.fromUrl(product.photoUrl[i]),
              );
            }),
          );

          await context.api.sendMessage(
            ChatID(context.message!.chat.id),
            '🔹 <b>${product.name}</b>\n\n'
            '${product.description}\n\n'
            '<b>Цена:</b> ${product.price.toStringAsFixed(2)} ₽\n'
            '<b>Доступные цвета:</b> ${product.availableColors.join(', ')}\n'
            '<b>Доступное количество:</b> ${product.availableCount}\n'
            '<b>Материалы:</b> ${product.availableMaterials.join(', ')}',
            parseMode: ParseMode.html,
            replyMarkup: keyboard,
          );

          await Future.delayed(Duration(milliseconds: 300));
        } catch (e) {
          await context.api.sendMessage(
            ChatID(context.message!.chat.id),
            '⚠️ Ошибка загрузки фото для "${product.name}".\n\n'
            '🔹 <b>${product.name}</b>\n'
            '${product.description}\n\n'
            '<b>Цена:</b> ${product.price.toStringAsFixed(2)} ₽\n',
            parseMode: ParseMode.html,
            replyMarkup: InlineKeyboardMarkup(
              inlineKeyboard: [
                [
                  InlineKeyboardButton(
                    text: '🛒 Заказать',
                    callbackData: 'order_${product.id}',
                  ),
                ],
              ],
            ),
          );
        }
      }
    });

    _bot.callbackQuery(RegExp(r'order_(\d+)'), (context) async {
      try {
        final callbackQuery = context.update.callbackQuery;
        if (callbackQuery == null) return;

        final match = RegExp(
          r'order_(\d+)',
        ).firstMatch(callbackQuery.data ?? '');
        if (match == null || match.group(1) == null) {
          await context.api.answerCallbackQuery(
            callbackQuery.id,
            text: '❌ Ошибка: неверные данные заказа',
          );
          return;
        }

        final productId = int.tryParse(match.group(1)!) ?? -1;
        if (productId == -1) {
          await context.api.answerCallbackQuery(
            callbackQuery.id,
            text: '❌ Ошибка: неверный ID товара',
          );
          return;
        }

        // Безопасный поиск товара
        final product = _catalog.firstWhere((p) => p.id == productId);

        // Ответ на callback query
        await context.api.answerCallbackQuery(
          callbackQuery.id,
          text: '✅ Товар выбран: ${product.name}',
        );

        await Future.delayed(const Duration(milliseconds: 300));

        // Получение chat ID из callback query
        final chatId = callbackQuery.message?.chat.id ?? callbackQuery.from.id;

        // Отправка сообщения с параметрами заказа
        await context.api.sendMessage(
          ChatID(chatId),
          '✅ Вы выбрали: <b>${product.name}</b>\n\n'
          'Теперь уточните параметры заказа:\n'
          '🔢 Количество (до ${product.availableCount} штук)\n\n'
          'Введите нужное количество:',
          parseMode: ParseMode.html,
        );

        _bot.onText((context) async {
          final text = context.text!;
          int? count = int.tryParse(text);
          if (count == null) {
            context.reply('Введите нужное количество товара:');
            return;
          }
          if (count > int.parse(product.availableCount)) {
            context.reply('Вы ввели большее количество, чем есть на складе!');
            return;
          }

          await context.api.sendMessage(
            ChatID(context.message!.chat.id),
            "Отлично, вы выбрали $text единиц. Можете перейти к оформлению нажав на кнопку ниже:",
            parseMode: ParseMode.html,
            replyMarkup: InlineKeyboardMarkup(
              inlineKeyboard: [
                [
                  InlineKeyboardButton(
                    text: '🛒 Заказать',
                    callbackData: 'order_${product.id}_count_$count',
                  ),
                ],
              ],
            ),
          );
        });
      } catch (e, stackTrace) {
        print('Ошибка при обработке заказа: $e');
        print('Stack trace: $stackTrace');

        try {
          final callbackQuery = context.update.callbackQuery;
          if (callbackQuery != null) {
            await context.api.answerCallbackQuery(
              callbackQuery.id,
              text:
                  '❌ Произошла ошибка при обработке заказа. Попробуйте позже.',
            );
          }

          final chatId =
              context.update.callbackQuery?.message?.chat.id ??
              context.update.callbackQuery?.from.id;

          if (chatId != null) {
            await context.api.sendMessage(
              ChatID(chatId),
              '❌ Извините, произошла ошибка при обработке вашего заказа. '
              'Пожалуйста, попробуйте снова или обратитесь к продавцу.',
            );
          }
        } catch (innerError) {
          print('Ошибка при отправке сообщения об ошибке: $innerError');
        }
      }
    });
  }
}
