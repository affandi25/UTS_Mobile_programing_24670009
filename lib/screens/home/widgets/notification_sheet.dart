import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../models/notification_model.dart';
import '../../../services/notification_service.dart';

/// Modal Lembar Notifikasi Interaktif Sesuai Figma (#72:325)
/// Menampilkan daftar notifikasi, badge belum dibaca, tombol tandai semua dibaca,
/// dan aksi cepat langsung ke tab My Order.
class NotificationSheet extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: NotificationService.instance,
      builder: (ctx, _) {
        final notifications = NotificationService.instance.notifications;
        final unreadCount = NotificationService.instance.unreadCount;

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
                        if (unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$unreadCount Baru',
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
                    if (unreadCount > 0)
                      TextButton(
                        onPressed: () {
                          NotificationService.instance.markAllAsRead();
                        },
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
                child: notifications.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            'Belum ada notifikasi baru',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                        itemCount: notifications.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (ctx, index) {
                          final notif = notifications[index];
                          final isOrder = notif.type == NotificationType.order;

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: notif.isRead
                                  ? const Color(0xFFFAFAFA)
                                  : AppColors.primaryGold.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: notif.isRead
                                    ? Colors.black.withValues(alpha: 0.06)
                                    : AppColors.primaryGold.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ikon Jenis Notifikasi
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isOrder
                                        ? const Color(0xFF558B2F).withValues(alpha: 0.12)
                                        : AppColors.primaryGold.withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isOrder
                                        ? Icons.delivery_dining_rounded
                                        : Icons.local_offer_rounded,
                                    color: isOrder ? const Color(0xFF558B2F) : AppColors.primaryGold,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Konten Notifikasi
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notif.title,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                                color: AppColors.textDark,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            NotificationService.instance.formatRelativeTime(notif.timestamp),
                                            style: const TextStyle(fontSize: 10, color: Colors.black45),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        notif.message,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: notif.isRead ? Colors.black54 : AppColors.textDark,
                                          height: 1.3,
                                        ),
                                      ),
                                      if (isOrder) ...[
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {
                                              NotificationService.instance.markAsRead(notif.id);
                                              Navigator.pop(ctx);
                                              if (onSelectTab != null) {
                                                onSelectTab!(2); // Pindah ke tab My Order
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF558B2F),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Lihat Pesanan',
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
