class ApiEndpoints {
  // Base URLs for environments
  static const String devBaseUrl = "https://rsa-nadeo-api.azurewebsites.net/api/";
  static const String qABaseUrl = "https://qa.example.com";

  // Common Headers
  static const Map<String, String> commonHeaders = {
    "Content-Type": "application/json",
    "Cache-Control": "no-cache",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "RSA_KEY": "SvnqwrRcCGE_RSMS_KEY5xWUYcI3aLAi4=rsa" // Authentication header
  };

  // Category Endpoints
  // ===========
  static const String getCategoryList = "Category/getCategoryList";

  // Company Endpoints
  // ===========
  static const String getCompanyById = "Company/getCompanyById";
  static const String insertCompany = "Company/insertCompany";
  static const String updateCompany = "Company/updateCompany";

  // Favourites Endpoints
  // ====================
  static const String getFavoriteListById = "Favorite/getFavoriteListById";
  static const String insertAndUpdateFavorite = "Favorite/insertAndUpdateFavorite";

  // Featured Playlist Endpoints
  // ===========================
  static const String getFeaturedPlaylist = "FeaturedPlaylist";

  // Featured Playlist Endpoints
  // ===========================
  static const String getFeaturedPodcasts = "FeaturedPodcast";

  // Guest Endpoints
  // ===============
  static const String insertGuest = "Guest/insertGuest";
  static const String insertGuestFavorite = "Guest/insertGuestFavorite";
  static const String insertGuestWiseContent = "Guest/insertGuestWiseContent";
  static const String updateGuest = "Guest/updateGuest";
  static const String updateGuestFavorite = "Guest/updateGuestFavorite";
  static const String getGuestRatingById = "Guest/getGuestRatingById";
  static const String getGuestWiseContent = "Guest/getGuestWiseContent";
  static const String insertGuestRating = "Guest/insertGuestRating";
  static const String getGuestFavoriteListById = "Guest/getGuestFavoriteListById";

  // Language Endpoints
  // ==================
  static const String getLanguageList = "Language/getLanguageList";
  static const String getCountryListByLangId = "Language/getCountryListbyLangId";
  static const String getDistrictListByLangId = "Language/getDistrictListbyLangId";
  static const String insertLanguage = "Language/insertLanguage";
  static const String updateLanguageById = "Language/updateLanguageById";
  static const String getTownListByLanguageId = "Language/getTownListbyLangId";
  static const String updateUserAndGuestLanguage = "Language/updateUserAndGuestLanguage";
  static const String getLanguageByGuestOrUserId = "Language/getLanguageByGuestOrUserId";

  // Location Endpoints
  // ==================
  static const String insertTown = "Location/insertTown";
  static const String updateTown = "Location/insertTown";
  static const String insertDistrict = "Location/insertDistrict";
  static const String insertCountry = "Location/insertCountry";
  static const String updateCountry = "Location/insertCountry";

  // Notification Endpoints
  // ======================
  static const String getNotificationSettingByGuestId = "Notification/getNotificationSettingByGuestId";
  static const String getNotificationByUserId = "Notification/getNotificationByUserId";
  static const String insertNotification = "Notification/insertNotification";
  static const String updateNotificationById = "Notification/updateNotificationSettingById";
  static const String deleteNotificationById = "Notification/deleteNotificationById";
  static const String getNotificationSettingById = "Notification/getNotificationSettingById";

  //https://rsa-nadeo-api.azurewebsites.net/api/Notification/updateNotificationSettingById

  // Permission Endpoints
  // ====================
  static const String insertPermission = "Permission/insertPermission";
  static const String updatePermission = "Permission/updatePermission";

  // PlaylistContent Endpoints
  // =========================
  static const String getPlaylistContent = "PlaylistContent/getPlaylistContent";

