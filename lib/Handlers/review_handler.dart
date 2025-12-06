import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

void registerReviewHandler(Bot bot) {
  bot.text('⭐ Оставить отзыв', (context) async {
    final UserID = context.update.message!.from!.id;

    await context.api.sendMessage(
      ChatID(context.update.message!.chat.id),
      '📝 Напишите ваш отзыв о товарах или работе бота. '
      'Ваше мнение очень важно для нас!',
      replyMarkup: ReplyKeyboardMarkup(
        keyboard: [
          [KeyboardButton(text: '🔙 Назад')],
        ],
        resizeKeyboard: true,
        oneTimeKeyboard: true,
      ),
    );

    // Установка состояния (аналогично исходному коду)
    // await DatabaseService.setUserState(userId, 'awaiting_review');
  });
}
