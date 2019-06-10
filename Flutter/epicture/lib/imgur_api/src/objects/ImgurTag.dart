/// Represents tag
class ImgurTag {
  /// The name of the tag
  String name;

  /// The display name of the tag
  String displayName;

  /// Followers of the tag
  int followers;

  /// Total of items in the tag
  int totalItems;

  bool following;

  /// Background hash of the tag
  String backgroundHash;

  /// Thumbnail hash of the tag
  String thumbnailHash;

  String accent;

  /// Indicates if the background is animated
  bool backgroundIsAnimated;

  /// Indicates if the thumbnail is animated
  bool thumbnailIsAnimated;

  /// Indicates if tag is promoted
  bool isPromoted;

  /// Description of the tag
  String description;

  /// Logo hash of the tag
  String logoHash;

  /// Logo destination url of the tag
  String logoDestinationUrl;

  Map<String, String> descriptionAnnotations;

  /// Raw response returned by API
  Map<String, dynamic> raw;

  ImgurTag(this.raw) {
    name = raw['name'];
    displayName = raw['display_name'];
    followers = raw['followers'];
    totalItems = raw['total_items'];
    following = raw['following'];
    backgroundHash = raw['background_hash'];
    thumbnailHash = raw['thumbnail_hash'];
    accent = raw['accent'];
    backgroundIsAnimated = raw['background_is_animated'];
    thumbnailIsAnimated = raw['thumbnail_is_animated'];
    isPromoted = raw['is_promoted'];
    description = raw['description'];
    logoHash = raw['logo_hash'];
    logoDestinationUrl = raw['logo_destination_url'];

    if (raw['description_annotations'] != null) {
      descriptionAnnotations = new Map();

      raw['description_annotations'].forEach((key, value) {
        descriptionAnnotations[key] = value;
      });
    }
  }
}