  // Podcast Endpoints
  // ====================
  static const String getPodcastById = "Podcast/getPodcastById";
  static const String insertPodcast = "Podcast/insertPodcast";
  static const String updatePodcast = "Podcast/updatePodcast";
  static const String getPodcastByStationId = "Podcast/getPodcastByStationId";
  static const String insertContentWiseShowAndPodcast = "Podcast/insertContentWiseShowAndPodcast";
  static const String insertPodcastCategory = "Podcast/insertPodcastCategory";
  static const String insertProgramWiseArtist = "Podcast/insertProgramWiseArtist";
  static const String insertProgramWiseHost = "Podcast/insertProgramWiseHost";
  static const String updateProgramWiseArtist = "Podcast/insertProgramWiseHost";
  static const String getPodcastListByCategoryId = "Podcast/getPodcastListByCategoryId";
  static const String getTrendingPodcastList = "Podcast/getTrendingPodcastList";
  static const String getPlaylist = "Podcast/getPlaylist";
  static const String updateProgramWiseHost = "Podcast/updateProgramWiseHost";
  static const String updateShowWiseHost = "Podcast/updateShowWiseHost";
  static const String getContentByPodcastId = "Podcast/getContentByPodacstId";

  // Playlist Endpoints
  // ==================
  static const String getPlaylistCategoryList = "Playlist/getPlaylistCategoryList";
  static const String getPlaylistByCategoryId = "Playlist/getPlaylistByCategoryId";

  // Show Endpoints
  // ==============
  static const String getChatByShowId = "Show/getChatByShowId";
  static const String getShowById = "Show/getShowById";
  static const String getShowsByStationId = "Show/getShowsByStationId";
  static const String getShowContentById = "Show/getShowContentById";
  static const String updateShow = "Show/updateShow";
  static const String updateShowCategory = "Show/updateShowCategory";
  static const String updateShowContent = "Show/updateShowContent";
  static const String getCurrentShowsByStationId = "Show/GetCurrentShowsByStationId";

  // Station Endpoints
  // =================
  static const String getStationListByCompanyId = "Station/getStationListByCompanyId";
  static const String getCategoryListByStationId = "Station/getCategoryListByStationId";
  static const String getStationById = "Station/getStationById";
  static const String insertStation = "Station/insertStation";
  static const String updateStation = "Station/updateStation";

  // User Endpoints
  // =================
  static const String insertUser = "User/insertUser";
  static const String insertUserPermission = "User/insertUserPermission";
  static const String insertUserWiseContent = "User/insertUserWiseContent";
  static const String updateUser = "User/insertUserWiseContent";
  static const String updateUserPermission = "User/updateUserPermission";
  static const String getUserById = "User/getUserById";
  static const String getUserPermissionListById = "User/getUserPermissionListById";
  static const String getUserRatingById = "User/getUserRatingById";
  static const String getUserTypeList = "User/getUserTypeList";
  static const String insertTwoFactorDetail = "User/insertTwoFactorDetail";

  // Search Endpoints
  // ================
  static const String searchByKeyword = "Search/searchByKeyword";

  // Not available in Swagger as of 2024/11/19 4:20 pm
  static const String updateCountryById = "/updateCountryById";
  static const String updateDistrictById = "/updateDistrictById";
  static const String getNotification = "/getNotification";
  static const String getPlayListCategoryByStationId = "/getPlayListCategoryByStationId";
  static const String getContentListByStationId = "/getContentListByStationId";
  static const String getShowCategoryById = "/getShowCategoryById";
  static const String insertShow = "/insertShow";
  static const String insertShowCategory = "/insertShowCategory";
  static const String insertShowContent = "/insertShowContent";
  static const String insertChat = "Chat/insertChat";
  static const String rsanLogin = "/rsanLogin";
  static const String getInputsByKeyword = "/getInputsByKeyword";
  static const String getGuestById = "/getGuestById";
  static const String getPermissionById = "/getPermissionById";
  static const String getTwoFactorDetailById = "/getTwoFactorDetailById";
  static const String updateShowWisePodcast = "/updateShowWisePodcast"; // 0
}