import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/interface/family_repository.dart';
import 'package:core/services/dio/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_repository_impl.g.dart';

class FamilyRepositoryImpl implements FamilyRepository {
  final Dio dio;

  FamilyRepositoryImpl({required this.dio});

  @override
  Future<bool> create(FamilyModel family, String token) async {
    try {
      final response = await dio.post(
        '/institutions/1/families',
        data: family.toJson(),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.statusCode == 201;

    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> delete(String cpf, String token) async {
    try {
      final response = await dio.delete(
        '/institutions/1/families/$cpf',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<List<FamilyModel>> findAll() async {
    try {
      final response = await dio.get('/institutions/1/families');
      return (response.data as List)
          .map((family) => FamilyModel.fromJson(family))
          .toList();
    } on DioException catch (e) {
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> update(FamilyModel family, String token) async {
    try {
      final familyJson = family.toJson();

      if (family.members != null && family.members!.isNotEmpty) {
        familyJson['members'] = family.members!.map((p) => p.toJson()).toList();
      } else {
        familyJson.remove('members');
      }

      final response = await dio.put(
        '/institutions/1/families/${familyJson['cpf']}',
        data: familyJson,
        options: Options(
          headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500 && family.members != null && family.members!.isNotEmpty) {
        throw Exception("Membro de família já cadastrado");
      }
      final message = e.response?.data['detail']?.toString() ?? 'Erro Inesperado';
      throw Exception(message);
    }
  }

  @override
  Future<bool> uploadDocument({
    required String cpf,
    required String docType,
    required String filePath,
  }) async {
    try {
      final fileName = filePath.split('/').last;

      final formData = FormData.fromMap({
        "doc_type": docType,
        "file": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/institutions/1/families/$cpf/documents',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      final msg = e.response?.data?['detail']?.toString() ??
          'Erro ao enviar documento';
      throw Exception(msg);
    }
  }

  Future<List<dynamic>> getDocuments(String cpf) async {
    try {
      final response = await dio.get(
        '/institutions/1/families/$cpf/documents',
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data['detail'] ?? "Erro ao buscar documentos");
    }
  }

Future<void> downloadDocument(String cpf, int id) async {
  try {
    final response = await dio.get(
      '/institutions/1/families/$cpf/documents/$id/download',
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    String? filename = "arquivo";
    final cd = response.headers.value('content-disposition');
    if (cd != null && cd.contains("filename=")) {
      filename = cd.split("filename=").last.replaceAll('"', '').split(".").first;
    }

    String? extension = "bin";
    if (cd != null && cd.contains(".")) {
      extension = cd.split(".").last.replaceAll('"', '').trim();
    } else {
      final mime = response.headers.value('content-type') ?? "";
      extension = _guessExtension(mime);
    }

    await FileSaver.instance.saveAs(
      name: filename,
      bytes: response.data,
      fileExtension: extension,
      mimeType: MimeType.other,
    );
  } catch (e) {
    throw Exception("Erro ao baixar arquivo: $e");
  }
}

String _guessExtension(String mime) {
  switch (mime.toLowerCase()) {
    case "application/pdf":
      return "pdf";
    case "image/png":
      return "png";
    case "image/jpeg":
      return "jpg";
    default:
      return "bin";
  }
}

}

@riverpod
FamilyRepository familyRepository(Ref ref) {
  return FamilyRepositoryImpl(dio: ref.watch(dioProvider));
}
