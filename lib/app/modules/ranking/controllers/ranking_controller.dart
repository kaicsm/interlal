import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RankingController extends GetxController {
  final RxString selectedSport = 'Futsal M.'.obs;
  final RxString selectedRanking = 'Times'.obs;

  final rankings = ["Times", "Jogadores"];

  // TODO: Carregar esportes dinamicamente
  final List<String> sports = [
    'Futsal M.',
    'Vôlei F.',
    'Basquete M.',
    'Handebol F.',
    'Queimada Mista',
  ];

  void changeRanking(String ranking) {
    selectedRanking.value = ranking;
    Logger().i("Categoria selecionada: $ranking");
    update();
  }

  void changeSport(String sport) {
    selectedSport.value = sport;
    // TODO: Recarregar os dados reais do ranking para o novo esporte
    Logger().i("Esporte selecionado: $sport");
    update();
  }

  List<Map<String, dynamic>> get topTeams {
    if (selectedSport.value == 'Futsal M.') {
      return [
        {'pos': 1, 'name': '3º Informática', 'points': 25},
        {'pos': 2, 'name': '2º Edificações', 'points': 22},
        {'pos': 3, 'name': '1º Agropecuária', 'points': 20},
        {'pos': 4, 'name': '3º Edificações', 'points': 18},
        {'pos': 5, 'name': '2º Informática', 'points': 15},
        {'pos': 6, 'name': '1º Edificações', 'points': 14},
        {'pos': 7, 'name': '3º Agropecuária', 'points': 12},
        {'pos': 8, 'name': '2º Agropecuária', 'points': 10},
        {'pos': 9, 'name': '1º Informática', 'points': 9},
        {'pos': 10, 'name': 'Servidores FC', 'points': 7},
        {'pos': 11, 'name': 'Grêmio Est.', 'points': 5},
        {'pos': 12, 'name': 'Ex-Alunos', 'points': 3},
      ];
    } else if (selectedSport.value == 'Vôlei F.') {
      return [
        {'pos': 1, 'name': '1º Informática', 'points': 15},
        {'pos': 2, 'name': '3º Agropecuária', 'points': 11},
        {'pos': 3, 'name': '2º Informática', 'points': 8},
        {'pos': 4, 'name': '1º Edificações', 'points': 6},
        {'pos': 5, 'name': '2º Edificações', 'points': 5},
      ];
    } else if (selectedSport.value == 'Queimada Mista') {
      return [];
    }
    return [
      {'pos': 1, 'name': 'Time A', 'points': 10},
      {'pos': 2, 'name': 'Time B', 'points': 8},
      {'pos': 3, 'name': 'Time C', 'points': 7},
      {'pos': 4, 'name': 'Time D', 'points': 5},
    ];
  }

  List<Map<String, dynamic>> get topPlayers {
    if (selectedSport.value == 'Futsal M.') {
      return [
        {'pos': 1, 'name': 'João Silva', 'team': '3º Info', 'score': 12},
        {'pos': 2, 'name': 'Carlos Souza', 'team': '2º Edif', 'score': 9},
        {'pos': 3, 'name': 'Pedro Lima', 'team': '3º Info', 'score': 8},
        {'pos': 4, 'name': 'Marcos Andrade', 'team': '1º Agro', 'score': 7},
        {'pos': 5, 'name': 'Lucas Mendes', 'team': '3º Edif', 'score': 6},
      ];
    } else if (selectedSport.value == 'Vôlei F.') {
      return [
        {'pos': 1, 'name': 'Maria Oliveira', 'team': '1º Info', 'score': 25},
        {'pos': 2, 'name': 'Ana Costa', 'team': '3º Agro', 'score': 22},
        {'pos': 3, 'name': 'Sofia Alves', 'team': '1º Info', 'score': 19},
      ];
    }
    return [
      {'pos': 1, 'name': 'Jogador X', 'team': 'Time A', 'score': 5},
      {'pos': 2, 'name': 'Jogador Y', 'team': 'Time B', 'score': 4},
      {'pos': 3, 'name': 'Jogador Z', 'team': 'Time C', 'score': 3},
    ];
  }
}
