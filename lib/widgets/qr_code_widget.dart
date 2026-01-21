import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr/qr.dart';
import '../constants/colors.dart';
import '../constants/dimensions.dart';

class QRCodeWidget extends StatelessWidget {
  final String qrData;
  final String? title;
  final double size;

  const QRCodeWidget({
    Key? key,
    required this.qrData,
    this.title,
    this.size = 200,
  }) : super(key: key);

  Widget _buildQrImage() {
    try {
      final qrCode = QrCode.fromData(
        data: qrData,
        errorCorrectLevel: QrErrorCorrectLevel.H,
      );
      return SizedBox(
        width: size,
        height: size,
        child: QrImage(qrCode) as Widget,
      );
    } catch (e) {
      return Container(
        color: Colors.grey[300],
        child: Center(
          child: Text('Erreur QR: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: AppDimensions.paddingLarge),
        ],
        Container(
          padding: EdgeInsets.all(AppDimensions.padding),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.grey300, width: 2),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
          ),
          child: SizedBox(
            width: size,
            height: size,
            child: _buildQrImage(),
          ),
        ),
        SizedBox(height: AppDimensions.paddingLarge),
        Text(
          'Présentez ce code au médecin',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grey600,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class QRScannerWidget extends StatefulWidget {
  final Function(String) onQRCodeDetected;
  final VoidCallback? onCancel;

  const QRScannerWidget({
    Key? key,
    required this.onQRCodeDetected,
    this.onCancel,
  }) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  bool _isScanning = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scanner un code QR'),
          backgroundColor: AppColors.primary,
        ),
        body: Center(
          child: _isScanning
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_2,
                      size: 100,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: AppDimensions.paddingLarge),
                    Text(
                      'Pointez la caméra sur le code QR',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppDimensions.paddingLarge),
                    ElevatedButton.icon(
                      onPressed: widget.onCancel,
                      icon: Icon(Icons.close),
                      label: Text('Annuler'),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }
}
