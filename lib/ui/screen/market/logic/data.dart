import 'package:dtnd/=models=/local/i_local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';

class DeleteCatalogData {
  const DeleteCatalogData(this.savedCatalog, this.deleteCatalog);
  final SavedCatalog savedCatalog;
  final LocalCatalog deleteCatalog;
}
