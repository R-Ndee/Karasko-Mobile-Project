import 'package:flutter/material.dart';

const _forest = Color(0xFF032217);
const _mint = Color(0xFFC8EAD7);
const _paper = Color(0xFFF8F8F5);
const _muted = Color(0xFF747C77);
const _copper = Color(0xFF9A6034);

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var _selectedCategory = 0;

  static const _coffee = [
    _MenuProduct(
      'North Signature Aren Latte',
      'Espresso, susu, dan gula aren',
      22000,
      'SIGNATURE',
      Color(0xFFD8B598),
      Icons.local_cafe,
    ),
    _MenuProduct(
      'Cold Brew Original',
      'Seduhan dingin 18 jam',
      28000,
      'STEEPED',
      Color(0xFFC7D3D0),
      Icons.coffee,
    ),
    _MenuProduct(
      'Kopi Susu Gula Aren',
      'Favorit dengan gula aren lokal',
      20000,
      'FAVORIT',
      Color(0xFFE2C9A6),
      Icons.coffee,
    ),
    _MenuProduct(
      'Caramel Macchiato',
      'Espresso dengan karamel lembut',
      26000,
      'MANIS',
      Color(0xFFE5C8B2),
      Icons.local_cafe,
    ),
    _MenuProduct(
      'Cappuccino',
      'Espresso dan foam susu',
      24000,
      'CLASSIC',
      Color(0xFFD9D0C2),
      Icons.coffee,
    ),
    _MenuProduct(
      'Cafe Mocha',
      'Cokelat, espresso, dan susu',
      26000,
      'CHOCOLATE',
      Color(0xFFC9B7AA),
      Icons.local_cafe,
    ),
    _MenuProduct(
      'Americano',
      'Espresso dengan air pilihan',
      18000,
      'ESPRESSO',
      Color(0xFFD5D9D0),
      Icons.coffee,
    ),
    _MenuProduct(
      'Vanilla Latte',
      'Latte dengan aroma vanilla',
      25000,
      'CREAMY',
      Color(0xFFE5D9C6),
      Icons.local_cafe,
    ),
    _MenuProduct(
      'Spanish Latte',
      'Latte creamy dengan susu manis',
      26000,
      'CREAMY',
      Color(0xFFD6C7AE),
      Icons.coffee,
    ),
    _MenuProduct(
      'Piccolo',
      'Double ristretto dan microfoam',
      22000,
      'ESPRESSO',
      Color(0xFFD8CBBE),
      Icons.local_cafe,
    ),
  ];

  static const _nonCoffee = [
    _MenuProduct(
      'Matcha Latte',
      'Matcha pilihan dan susu segar',
      26000,
      'MATCHA',
      Color(0xFFC8D6B8),
      Icons.emoji_food_beverage,
    ),
    _MenuProduct(
      'Chocolate',
      'Cokelat pekat dengan susu',
      24000,
      'CHOCOLATE',
      Color(0xFFD6BBAA),
      Icons.emoji_food_beverage,
    ),
    _MenuProduct(
      'Hojicha Latte',
      'Teh hojicha panggang dan susu',
      27000,
      'TEA',
      Color(0xFFD9C6AA),
      Icons.emoji_food_beverage,
    ),
    _MenuProduct(
      'Lychee Tea',
      'Teh segar dengan leci',
      22000,
      'REFRESHING',
      Color(0xFFE5C6C1),
      Icons.local_drink,
    ),
    _MenuProduct(
      'Lemon Tea',
      'Teh hitam dan lemon',
      20000,
      'REFRESHING',
      Color(0xFFE3D9A9),
      Icons.local_drink,
    ),
  ];

  List<_MenuProduct> get _products =>
      _selectedCategory == 0 ? _coffee : _nonCoffee;

  Future<void> _openProduct(_MenuProduct product) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProductOptionsSheet(
        product: product,
        onAdd: (size, quantity, total) {
          Navigator.pop(context);
          ScaffoldMessenger.of(this.context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  '$quantity ${product.name} ($size) ditambahkan · Rp ${_formatPrice(total)}',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.95),
        elevation: 1,
        shadowColor: const Color(0xFF032217).withOpacity(0.2),
        titleSpacing: 16,
        title: Row(
          children: [
            const Icon(Icons.coffee_maker, color: Color(0xFF032217), size: 28),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Karasko',
                      style: TextStyle(
                        color: Color(0xFF032217),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8EAD7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'MANADO',
                        style: TextStyle(
                          color: Color(0xFF022115),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.circle, color: Color(0xFF68DBA9), size: 6),
                    SizedBox(width: 4),
                    Text(
                      'Buka • Kedai Terpilih',
                      style: TextStyle(color: Color(0xFF424844), fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            width: 80,
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.storefront, color: Color(0xFF845326), size: 18),
                SizedBox(width: 4),
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Color(0xFF1A1C1B),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PILIHAN SEDUHAN',
                        style: TextStyle(
                          color: _copper,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Katalog Menu',
                        style: TextStyle(
                          color: _forest,
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEA),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.grain, color: _copper, size: 14),
                      SizedBox(width: 5),
                      Text(
                        'Biji Pilihan Hari Ini',
                        style: TextStyle(
                          fontSize: 10,
                          color: _forest,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                _CategoryPill(
                  label: 'Coffee',
                  count: 10,
                  selected: _selectedCategory == 0,
                  icon: Icons.coffee,
                  onTap: () => setState(() => _selectedCategory = 0),
                ),
                const SizedBox(width: 10),
                _CategoryPill(
                  label: 'Non-Coffee',
                  count: 5,
                  selected: _selectedCategory == 1,
                  icon: Icons.emoji_food_beverage,
                  onTap: () => setState(() => _selectedCategory = 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 22),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 14,
                childAspectRatio: 0.73,
              ),
              itemBuilder: (context, index) => _ProductCard(
                product: _products[index],
                onTap: () => _openProduct(_products[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuProduct {
  const _MenuProduct(
    this.name,
    this.description,
    this.price,
    this.tag,
    this.color,
    this.icon,
  );

  final String name;
  final String description;
  final int price;
  final String tag;
  final Color color;
  final IconData icon;
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.label,
    required this.count,
    required this.selected,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _forest : const Color(0xFFF0F0ED),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 15, color: selected ? Colors.white : _muted),
              const SizedBox(width: 7),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : _forest,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 21,
                height: 19,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFF1A382B)
                      : const Color(0xFFE5E5E1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    color: selected ? _mint : _muted,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final _MenuProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -18,
                      top: -22,
                      child: Icon(
                        Icons.circle,
                        size: 104,
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    Icon(
                      product.icon,
                      size: 65,
                      color: _forest.withValues(alpha: 0.76),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.88),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          product.tag,
                          style: const TextStyle(
                            fontSize: 8,
                            color: _forest,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _forest,
                      fontSize: 12,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${_formatPrice(product.price)}',
                    style: const TextStyle(
                      color: _copper,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
}

class _ProductOptionsSheet extends StatefulWidget {
  const _ProductOptionsSheet({required this.product, required this.onAdd});

  final _MenuProduct product;
  final void Function(String size, int quantity, int total) onAdd;

  @override
  State<_ProductOptionsSheet> createState() => _ProductOptionsSheetState();
}

class _ProductOptionsSheetState extends State<_ProductOptionsSheet> {
  static const _sizes = ['Reguler', 'Large'];
  static const _sizeLabels = ['350 ml', '480 ml'];
  static const _priceAdditions = [4000, 8000];
  var _selectedSize = 0;
  var _isIced = true;
  var _sugar = 'Less Sugar';
  var _ice = 'Normal Ice';
  var _quantity = 1;

  int get _unitPrice => widget.product.price + _priceAdditions[_selectedSize];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.88,
      ),
      decoration: const BoxDecoration(
        color: _paper,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(18, 10, 18, 16 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8D8D3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: widget.product.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(widget.product.icon, size: 34, color: _forest),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department,
                              size: 13,
                              color: _copper,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'RACIKAN FAVORIT',
                              style: TextStyle(
                                fontSize: 9,
                                color: _copper,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            color: _forest,
                            fontSize: 16,
                            height: 1.15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product.description,
                          style: const TextStyle(color: _muted, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _SectionHeading(
                title: 'Pilih Ukuran Cup',
                requiredLabel: '*Wajib',
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(_sizes.length, (index) {
                  final selected = _selectedSize == index;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index == _sizes.length - 1 ? 0 : 7,
                      ),
                      child: _ChoiceTile(
                        selected: selected,
                        onTap: () => setState(() => _selectedSize = index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_cafe_outlined,
                              color: selected ? Colors.white : _forest,
                              size: 19,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _sizes[index],
                              style: TextStyle(
                                color: selected ? Colors.white : _forest,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              _sizeLabels[index],
                              style: TextStyle(
                                color: selected ? _mint : _muted,
                                fontSize: 9,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${_formatPrice(widget.product.price + _priceAdditions[index])}',
                              style: TextStyle(
                                color: selected ? _mint : _copper,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              _SectionHeading(title: 'Suhu Penyajian', trailing: 'Bebas Biaya'),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: _OptionButton(
                      label: 'Ice (Dingin)',
                      icon: Icons.ac_unit,
                      selected: _isIced,
                      onTap: () => setState(() => _isIced = true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _OptionButton(
                      label: 'Hot (Hangat)',
                      icon: Icons.local_fire_department_outlined,
                      selected: !_isIced,
                      onTap: () => setState(() => _isIced = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _OptionGroup(
                      title: 'Tingkat Gula',
                      options: const ['Normal Sugar', 'Less Sugar', 'No Sugar'],
                      selected: _sugar,
                      onSelect: (value) => setState(() => _sugar = value),
                    ),
                  ),
                  if (_isIced) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OptionGroup(
                        title: 'Tingkat Es',
                        options: const ['Normal Ice', 'Less Ice'],
                        selected: _ice,
                        onSelect: (value) => setState(() => _ice = value),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0EC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.verified_outlined, color: _copper, size: 17),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Standard NorthGrind Quality\nRacikan original menjaga profil seduh murni tanpa topping atau sirup berbayar tambahan.',
                        style: TextStyle(
                          color: _forest,
                          fontSize: 10,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'JUMLAH PESANAN',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Rp ${_formatPrice(_unitPrice * _quantity)} / cup',
                          style: const TextStyle(
                            color: _forest,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFE4E4DF)),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Row(
                      children: [
                        _QuantityButton(
                          icon: Icons.remove,
                          onTap: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                        ),
                        SizedBox(
                          width: 28,
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _forest,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        _QuantityButton(
                          icon: Icons.add,
                          filled: true,
                          onTap: () => setState(() => _quantity++),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton.icon(
                  onPressed: () => widget.onAdd(
                    _sizes[_selectedSize],
                    _quantity,
                    _unitPrice * _quantity,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: _forest,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                  label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tambah ke Keranjang',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Rp ${_formatPrice(_unitPrice * _quantity)}',
                        style: const TextStyle(
                          color: _mint,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    this.requiredLabel,
    this.trailing,
  });

  final String title;
  final String? requiredLabel;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _forest,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (requiredLabel != null) ...[
          const SizedBox(width: 5),
          Text(
            requiredLabel!,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const Spacer(),
        if (trailing != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _forest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              trailing!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.selected,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _forest : const Color(0xFFF0F0EC),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(height: 102, child: Center(child: child)),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? _forest : const Color(0xFFF0F0EC),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: selected ? _mint : _copper),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : _forest,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionGroup extends StatelessWidget {
  const _OptionGroup({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _forest,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        for (final option in options) ...[
          Material(
            color: selected == option ? _forest : const Color(0xFFF0F0EC),
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              onTap: () => onSelect(option),
              borderRadius: BorderRadius.circular(7),
              child: SizedBox(
                height: 29,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected == option ? Colors.white : _forest,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (selected == option)
                        const Icon(
                          Icons.check_circle_outline,
                          color: _mint,
                          size: 12,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (option != options.last) const SizedBox(height: 5),
        ],
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      iconSize: 17,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      style: IconButton.styleFrom(
        backgroundColor: filled ? _forest : Colors.white,
        foregroundColor: filled ? Colors.white : _muted,
        disabledForegroundColor: const Color(0xFFD0D0CB),
      ),
      icon: Icon(icon),
    );
  }
}

String _formatPrice(int price) => price.toString().replaceAllMapped(
  RegExp(r'\B(?=(\d{3})+(?!\d))'),
  (_) => '.',
);
