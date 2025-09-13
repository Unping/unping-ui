/// StatusRequest represents the different states of a data request.
/// - loading: when data is being fetched
/// - success: when data is successfully retrieved
/// - failure: general failure (e.g., empty data or unexpected issue)
/// - serverfailure: server returned an error response (e.g., 500, 404)
/// - serverException: an exception occurred while handling server response
/// - offlinefailure: no internet connection available
enum StatusRequest {
  loading,
  success,
  failure,
  serverfailure,
  serverException,
  offlinefailure,
}
