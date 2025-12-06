import 'package:telebot/Handlers/support_handler.dart';
import 'package:telebot/catalog_menu/catalog_menu.dart';
import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

class MainMenu {
  late Bot _bot;

  MainMenu(Bot bot) {
    _bot = bot;
  }

  final keyboard = Keyboard()
      .text(" 📦 Каталог")
      .text(" 📋 Мои заказы")
      .text(" 💳 Оплата и доставка")
      .text(" 📞 Связаться с продавцом")
      .row()
      .text(" ⭐ Оставить отзыв")
      .text(" ❓ FAQ")
      .resized();

  Future initialize() async {
    _bot.command('start', (ctx) async {
      await _saveUserData(ctx);
      await ctx.reply("Добро пожаловать в бот! 🚀", replyMarkup: keyboard);
    });
    await _setupCatalog();
    await _setupSupport();
  }

  Future _saveUserData(Context context) async {
    final User user = context.update.message!.from!;
    final userId = user.id;
    /*await setString('userId', userId.toString());
    await setString('userName', user.firstName.toString());*/
  }

  Future _setupCatalog() async {
    final CatalogMenu _catalogMenu = CatalogMenu(_bot);
    await _catalogMenu.initialize();
  }

  Future _setupSupport() async {
    final SupportHandler _supportHandler = SupportHandler(_bot);
    _supportHandler.registerSupportHandler();
  }
}
