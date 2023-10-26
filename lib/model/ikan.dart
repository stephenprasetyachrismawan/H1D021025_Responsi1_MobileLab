class Ikan {
  String? id;
  String? namaIkan;
  String? jenisIkan;

  String? habitatIkan;
  String? warnaIkan;

  Ikan(
      {this.id,
      this.namaIkan,
      this.jenisIkan,
      this.habitatIkan,
      this.warnaIkan});
  factory Ikan.fromJson(Map<String, dynamic> obj) {
    return Ikan(
        id: obj['id'],
        namaIkan: obj['nama'],
        jenisIkan: obj['jenis'],
        habitatIkan: obj['habitat'],
        warnaIkan: obj['warna']);
  }
}
