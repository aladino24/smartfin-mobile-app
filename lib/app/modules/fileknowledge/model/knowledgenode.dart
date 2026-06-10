class KnowledgeNode {
  final String name;
  final String type;
  final String? extension;
  final String? url;
  final List<KnowledgeNode> children;

  KnowledgeNode({
    required this.name,
    required this.type,
    this.extension,
    this.url,
    required this.children,
  });

  factory KnowledgeNode.fromJson(
    Map<String, dynamic> json,
  ) {
    return KnowledgeNode(
      name: json['name'],
      type: json['type'],
      extension: json['extension'],
      url: json['url'],
      children: (json['children'] ?? [])
          .map<KnowledgeNode>(
            (e) => KnowledgeNode.fromJson(e),
          )
          .toList(),
    );
  }
}