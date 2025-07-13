import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/material_item.dart';
import '../../domain/entities/warehouse_receipt.dart';
import '../../domain/usecases/warehouse_receipt_usecases.dart';

// Events
abstract class WarehouseReceiptEvent {}

class LoadWarehouseReceipts extends WarehouseReceiptEvent {}

class SearchWarehouseReceipts extends WarehouseReceiptEvent {
  final String keyword;
  SearchWarehouseReceipts(this.keyword);
}

class LoadWarehouseReceiptById extends WarehouseReceiptEvent {
  final String id;
  LoadWarehouseReceiptById(this.id);
}

class AddWarehouseReceiptEvent extends WarehouseReceiptEvent {
  final WarehouseReceipt receipt;
  final List<MaterialItem> items;
  AddWarehouseReceiptEvent(this.receipt, this.items);
}

class UpdateWarehouseReceiptEvent extends WarehouseReceiptEvent {
  final WarehouseReceipt receipt;
  UpdateWarehouseReceiptEvent(this.receipt);
}

class DeleteWarehouseReceiptEvent extends WarehouseReceiptEvent {
  final String id;
  DeleteWarehouseReceiptEvent(this.id);
}

class LoadItemsByReceiptId extends WarehouseReceiptEvent {
  final String receiptId;
  LoadItemsByReceiptId(this.receiptId);
}

class UpdateItemsEvent extends WarehouseReceiptEvent {
  final String receiptId;
  final List<MaterialItem> items;
  UpdateItemsEvent(this.receiptId, this.items);
}

// States
abstract class WarehouseReceiptState {}

class WarehouseReceiptInitial extends WarehouseReceiptState {}

class WarehouseReceiptLoading extends WarehouseReceiptState {}

class WarehouseReceiptLoaded extends WarehouseReceiptState {
  final List<WarehouseReceipt> receipts;
  WarehouseReceiptLoaded(this.receipts);
}

class WarehouseReceiptDetailLoaded extends WarehouseReceiptState {
  final WarehouseReceipt receipt;
  final List<MaterialItem> items;
  WarehouseReceiptDetailLoaded(this.receipt, this.items);
}

class WarehouseReceiptError extends WarehouseReceiptState {
  final String message;
  WarehouseReceiptError(this.message);
}

class WarehouseReceiptSuccess extends WarehouseReceiptState {
  final String message;
  WarehouseReceiptSuccess(this.message);
}

// BLoC
class WarehouseReceiptBloc extends Bloc<WarehouseReceiptEvent, WarehouseReceiptState> {
  final GetWarehouseReceiptList getWarehouseReceiptList;
  final GetWarehouseReceiptById getWarehouseReceiptById;
  final AddWarehouseReceipt addWarehouseReceipt;
  final UpdateWarehouseReceipt updateWarehouseReceipt;
  final DeleteWarehouseReceipt deleteWarehouseReceipt;
  final SearchWarehouseReceipt searchWarehouseReceipt;
  final GetItemsByReceiptId getItemsByReceiptId;
  final UpdateItems updateItems;

  StreamSubscription<Either<Failure, List<WarehouseReceipt>>>? _receiptsSubscription;
  StreamSubscription<Either<Failure, List<MaterialItem>>>? _itemsSubscription;

  WarehouseReceiptBloc({
    required this.getWarehouseReceiptList,
    required this.getWarehouseReceiptById,
    required this.addWarehouseReceipt,
    required this.updateWarehouseReceipt,
    required this.deleteWarehouseReceipt,
    required this.searchWarehouseReceipt,
    required this.getItemsByReceiptId,
    required this.updateItems,
  }) : super(WarehouseReceiptInitial()) {
    on<LoadWarehouseReceipts>(_onLoadWarehouseReceipts);
    on<SearchWarehouseReceipts>(_onSearchWarehouseReceipts);
    on<LoadWarehouseReceiptById>(_onLoadWarehouseReceiptById);
    on<AddWarehouseReceiptEvent>(_onAddWarehouseReceipt);
    on<UpdateWarehouseReceiptEvent>(_onUpdateWarehouseReceipt);
    on<DeleteWarehouseReceiptEvent>(_onDeleteWarehouseReceipt);
    on<LoadItemsByReceiptId>(_onLoadItemsByReceiptId);
    on<UpdateItemsEvent>(_onUpdateItems);
  }

