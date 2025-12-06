import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

void registerPaymentHandler(Bot bot) {
  bot.text('💳 Оплата и доставка', (context) async {
    await context.api.sendMessage(
      ChatID(context.update.message!.chat.id),
      '💰 <b>Способы оплаты:</b>\n\n'
      '• СБП (Система быстрых платежей)\n'
      '• Перевод на карту Тинькофф\n'
      '🚚 <b>Доставка:</b>\n\n'
      '• По России: Почта России, CDEK, Boxberry\n'
      '• Сроки: 3-10 дней после оплаты\n'
      '• Стоимость доставки: 150-400 ₽ в зависимости от региона и веса\n'
      '• Бесплатная доставка при заказе от 1500 ₽\n\n'
      '📍 <b>Регионы:</b>\n'
      'Доставка по всей России. Самовывоз возможен в г.Сургуте.',
      parseMode: ParseMode.html,
    );
  });
}
