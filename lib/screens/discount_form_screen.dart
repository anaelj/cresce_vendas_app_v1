import 'package:cresce_vendas_app_v1/components/CustomAppBar.dart';
import 'package:cresce_vendas_app_v1/components/CustomDateTimePicker.dart';
import 'package:cresce_vendas_app_v1/components/CustomDropdownButtonFormField.dart';
import 'package:cresce_vendas_app_v1/components/CustomFormTextField.dart';
import 'package:cresce_vendas_app_v1/components/DashedBorderContainer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../models/discount.dart';
import '../stores/product_store.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';

class DiscountFormScreen extends StatefulWidget {
  final Product? product;

  const DiscountFormScreen({super.key, this.product});

  @override
  State<DiscountFormScreen> createState() => _DiscountFormScreenState();
}

class _DiscountFormScreenState extends State<DiscountFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _selectedDiscountType = 'Percentual';
  late DateTime _startDate;
  late DateTime _endDate;
  String? _imagePath;
  final _store = ProductStore();

  // Discount type specific controllers
  final _fromPriceController = TextEditingController();
  final _toPriceController = TextEditingController();
  final _priceController = TextEditingController();
  final _percentageController = TextEditingController();
  final _buyQuantityController = TextEditingController();
  final _payQuantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _startDate = widget.product?.discount?.startDate ?? DateTime.now();
    _endDate = widget.product?.discount?.endDate ??
        DateTime.now().add(const Duration(days: 7));
    _imagePath = widget.product?.image;

    if (widget.product?.discount != null) {
      _selectedDiscountType = widget.product!.discount!.type;
      _initializeDiscountControllers();
    }
  }

  void _initializeDiscountControllers() {
    final discount = widget.product!.discount!;
    switch (_selectedDiscountType) {
      case 'De Por':
        _fromPriceController.text = discount.fromPrice.toString();
        _toPriceController.text = discount.toPrice.toString();
        break;
      case 'Leve + Pague-':
        _priceController.text = widget.product!.price.toString();
        _buyQuantityController.text = discount.buyQuantity.toString();
        _payQuantityController.text = discount.payQuantity.toString();
        break;
      case 'Percentual':
        _priceController.text = widget.product!.price.toString();
        _percentageController.text = discount.percentageDiscount.toString();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleText: widget.product == null
              ? 'Cadastro de Desconto'
              : 'Editar Desconto'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _titleController,
                labelText: 'Nome do desconto',
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: _descriptionController,
                labelText: 'Descrição',
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              CustomDropdownButtonFormField<String>(
                value: _selectedDiscountType,
                items: ['Percentual', 'De Por', 'Leve + Pague-']
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDiscountType = value!;
                  });
                },
                labelText: 'Tipo de desconto',
                validator: (value) =>
                    value == null ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              _buildDiscountTypeFields(),
              const SizedBox(height: 16),
              // Substituindo o ListTile pelo CustomDateTimePicker

              Row(
                children: [
                  Expanded(
                    child: CustomDateTimePicker(
                      initialDate: _startDate,
                      onDateTimeChanged: (newDateTime) {
                        setState(() {
                          _startDate = newDateTime;
                        });
                      },
                      labelText: 'Data ativação',
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: CustomDateTimePicker(
                      initialDate: _endDate,
                      onDateTimeChanged: (newDateTime) {
                        setState(() {
                          _endDate = newDateTime;
                        });
                      },
                      labelText: 'Data inativação',
                    ),
                  )
                ],
              ),

              const SizedBox(height: 24),
              DashedBorderContainer(
                child: Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 73, // Largura máxima
                        maxHeight: 52, // Altura máxima
                      ),
                      child: Container(
                        width: 73, // Largura fixa
                        height: 52, // Altura fixa
                        child:
                            _imagePath != null && File(_imagePath!).existsSync()
                                ? Image.file(
                                    File(_imagePath!),
                                    fit: BoxFit.cover,
                                  )
                                : SvgPicture.asset(
                                    'assets/svg/Frame.svg',
                                    width: 73, // Largura do SVG
                                    height: 51, // Altura do SVG
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _saveDiscount,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007FBA),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Salvar',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDiscountTypeFields() {
    switch (_selectedDiscountType) {
      case 'De Por':
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _fromPriceController,
                labelText: 'Preço DE',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextFormField(
                controller: _toPriceController,
                labelText: 'Preço POR',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
            ),
          ],
        );
      case 'Leve + Pague-':
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: _buyQuantityController,
                    labelText: 'Leve',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    controller: _payQuantityController,
                    labelText: 'Pague',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Campo obrigatório' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _priceController,
              labelText: 'Preço',
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Campo obrigatório' : null,
            ),
          ],
        );
      case 'Percentual':
        return Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: _priceController,
                labelText: 'Preço',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Campo obrigatório' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: CustomTextFormField(
              controller: _percentageController,
              labelText: 'Percentual de desconto',
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Campo obrigatório' : null,
            )),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveDiscount() async {
    if (_formKey.currentState?.validate() ?? false) {
      final discount = Discount(
        status: true,
        type: _selectedDiscountType,
        startDate: _startDate,
        endDate: _endDate,
        fromPrice: double.tryParse(_fromPriceController.text) ?? 0,
        toPrice: double.tryParse(_toPriceController.text) ?? 0,
        percentageDiscount: double.tryParse(_percentageController.text) ?? 0,
        buyQuantity: int.tryParse(_buyQuantityController.text) ?? 0,
        payQuantity: int.tryParse(_payQuantityController.text) ?? 0,
      );

      final product = Product(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        description: _descriptionController.text,
        category: widget.product?.category ?? 'default',
        image: _imagePath ?? 'assets/svg/Frame.svg',
        discount: discount,
      );

      if (widget.product != null) {
        final index = _store.products.indexOf(widget.product!);
        if (index != -1) {
          await _store.updateProduct(index, product);
        } else {
          // Handle the case where the product is not found in the list
          // For example, you can show an error message or add the product as a new entry
          await _store.addProduct(product);
        }
      } else {
        await _store.addProduct(product);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _fromPriceController.dispose();
    _toPriceController.dispose();
    _priceController.dispose();
    _percentageController.dispose();
    _buyQuantityController.dispose();
    _payQuantityController.dispose();
    super.dispose();
  }
}
