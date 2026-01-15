class ApiConstants {
  static const String baseUrl =
      'https://secure-joanna-nl2-5868b36c.koyeb.app/api/v1';

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';

  //Tournament Endpoints
  static const String tournamentsEndpoint = '/tournaments';
  static const String addTournamentsEndpoint = '/admin/tournaments';
  static String updateTournamentsEndpoint(int id) => '/admin/tournaments/$id';
  static String addTeamToTournamentEndpoint(int id) =>
      '/admin/tournaments/$id/teams';
  static String generateLeagueEndpoint(int id) =>
      '/admin/tournaments/$id/generate';

  //Team Endpoints
  static const String teamsEndpoint = '/admin/teams';
}
