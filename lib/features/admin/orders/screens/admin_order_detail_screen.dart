import 'package:flutter/material.dart';
import 'package:karasko_mobile_project/features/admin/orders/models/admin_order_data.dart';

const _forest = Color(0xFF032217);
const _mint = Color(0xFFC8EAD7);
const _paper = Color(0xFFF8F8F5);
const _muted = Color(0xFF747C77);
const _copper = Color(0xFF9A6034);

class AdminOrderDetailScreen extends StatefulWidget {
  const AdminOrderDetailScreen({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  final AdminOrderData order;
  final ValueChanged<AdminOrderData> onStatusChanged;

  @override
  State<AdminOrderDetailScreen> createState() => _AdminOrderDetailScreenState();
}

class _AdminOrderDetailScreenState extends State<AdminOrderDetailScreen> {
  late AdminOrderStatus _status = widget.order.status;

  AdminOrderStatus? get _nextStatus => switch (_status) {
    AdminOrderStatus.newOrder => AdminOrderStatus.preparing,
    AdminOrderStatus.preparing => AdminOrderStatus.ready,
    AdminOrderStatus.ready => AdminOrderStatus.completed,
    AdminOrderStatus.completed || AdminOrderStatus.cancelled => null,
  };

  String get _nextActionLabel => switch (_status) {
    AdminOrderStatus.newOrder => 'Mulai Diproses',
    AdminOrderStatus.preparing => 'Tandai Siap Diambil',
    AdminOrderStatus.ready => 'Selesaikan Pesanan',
    AdminOrderStatus.completed ||
    AdminOrderStatus.cancelled => 'Pesanan Ditutup',
  };

  void _changeStatus(AdminOrderStatus status) {
    setState(() => _status = status);
    widget.onStatusChanged(widget.order.copyWith(status: status));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Status pesanan ${_statusLabel(status).toLowerCase()}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _confirmCancel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Batalkan pesanan?'),
        content: Text('Pesanan #${widget.order.id} akan ditandai dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kembali'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFB34B43),
            ),
            child: const Text('Batalkan'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      _changeStatus(AdminOrderStatus.cancelled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final nextStatus = _nextStatus;

    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        shadowColor: _forest.withValues(alpha: 0.12),
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(
            color: _forest,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id}',
                      style: const TextStyle(
                        color: _forest,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order.timeLabel} · ${order.customerName}',
                      style: const TextStyle(color: _muted, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _OrderStatusBadge(status: _status),
            ],
          ),
          const SizedBox(height: 18),
          _OrderProgress(status: _status),
          const SizedBox(height: 14),
          _DetailSection(
            title: 'Rincian Pesanan',
            trailing: '${order.items.length} menu',
            child: Column(
              children: [
                for (var index = 0; index < order.items.length; index++) ...[
                  if (index > 0) const Divider(height: 18, color: _paper),
                  _OrderLineTile(item: order.items[index]),
                ],
                const Divider(height: 20, color: _paper),
                _PriceRow(label: 'Subtotal', amount: order.total),
                const SizedBox(height: 8),
                const _PriceRow(label: 'Biaya layanan', amount: 0),
                const Divider(height: 20, color: _paper),
                _PriceRow(
                  label: 'Total Pembayaran',
                  amount: order.total,
                  emphasized: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _DetailSection(
            title: 'Informasi Pelanggan',
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Nama pelanggan',
                  value: order.customerName,
                ),
                const SizedBox(height: 12),
                _InfoRow(
                  icon: Icons.payments_outlined,
                  label: 'Pembayaran',
                  value: order.paymentMethod,
                ),
                if (order.note != null) ...[
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.sticky_note_2_outlined,
                    label: 'Catatan',
                    value: order.note!,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: nextStatus == null
                      ? null
                      : () => _changeStatus(nextStatus),
                  style: FilledButton.styleFrom(
                    backgroundColor: _forest,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFE5E5E1),
                    disabledForegroundColor: _muted,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: Icon(
                    _status == AdminOrderStatus.newOrder
                        ? Icons.play_arrow_rounded
                        : _status == AdminOrderStatus.ready
                        ? Icons.check_circle_outline
                        : Icons.arrow_forward_rounded,
                    size: 19,
                  ),
                  label: Text(
                    _nextActionLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              if (_status == AdminOrderStatus.newOrder ||
                  _status == AdminOrderStatus.preparing)
                TextButton.icon(
                  onPressed: _confirmCancel,
                  icon: const Icon(Icons.close, size: 16),
                  label: const Text('Batalkan Pesanan'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFB34B43),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

String _statusLabel(AdminOrderStatus status) => switch (status) {
  AdminOrderStatus.newOrder => 'Baru',
  AdminOrderStatus.preparing => 'Diproses',
  AdminOrderStatus.ready => 'Siap diambil',
  AdminOrderStatus.completed => 'Selesai',
  AdminOrderStatus.cancelled => 'Dibatalkan',
};

class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({required this.status});

  final AdminOrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      AdminOrderStatus.newOrder => _copper,
      AdminOrderStatus.preparing => const Color(0xFF386C9B),
      AdminOrderStatus.ready => const Color(0xFF36765D),
      AdminOrderStatus.completed => _forest,
      AdminOrderStatus.cancelled => const Color(0xFFB34B43),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        _statusLabel(status),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OrderProgress extends StatelessWidget {
  const _OrderProgress({required this.status});

  final AdminOrderStatus status;

  @override
  Widget build(BuildContext context) {
    const steps = ['Pesanan masuk', 'Sedang dibuat', 'Siap diambil', 'Selesai'];
    final activeStep = switch (status) {
      AdminOrderStatus.newOrder => 0,
      AdminOrderStatus.preparing => 1,
      AdminOrderStatus.ready => 2,
      AdminOrderStatus.completed => 3,
      AdminOrderStatus.cancelled => -1,
    };

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: status == AdminOrderStatus.cancelled
          ? const Row(
              children: [
                Icon(Icons.cancel_outlined, color: Color(0xFFB34B43), size: 19),
                SizedBox(width: 8),
                Text(
                  'Pesanan dibatalkan',
                  style: TextStyle(
                    color: Color(0xFFB34B43),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          : Row(
              children: [
                for (var index = 0; index < steps.length; index++) ...[
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 23,
                          height: 23,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: index <= activeStep ? _forest : _paper,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            index < activeStep ? Icons.check : Icons.circle,
                            size: index < activeStep ? 14 : 8,
                            color: index <= activeStep ? _mint : _muted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          steps[index],
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            color: index <= activeStep ? _forest : _muted,
                            fontSize: 8,
                            fontWeight: index == activeStep
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (index < steps.length - 1)
                    Container(
                      width: 12,
                      height: 1,
                      margin: const EdgeInsets.only(bottom: 18),
                      color: index < activeStep
                          ? _forest
                          : const Color(0xFFE5E5E1),
                    ),
                ],
              ],
            ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.child,
    this.trailing,
  });

  final String title;
  final Widget child;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _forest,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing!,
                  style: const TextStyle(color: _muted, fontSize: 10),
                ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _OrderLineTile extends StatelessWidget {
  const _OrderLineTile({required this.item});

  final AdminOrderLine item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _paper,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.local_cafe_outlined,
            color: _forest,
            size: 17,
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.quantity}x ${item.name}',
                style: const TextStyle(
                  color: _forest,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                item.customization,
                style: const TextStyle(color: _muted, fontSize: 9, height: 1.3),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'Rp ${formatAdminCurrency(item.total)}',
          style: const TextStyle(
            color: _forest,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.amount,
    this.emphasized = false,
  });

  final String label;
  final int amount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: emphasized ? _forest : _muted,
      fontSize: emphasized ? 12 : 10,
      fontWeight: emphasized ? FontWeight.w800 : FontWeight.w400,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text('Rp ${formatAdminCurrency(amount)}', style: style),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: _copper),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: _muted, fontSize: 9)),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: _forest,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
