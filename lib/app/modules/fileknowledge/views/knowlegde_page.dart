import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/knowledgenode_controller.dart';
import '../model/knowledgenode.dart';

class KnowledgePage extends StatelessWidget {
  KnowledgePage({super.key});

  final controller = Get.find<KnowledgeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          "Financial Knowledge",
          style: TextStyle(
            color: Color(0xFF08111F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshData,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF08111F),
                      Color(0xFF1A3154),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Financial Academy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Pelajari investasi, keuangan, saham, reksadana, dan pengelolaan uang.",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ...controller.tree.map(
                (node) => TreeNodeWidget(
                  node: node,
                  level: 0,
                  onTap: (file) {
                    controller.openFile(file);
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class TreeNodeWidget extends StatelessWidget {
  final KnowledgeNode node;
  final int level;
  final Function(KnowledgeNode) onTap;

  const TreeNodeWidget({
    super.key,
    required this.node,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (node.type == "folder") {
      return FolderNode(
        node: node,
        level: level,
        onTap: onTap,
      );
    }

    return FileNode(
      node: node,
      level: level,
      onTap: onTap,
    );
  }
}

class FolderNode extends StatefulWidget {
  final KnowledgeNode node;
  final int level;
  final Function(KnowledgeNode) onTap;

  const FolderNode({
    super.key,
    required this.node,
    required this.level,
    required this.onTap,
  });

  @override
  State<FolderNode> createState() =>
      _FolderNodeState();
}

class _FolderNodeState
    extends State<FolderNode> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius:
              BorderRadius.circular(16),
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
          child: Container(
            margin:
                const EdgeInsets.only(
              bottom: 6,
            ),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.03),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width:
                      widget.level * 24,
                ),

                AnimatedRotation(
                  duration:
                      const Duration(
                    milliseconds: 200,
                  ),
                  turns:
                      expanded
                          ? 0.25
                          : 0,
                  child: const Icon(
                    Icons.chevron_right,
                  ),
                ),

                const SizedBox(width: 6),

                Icon(
                  expanded
                      ? Icons
                          .folder_open_rounded
                      : Icons.folder_rounded,
                  color: Colors.amber,
                  size: 28,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    widget.node.name,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors
                        .grey.shade100,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    "${widget.node.children.length}",
                  ),
                ),
              ],
            ),
          ),
        ),

        AnimatedCrossFade(
          duration:
              const Duration(
            milliseconds: 250,
          ),
          crossFadeState:
              expanded
                  ? CrossFadeState
                      .showSecond
                  : CrossFadeState
                      .showFirst,
          firstChild:
              const SizedBox(),
          secondChild: Container(
            margin:
                const EdgeInsets.only(
              left: 18,
            ),
            child: Column(
              children:
                  widget.node.children
                      .map(
                        (child) =>
                            TreeNodeWidget(
                          node: child,
                          level:
                              widget.level +
                              1,
                          onTap:
                              widget.onTap,
                        ),
                      )
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class FileNode extends StatelessWidget {
  final KnowledgeNode node;
  final int level;
  final Function(KnowledgeNode) onTap;

  const FileNode({
    super.key,
    required this.node,
    required this.level,
    required this.onTap,
  });

  IconData getFileIcon() {
    switch (
        node.extension
            ?.toLowerCase()) {
      case "pdf":
        return Icons.picture_as_pdf;

      case "png":
      case "jpg":
      case "jpeg":
        return Icons.image;

      case "mp4":
        return Icons.video_file;

      case "xlsx":
        return Icons.table_chart;

      case "doc":
      case "docx":
        return Icons.description;

      default:
        return Icons.insert_drive_file;
    }
  }

  Color getColor() {
    switch (
        node.extension
            ?.toLowerCase()) {
      case "pdf":
        return Colors.red;

      case "png":
      case "jpg":
      case "jpeg":
        return Colors.green;

      case "mp4":
        return Colors.deepPurple;

      case "xlsx":
        return Colors.teal;

      case "doc":
      case "docx":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        children: [
          SizedBox(
            width:
                (level * 24) + 24,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color:
                        Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: InkWell(
              borderRadius:
                  BorderRadius.circular(
                16,
              ),
              onTap: () {
                onTap(node);
              },
              child: Container(
                padding:
                    const EdgeInsets.all(
                  12,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                  border: Border.all(
                    color: Colors
                        .grey.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration:
                          BoxDecoration(
                        color: color
                            .withOpacity(
                          0.12,
                        ),
                        shape:
                            BoxShape.circle,
                      ),
                      child: Icon(
                        getFileIcon(),
                        color: color,
                      ),
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    Expanded(
                      child: Text(
                        node.name,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    ),

                    Icon(
                      Icons
                          .arrow_forward_ios_rounded,
                      size: 14,
                      color:
                          Colors.grey.shade500,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}