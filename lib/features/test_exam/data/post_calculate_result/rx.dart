import 'package:christiandimene/features/test_exam/data/post_calculate_result/api.dart';
import 'package:christiandimene/helpers/loading_helper.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';

final class PostCalculateQuizRx extends RxResponseInt {
  final api = PostCalculateQuizApi.instance;

  PostCalculateQuizRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<Map> calculateResult({
    // required int quizId,
    required Map<String, dynamic> answers,
  }) async {
    try {
      // Map<String, dynamic> body = {
      //   "quiz_id": quizId,
      //   "answers": answers.map((key, value) => MapEntry(key.toString(), value)),
      // };

      Map data = await api.calculateQuiz(body: answers).waitingForFuture();
      await handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);
    return true;
  }
}
