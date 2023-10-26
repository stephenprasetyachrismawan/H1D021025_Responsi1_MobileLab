import 'package:flutter/material.dart';
import 'package:responsi1/bloc/ikan_bloc.dart';
import 'package:responsi1/model/ikan.dart';
import 'package:responsi1/ui/ikan_form.dart';
import 'package:responsi1/ui/ikan_page.dart';
import 'package:responsi1/widget/warning_dialog.dart';

class IkanDetail extends StatefulWidget {
  final Ikan? ikan;

  IkanDetail({Key? key, this.ikan}) : super(key: key);

  @override
  _IkanDetailState createState() => _IkanDetailState();
}

class _IkanDetailState extends State<IkanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Ikan'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Id : ${widget.ikan!.id}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.ikan!.namaIkan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Warna : ${widget.ikan!.warnaIkan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Jenis : ${widget.ikan!.jenisIkan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Alamat : ${widget.ikan!.habitatIkan}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IkanForm(
                  ikan: widget.ikan!,
                ),
              ),
            );
          },
        ),
        //Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            IkanBloc.deleteIkan(id: int.parse(widget.ikan!.id!)).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const IkanPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
            // Navigasi ke halaman ProdukForm dengan produk yang akan dihapus
          },
        ),
        // Tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
