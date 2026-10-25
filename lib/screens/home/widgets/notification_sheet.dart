import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../models/notification_model.dart';

/// Modal Lembar Notifikasi Interaktif Sesuai Figma (#72:325)
class NotificationSheet extends StatefulWidget {
  final Function(int tabIndex)? onSelectTab;

  const NotificationSheet({
    super.key,
    this.onSelectTab,
  });

  /// Helper untuk menampilkan lembar notifikasi dari layar mana pun
  static void show(BuildContext context, {Function(int tabIndex)? onSelectTab}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => NotificationSheet(onSelectTab: onSelectTab),
    );
  }

  @override
  State<NotificationSheet> createState() => _NotificationSheetState();
}

class _NotificationSheetState extends State<NotificationSheet> {
  // Data notifikasi statis untuk penilaian Progres 1
  late final List<NotificationModel> _notifications;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _notifications = [
      NotificationModel(
        id: 'n1',
        title: 'Pesanan Sedang Diproses',
        message: 'Donat Rasa Coklat pesananmu sedang disiapkan dengan cinta di dapur SweetBite.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        type: NotificationType.order,
        isRead: false,
      ),
      NotificationModel(
        id: 'n2',
        title: 'Promo Spesial Donat 10K',
        message: 'Gunakan voucher SWEET10K untuk mendapatkan 1 paket donat spesial hanya Rp 10.000.',
        timestamp: now.subtract(const Duration(hours: 1)),
        type: NotificationType.promo,
        isRead: false,
      ),
      NotificationModel(
        id: 'n3',
        title: 'Selamat Datang di SweetBite!',
        message: 'Nikmati aneka pilihan donat manis premium dan promo menarik setiap hari.',
        timestamp: now.subtract(const Duration(days: 1)),
        type: NotificationType.general,
        isRead: true,
      ),
    ];
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  void _markAllAsRead() {
    setState(() {
      for (int i = 0; i < _notifications.length; i++) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    });
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes} mnt lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    return '${diff.inDays} hari lalu';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          // Drag Handle Bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header: Judul & Tombol Tandai Semua Dibaca
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Notifikasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    if (_unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$_unreadCount Baru',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (_unreadCount > 0)
                  TextButton(
                    onPressed: _markAllAsRead,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      'Tandai Dibaca',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 20),

          // List Notifikasi
          Flexible(
            child: _notifications.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'Belum ada notifikasi baru',
                        style: TextStyle(color: Colors.black45, fontSize: 13),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: _notifications.length,
                    separatorBuilder: (_, _) => const Divider(height: 16, color: Color(0xFFF3F3F3)),
                    itemBuilder: (ctx, index) {
                      final item = _notifications[index];
                      return InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            _notifications[index] = item.copyWith(isRead: true);
                          });
                          if (item.type == NotificationType.order && widget.onSelectTab != null) {
                            Navigator.pop(context);
                            widget.onSelectTab!(1); // Pindah ke tab My Order
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: item.isRead ? Colors.transparent : const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(12),
                            border: item.isRead ? null : Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: _getIconBgColor(item.type),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getNotificationIcon(item.type),
                                  size: 18,
                                  color: _getIconColor(item.type),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: item.isRead ? FontWeight.w600 : FontWeight.bold,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          _formatTimeAgo(item.timestamp),
                                          style: const TextStyle(fontSize: 11, color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.message,
                                      style: TextStyle(
                                        fontSize: 12,
                                        height: 1.3,
                                        color: item.isRead ? Colors.black54 : AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return Icons.local_shipping_rounded;
      case NotificationType.promo:
        return Icons.discount_rounded;
      case NotificationType.general:
        return Icons.notifications_active_rounded;
    }
  }

  Color _getIconBgColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFFEFF6FF);
      case NotificationType.promo:
        return const Color(0xFFFEF3C7);
      case NotificationType.general:
        return const Color(0xFFF3F4F6);
    }
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.order:
        return const Color(0xFF2563EB);
      case NotificationType.promo:
        return AppColors.primaryGold;
      case NotificationType.general:
        return Colors.black54;
    }
  }
}
