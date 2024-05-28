#pragma once

#include <topgg/topgg.h>

#include <functional>
#include <vector>
#include <string>
#include <map>

namespace topgg {
#define TOPGG_API_CALLBACK(return_type, name) \
  using name##_completion_t = std::function<void(const result<return_type>&)>

  TOPGG_API_CALLBACK(bot, get_bot);
  TOPGG_API_CALLBACK(user, get_user);
  TOPGG_API_CALLBACK(stats, get_stats);
  TOPGG_API_CALLBACK(std::vector<voter>, get_voters);
  TOPGG_API_CALLBACK(bool, has_voted);
  TOPGG_API_CALLBACK(bool, is_weekend);

  using post_stats_completion_t = std::function<void(void)>;

  class TOPGG_EXPORT client {
    dpp::cluster* m_cluster;
    std::multimap<std::string, std::string> m_headers;

    template<typename T>
    void basic_request(const std::string& url, std::function<void(const result<T>&)> callback, std::function<T(const dpp::json&)> conversion_fn) {
      m_cluster->request("https://top.gg/api" + url, dpp::m_get, [callback, conversion_fn](const auto& response) { callback(result<T>{response, conversion_fn}); }, "", "application/json", m_headers);
    }

  public:
    client() = delete;
    client(dpp::cluster* cluster, const std::string& token);

    void get_bot(const dpp::snowflake& bot_id, get_bot_completion_t callback);
    void get_user(const dpp::snowflake& user_id, get_user_completion_t callback);
    void post_stats(const stats& s, post_stats_completion_t callback);
    void get_stats(get_stats_completion_t callback);
    void get_voters(get_voters_completion_t callback);
    void has_voted(const dpp::snowflake& user_id, has_voted_completion_t callback);
    void is_weekend(is_weekend_completion_t callback);
  };
}; // namespace topgg

#undef TOPGG_API_CALLBACK