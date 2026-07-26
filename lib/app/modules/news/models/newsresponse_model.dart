class NewsResponse {
  bool? success;
  String? message;
  NewsData? data;

  NewsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      success: json['success'],
      message: json['message'],
      data: NewsData.fromJson(json['data']),
    );
  }
}

class NewsData {
  int? currentPage;
  List<NewsModel> data;

  NewsData({
    required this.currentPage,
    required this.data,
  });

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      currentPage: json['current_page'],
      data: (json['data'] as List)
          .map((e) => NewsModel.fromJson(e))
          .toList(),
    );
  }
}

class NewsModel {
  final int id;
  final String title;
  final String image;
  final String source;
  final String category;
  final String description;
  final String content;
  final String url;
  final String publishedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.image,
    required this.source,
    required this.category,
    required this.description,
    required this.content,
    required this.url,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      source: json['source'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['published_at'] ?? '',
    );
  }
}