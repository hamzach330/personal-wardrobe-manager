import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/garment_model.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/selectable_chip.dart';

/// Tag editing screen for garment details
class TagEditingScreen extends StatefulWidget {
  final String imagePath;
  final Map<String, dynamic>? detectedTags;

  const TagEditingScreen({
    super.key,
    required this.imagePath,
    this.detectedTags,
  });

  @override
  State<TagEditingScreen> createState() => _TagEditingScreenState();
}

class _TagEditingScreenState extends State<TagEditingScreen> {
  late GarmentCategory _selectedCategory;
  late String _selectedColor;
  final TextEditingController _brandController = TextEditingController();
  List<String> _selectedSeasons = [];
  List<String> _selectedOccasions = [];
  GarmentFit? _selectedFit;
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  final List<String> _seasons = ['Spring', 'Summer', 'Fall', 'Winter', 'All Year'];
  final List<String> _occasions = ['Work', 'Casual', 'Formal', 'Weekend', 'Travel', 'Sport'];
  final List<GarmentFit> _fits = GarmentFit.values;

  @override
  void initState() {
    super.initState();
    // Initialize from detected tags
    _selectedCategory = GarmentCategory.shirt;
    _selectedColor = widget.detectedTags?['color'] ?? 'Navy Blue';
    _selectedOccasions = ['Casual'];
    _selectedSeasons = ['All Year'];
    _brandController.text = widget.detectedTags?['brand'] ?? '';
    _notesController.text = '';
  }

  @override
  void dispose() {
    _brandController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveToWardrobe() async {
    setState(() => _isLoading = true);

    try {
      // Here we would save to Firestore
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        context.go(AppRoutes.itemSaved);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(AppStrings.editItemDetails),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image preview
                    Center(
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: widget.imagePath.isNotEmpty
                              ? Image.file(
                                  File(widget.imagePath),
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => _buildPlaceholder(),
                                )
                              : _buildPlaceholder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Category dropdown
                    _buildSectionTitle(AppStrings.category),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<GarmentCategory>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: GarmentCategory.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(_getCategoryName(category)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedCategory = value);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    // Color chip
                    _buildSectionTitle(AppStrings.color),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.primary),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A5F),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _selectedColor,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Brand input
                    _buildSectionTitle(AppStrings.brand),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _brandController,
                      decoration: const InputDecoration(
                        hintText: 'Enter brand name (optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Season chips
                    _buildSectionTitle(AppStrings.season),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _seasons.map((season) {
                        return SelectableChip(
                          label: season,
                          isSelected: _selectedSeasons.contains(season),
                          onTap: () {
                            setState(() {
                              if (_selectedSeasons.contains(season)) {
                                _selectedSeasons.remove(season);
                              } else {
                                _selectedSeasons.add(season);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    // Occasion chips
                    _buildSectionTitle(AppStrings.occasions),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _occasions.map((occasion) {
                        return SelectableChip(
                          label: occasion,
                          isSelected: _selectedOccasions.contains(occasion),
                          onTap: () {
                            setState(() {
                              if (_selectedOccasions.contains(occasion)) {
                                _selectedOccasions.remove(occasion);
                              } else {
                                _selectedOccasions.add(occasion);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    // Fit dropdown
                    _buildSectionTitle(AppStrings.fit),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<GarmentFit>(
                      initialValue: _selectedFit,
                      decoration: const InputDecoration(
                        hintText: 'Select fit',
                        border: OutlineInputBorder(),
                      ),
                      items: _fits.map((fit) {
                        return DropdownMenuItem(
                          value: fit,
                          child: Text(_getFitName(fit)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedFit = value);
                      },
                    ),
                    const SizedBox(height: 24),
                    // Add custom tag button
                    OutlinedButton.icon(
                      onPressed: () {
                        // Show add tag dialog
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(AppStrings.addCustomTag),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Notes
                    _buildSectionTitle(AppStrings.notes),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _notesController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Add any notes about this item...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  PrimaryButton(
                    text: AppStrings.saveToWardrobe,
                    onPressed: _saveToWardrobe,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.cameraCapture),
                    child: Text(
                      AppStrings.retakePhoto,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.checkroom,
        size: 64,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }

  String _getCategoryName(GarmentCategory category) {
    switch (category) {
      case GarmentCategory.tShirt:
        return 'T-Shirt';
      case GarmentCategory.shirt:
        return 'Shirt';
      case GarmentCategory.blouse:
        return 'Blouse';
      case GarmentCategory.sweater:
        return 'Sweater';
      case GarmentCategory.hoodie:
        return 'Hoodie';
      case GarmentCategory.jacket:
        return 'Jacket';
      case GarmentCategory.coat:
        return 'Coat';
      case GarmentCategory.blazer:
        return 'Blazer';
      case GarmentCategory.pants:
        return 'Pants';
      case GarmentCategory.jeans:
        return 'Jeans';
      case GarmentCategory.shorts:
        return 'Shorts';
      case GarmentCategory.skirt:
        return 'Skirt';
      case GarmentCategory.dress:
        return 'Dress';
      case GarmentCategory.suit:
        return 'Suit';
      case GarmentCategory.shoes:
        return 'Shoes';
      case GarmentCategory.sneakers:
        return 'Sneakers';
      case GarmentCategory.boots:
        return 'Boots';
      case GarmentCategory.sandals:
        return 'Sandals';
      case GarmentCategory.bag:
        return 'Bag';
      case GarmentCategory.watch:
        return 'Watch';
      case GarmentCategory.jewelry:
        return 'Jewelry';
      case GarmentCategory.hat:
        return 'Hat';
      case GarmentCategory.scarf:
        return 'Scarf';
      case GarmentCategory.belt:
        return 'Belt';
      case GarmentCategory.other:
        return 'Other';
    }
  }

  String _getFitName(GarmentFit fit) {
    switch (fit) {
      case GarmentFit.tight:
        return 'Tight';
      case GarmentFit.slim:
        return 'Slim';
      case GarmentFit.regular:
        return 'Regular';
      case GarmentFit.relaxed:
        return 'Relaxed';
      case GarmentFit.oversized:
        return 'Oversized';
    }
  }
}