  void _onLoadWarehouseReceipts(
    LoadWarehouseReceipts event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    await _receiptsSubscription?.cancel();
    _receiptsSubscription = getWarehouseReceiptList().listen((result) {
      result.fold(
        (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
        (receipts) => emit(WarehouseReceiptLoaded(receipts)),
      );
    });
  }

  void _onSearchWarehouseReceipts(
    SearchWarehouseReceipts event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    await _receiptsSubscription?.cancel();
    _receiptsSubscription = searchWarehouseReceipt(event.keyword).listen((result) {
      result.fold(
        (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
        (receipts) => emit(WarehouseReceiptLoaded(receipts)),
      );
    });
  }

  void _onLoadWarehouseReceiptById(
    LoadWarehouseReceiptById event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    final result = await getWarehouseReceiptById(event.id);
    result.fold((failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))), (receipt) {
      if (receipt != null) {
        emit(WarehouseReceiptDetailLoaded(receipt, []));
      } else {
        emit(WarehouseReceiptError('Không tìm thấy phiếu nhập kho'));
      }
    });
  }

  void _onAddWarehouseReceipt(
    AddWarehouseReceiptEvent event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    final result = await addWarehouseReceipt(event.receipt, event.items);
    result.fold(
      (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
      (id) => emit(WarehouseReceiptSuccess('Thêm phiếu nhập kho thành công')),
    );
  }

  void _onUpdateWarehouseReceipt(
    UpdateWarehouseReceiptEvent event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    final result = await updateWarehouseReceipt(event.receipt);
    result.fold(
      (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
      (_) => emit(WarehouseReceiptSuccess('Cập nhật phiếu nhập kho thành công')),
    );
  }

  void _onDeleteWarehouseReceipt(
    DeleteWarehouseReceiptEvent event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    emit(WarehouseReceiptLoading());

    final result = await deleteWarehouseReceipt(event.id);
    result.fold(
      (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
      (_) => emit(WarehouseReceiptSuccess('Xóa phiếu nhập kho thành công')),
    );
  }

  void _onLoadItemsByReceiptId(
    LoadItemsByReceiptId event,
    Emitter<WarehouseReceiptState> emit,
  ) async {
    await _itemsSubscription?.cancel();
    _itemsSubscription = getItemsByReceiptId(event.receiptId).listen((result) {
      result.fold((failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))), (items) {
        // Emit current state with updated items
        if (state is WarehouseReceiptDetailLoaded) {
          final currentState = state as WarehouseReceiptDetailLoaded;
          emit(WarehouseReceiptDetailLoaded(currentState.receipt, items));
        }
      });
    });
  }

  void _onUpdateItems(UpdateItemsEvent event, Emitter<WarehouseReceiptState> emit) async {
    emit(WarehouseReceiptLoading());

    final result = await updateItems(event.receiptId, event.items);
    result.fold(
      (failure) => emit(WarehouseReceiptError(_mapFailureToMessage(failure))),
      (_) => emit(WarehouseReceiptSuccess('Cập nhật items thành công')),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message;
      case NetworkFailure:
        return 'Lỗi kết nối mạng';
      case CacheFailure:
        return 'Lỗi cache';
      case ValidationFailure:
        return failure.message;
      default:
        return 'Lỗi không xác định';
    }
  }

  @override
  Future<void> close() {
    _receiptsSubscription?.cancel();
    _itemsSubscription?.cancel();
    return super.close();
  }
}
