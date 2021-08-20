import 'dart:convert';

ExchengeRate exchengeRateFromJson(String str) => ExchengeRate.fromJson(json.decode(str));

String exchengeRateToJson(ExchengeRate data) => json.encode(data.toJson());

class ExchengeRate {
  ExchengeRate({
    required this.provider,
    required this.warningUpgradeToV6,
    required this.terms,
    required this.base,
    required this.date,
    required this.timeLastUpdated,
    required this.rates,
  });

  String provider;
  String warningUpgradeToV6;
  String terms;
  String base;
  String date;
  int timeLastUpdated;
  Map<String, dynamic> rates;

  factory ExchengeRate.fromJson(Map<String, dynamic> json) => ExchengeRate(
        provider: json["provider"] == "" ? "" : json["provider"],
        warningUpgradeToV6:
            json["WARNING_UPGRADE_TO_V6"] == "" ? "" : json["WARNING_UPGRADE_TO_V6"],
        terms: json["terms"] == "" ? "" : json["terms"],
        base: json["base"] == "" ? "" : json["base"],
        date: json["date"],
        timeLastUpdated: json["time_last_updated"] == "" ? "" : json["time_last_updated"],
        rates: json["rates"],
      );

  Map<String, dynamic> toJson() => {
        "provider": provider == "" ? "" : provider,
        "WARNING_UPGRADE_TO_V6": warningUpgradeToV6 == "" ? "" : warningUpgradeToV6,
        "terms": terms == "" ? "" : terms,
        "base": base == "" ? "" : base,
        "date": date,
        "time_last_updated": timeLastUpdated,
        "rates": rates,
      };
}
