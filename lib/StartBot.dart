import 'package:telebot/env.dart';
import 'package:telebot/main_menu/main_menu.dart';
import 'package:televerse/televerse.dart';

void startBot() async {
  final String _botToken = BOT_TOKEN;
  final Bot _bot = Bot(_botToken);
  final MainMenu _mainMenu = MainMenu(_bot);
  await _mainMenu.initialize();

  await _bot.start();
}
