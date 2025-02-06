import 'package:flutter/material.dart';

class LanguageOptionTile extends StatelessWidget {
  final String flagAssetPath;
  final String languageName;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageOptionTile({
    Key? key,
    required this.flagAssetPath,
    required this.languageName,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            // Flag icon
            Image.asset(
              flagAssetPath,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),

            // Language name
            Expanded(
              child: Text(
                languageName,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),

            // Custom Radio Button with Check Icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.red : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.red : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
