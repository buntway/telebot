import 'package:televerse/televerse.dart';

void registerOrderHandler(Bot bot) {
  // Обработка заказов (аналогично исходному коду)
  bot.text('📋 Мои заказы', (context) async {
    final userId = context.update.message!.from!.id;
    // Логика получения и отображения заказов
    await context.api.sendMessage(
      ChatID(context.update.message!.chat.id),
      'Отображение заказов...',
    );
  });
}
