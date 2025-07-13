import 'package:flutter/material.dart';

class FormActions extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onReset;
  final bool isLoading;

  const FormActions({
    super.key,
    required this.onSave,
    required this.onReset,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: isLoading ? null : onSave,
          icon:
              isLoading
                  ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                  : const Icon(Icons.save),
          label: Text(isLoading ? 'Đang lưu...' : 'Lưu phiếu nhập kho'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: isLoading ? null : onReset,
          icon: const Icon(Icons.refresh),
          label: const Text('Làm mới form'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
