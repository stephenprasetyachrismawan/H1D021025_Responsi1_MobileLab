import 'package:flutter/material.dart';
import 'package:responsi1/bloc/ikan_bloc.dart';
import 'package:responsi1/model/ikan.dart';
import 'package:responsi1/ui/ikan_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

class IkanForm extends StatefulWidget {
  final Ikan? ikan;

  const IkanForm({Key? key, this.ikan}) : super(key: key);

  @override
  _IkanFormState createState() => _IkanFormState();
}

class _IkanFormState extends State<IkanForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH IKAN";
  String tombolSubmit = "SIMPAN";

  final _namaIkanTextboxController = TextEditingController();
  final _habitatIkanTextboxController = TextEditingController();
  final _jenisIkanTextboxController = TextEditingController();
  final _warnaIkanTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.ikan != null) {
      setState(() {
        judul = "UBAH IKAN";
        tombolSubmit = "UBAH";
        _namaIkanTextboxController.text = widget.ikan!.namaIkan!;
        _habitatIkanTextboxController.text = widget.ikan!.habitatIkan!;
        _jenisIkanTextboxController.text = widget.ikan!.jenisIkan!;
        _warnaIkanTextboxController.text = widget.ikan!.warnaIkan!;
      });
    } else {
      judul = "TAMBAH IKAN";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaIkanTextField(),
                _warnaIkanTextField(),
                _jenisIkanTextField(),
                _habitatIkanTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Ikan"),
      keyboardType: TextInputType.text,
      controller: _namaIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jenisIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jenis Ikan"),
      keyboardType: TextInputType.text,
      controller: _jenisIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jenis Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _warnaIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Warna Ikan"),
      keyboardType: TextInputType.text,
      controller: _warnaIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Warna Ikan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _habitatIkanTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Habitat Ikan"),
      keyboardType: TextInputType.text,
      controller: _habitatIkanTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Habitat Ikan harus diisi";
        }
        return null;
      },
    );
  }

// Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.ikan != null) {
              // Kondisi untuk mengubah produk
              // Panggil metode ubah() atau logika lainnya
              ubah();
            } else {
              // Kondisi untuk menambah produk
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });

    Ikan createIkan = Ikan(id: null);
    createIkan.namaIkan = _namaIkanTextboxController.text;
    createIkan.habitatIkan = _habitatIkanTextboxController.text;
    createIkan.jenisIkan = _jenisIkanTextboxController.text;
    createIkan.warnaIkan = _warnaIkanTextboxController.text;

    IkanBloc.addIkan(ikan: createIkan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const IkanPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });

    Ikan updateIkan = Ikan(id: widget.ikan!.id!);

    updateIkan.namaIkan = _namaIkanTextboxController.text;
    updateIkan.habitatIkan = _habitatIkanTextboxController.text;
    updateIkan.jenisIkan = _jenisIkanTextboxController.text;
    updateIkan.warnaIkan = _warnaIkanTextboxController.text;
    IkanBloc.updateIkan(ikan: updateIkan).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const IkanPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }
}
