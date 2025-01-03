import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../utils/build_context_extension.dart';
import '../../utils/validation_helper.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _nomorController = TextEditingController();
  final _alamatController = TextEditingController();
  final _kotaController = TextEditingController();
  final _provinsiController = TextEditingController();
  final _kodePosController = TextEditingController();
  final _passwordVisible = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _nomorController.dispose();
    _alamatController.dispose();
    _kotaController.dispose();
    _provinsiController.dispose();
    _kodePosController.dispose();
    _passwordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    ref.listen<AsyncValue>(authProvider, (_, state) {
      if (state.value != null) {
        context.go('/dashboard');
      } else if (state.hasError) {
        context.showSnackBar(
            'Registration failed: ${state.error}', Status.error);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Toko Baru',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text('BATAL', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Column(
                          children: [
                            Icon(Icons.store, size: 80, color: Colors.red),
                            SizedBox(height: 8),
                            Text(
                              'SaldoSmart',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _nameController,
                        labelText: 'Nama Toko',
                        validator: (value) => ValidationHelper.validateNotEmpty(
                            value, 'Nama Toko'),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            ValidationHelper.validateEmail(value),
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<bool>(
                        valueListenable: _passwordVisible,
                        builder: (context, isVisible, child) {
                          return CustomTextFormField(
                            controller: _passwordController,
                            labelText: 'Password',
                            obscureText: !isVisible,
                            suffixIcon: IconButton(
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () =>
                                  _passwordVisible.value = !isVisible,
                            ),
                            validator: (value) =>
                                ValidationHelper.validateMultiple(value, [
                              (v) => ValidationHelper.validateNotEmpty(
                                  v, 'Password'),
                              (v) =>
                                  ValidationHelper.validateMinLength(v, 8, 'Password'),
                            ]),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _nomorController,
                        labelText: 'No Telepon',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _alamatController,
                        labelText: 'Alamat Toko',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              controller: _kotaController,
                              labelText: 'Kota',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextFormField(
                              controller: _provinsiController,
                              labelText: 'Provinsi',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _kodePosController,
                        labelText: 'Kode Pos',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: authState.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  ref.read(authProvider.notifier).register(
                                        _emailController.text,
                                        _passwordController.text,
                                        _nameController.text,
                                        _nomorController.text,
                                        _alamatController.text,
                                        _kotaController.text,
                                        _provinsiController.text,
                                        _kodePosController.text,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: authState.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'BUAT TOKO',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
