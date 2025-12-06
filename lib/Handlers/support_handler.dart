import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class SupportHandler {
  late final Bot _bot;

  SupportHandler(Bot bot) {
    _bot = bot;
  }

  InlineKeyboardMarkup _buildSupportKeyboard() {
    return InlineKeyboardMarkup(
      inlineKeyboard: [
        [InlineKeyboardButton(text: '⬅️ Назад', callbackData: 'back')],
      ],
    );
  }

  void registerSupportHandler() {
    _bot.text('📞 Связаться с продавцом', (context) async {
      await context.api.sendMessage(
        ChatID(context.update.message!.chat.id),
        '👥 <b>Контакты продавца:</b>\n\n'
        '• Telegram: @BirdCherryPrint_Admin\n'
        '• Email: birdcherryprint@yandex.ru\n'
        '• Телефон: +7 (XXX) XXX-XX-XX\n\n'
        '⏰ Режим работы: Пн-Пт 08:00-18:00\n'
        'Время ответа: обычно в течение 1-2 часов.',
        parseMode: ParseMode.html,
        replyMarkup: _buildSupportKeyboard(),
      );
    });

    _bot.text('❓ FAQ', (context) async {
      await context.api.sendMessage(
        ChatID(context.update.message!.chat.id),
        '❓ <b>Частые вопросы:</b>\n\n'
        '<b>Какой материал используется?</b>\n'
        'Основной материал: PLA (экологичный, биоразлагаемый).\n\n'
        '<b>Сколько времени занимает печать?</b>\n'
        'Стандартные товары: 1-3 дня.\n\n'
        '<b>Можно ли вернуть товар?</b>\n'
        'Возврат возможен, если товар не соответствует описанию или пришел с браком.\n\n'
        '<b>Как узнать статус заказа?</b>\n'
        'Статус можно посмотреть в разделе "Мои заказы". Также мы отправляем уведомления при изменении статуса.\n\n'
        '<b>Есть ли скидки?</b>\n'
        'Скидок нету.',
        parseMode: ParseMode.html,
        replyMarkup: _buildSupportKeyboard(),
      );
    });
  }
}
