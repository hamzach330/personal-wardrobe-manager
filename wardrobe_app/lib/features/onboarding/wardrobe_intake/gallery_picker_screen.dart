import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';

/// Gallery picker for selecting clothing photos
class GalleryPickerScreen extends StatefulWidget {
  const GalleryPickerScreen({super.key});

  @override
  State<GalleryPickerScreen> createState() => _GalleryPickerScreenState();
}

class _GalleryPickerScreenState extends State<GalleryPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _openGallery();
  }

  Future<void> _openGallery() async {
    try {
      final images = await _picker.pickMultiImage(
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      
      if (images.isNotEmpty) {
        setState(() => _selectedImages = images);
      } else if (mounted) {
        // User cancelled, go back
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking images: $e')),
        );
        context.pop();
      }
    }
  }

  void _processSelectedImages() {
    if (_selectedImages.isEmpty) return;
    
    // Process first image (for MVP)
    context.go(AppRoutes.aiTagging, extra: _selectedImages.first.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text(AppStrings.selectPhotos),
        actions: [
          if (_selectedImages.isNotEmpty)
            TextButton(
              onPressed: _processSelectedImages,
              child: Text(
                'Done (${_selectedImages.length})',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _selectedImages.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : Column(
              children: [
                // Tabs
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      _buildTab(AppStrings.allPhotos, true),
                      const SizedBox(width: 12),
                      _buildTab(AppStrings.recents, false),
                      const SizedBox(width: 12),
                      _buildTab(AppStrings.albums, false),
                    ],
                  ),
                ),
                // Filter pill
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              AppStrings.clothingDetected,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Image grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return _buildImageTile(_selectedImages[index], index);
                    },
                  ),
                ),
                // Bottom bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border(
                      top: BorderSide(color: AppColors.outlineVariant),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_selectedImages.length} ${AppStrings.itemsSelected}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? null
            : Border.all(color: AppColors.outline),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildImageTile(XFile image, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.asset(
            // Using placeholder since we can't show actual picked images in preview
            'assets/images/placeholder.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.surfaceVariant,
              child: const Icon(
                Icons.image,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        // Selection indicator
        Positioned(
          right: 6,
          top: 6,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
