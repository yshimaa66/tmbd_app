// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'all_popular_persons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AllPopularPersons _$AllPopularPersonsFromJson(Map<String, dynamic> json) {
  return _AllPopularPersons.fromJson(json);
}

/// @nodoc
mixin _$AllPopularPersons {
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int? get totalPages => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_results')
  int? get totalResults => throw _privateConstructorUsedError;
  List<PopularPerson>? get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllPopularPersonsCopyWith<AllPopularPersons> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllPopularPersonsCopyWith<$Res> {
  factory $AllPopularPersonsCopyWith(
          AllPopularPersons value, $Res Function(AllPopularPersons) then) =
      _$AllPopularPersonsCopyWithImpl<$Res>;
  $Res call(
      {int? page,
      @JsonKey(name: 'total_pages') int? totalPages,
      @JsonKey(name: 'total_results') int? totalResults,
      List<PopularPerson>? results});
}

/// @nodoc
class _$AllPopularPersonsCopyWithImpl<$Res>
    implements $AllPopularPersonsCopyWith<$Res> {
  _$AllPopularPersonsCopyWithImpl(this._value, this._then);

  final AllPopularPersons _value;
  // ignore: unused_field
  final $Res Function(AllPopularPersons) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
    Object? results = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: totalResults == freezed
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      results: results == freezed
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PopularPerson>?,
    ));
  }
}

/// @nodoc
abstract class _$$_AllPopularPersonsCopyWith<$Res>
    implements $AllPopularPersonsCopyWith<$Res> {
  factory _$$_AllPopularPersonsCopyWith(_$_AllPopularPersons value,
          $Res Function(_$_AllPopularPersons) then) =
      __$$_AllPopularPersonsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? page,
      @JsonKey(name: 'total_pages') int? totalPages,
      @JsonKey(name: 'total_results') int? totalResults,
      List<PopularPerson>? results});
}

/// @nodoc
class __$$_AllPopularPersonsCopyWithImpl<$Res>
    extends _$AllPopularPersonsCopyWithImpl<$Res>
    implements _$$_AllPopularPersonsCopyWith<$Res> {
  __$$_AllPopularPersonsCopyWithImpl(
      _$_AllPopularPersons _value, $Res Function(_$_AllPopularPersons) _then)
      : super(_value, (v) => _then(v as _$_AllPopularPersons));

  @override
  _$_AllPopularPersons get _value => super._value as _$_AllPopularPersons;

  @override
  $Res call({
    Object? page = freezed,
    Object? totalPages = freezed,
    Object? totalResults = freezed,
    Object? results = freezed,
  }) {
    return _then(_$_AllPopularPersons(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPages: totalPages == freezed
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int?,
      totalResults: totalResults == freezed
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int?,
      results: results == freezed
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<PopularPerson>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AllPopularPersons extends _AllPopularPersons {
  _$_AllPopularPersons(
      {this.page,
      @JsonKey(name: 'total_pages') this.totalPages,
      @JsonKey(name: 'total_results') this.totalResults,
      final List<PopularPerson>? results})
      : _results = results,
        super._();

  factory _$_AllPopularPersons.fromJson(Map<String, dynamic> json) =>
      _$$_AllPopularPersonsFromJson(json);

  @override
  final int? page;
  @override
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @override
  @JsonKey(name: 'total_results')
  final int? totalResults;
  final List<PopularPerson>? _results;
  @override
  List<PopularPerson>? get results {
    final value = _results;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AllPopularPersons(page: $page, totalPages: $totalPages, totalResults: $totalResults, results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AllPopularPersons &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality()
                .equals(other.totalPages, totalPages) &&
            const DeepCollectionEquality()
                .equals(other.totalResults, totalResults) &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(totalPages),
      const DeepCollectionEquality().hash(totalResults),
      const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  _$$_AllPopularPersonsCopyWith<_$_AllPopularPersons> get copyWith =>
      __$$_AllPopularPersonsCopyWithImpl<_$_AllPopularPersons>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllPopularPersonsToJson(
      this,
    );
  }
}

abstract class _AllPopularPersons extends AllPopularPersons {
  factory _AllPopularPersons(
      {final int? page,
      @JsonKey(name: 'total_pages') final int? totalPages,
      @JsonKey(name: 'total_results') final int? totalResults,
      final List<PopularPerson>? results}) = _$_AllPopularPersons;
  _AllPopularPersons._() : super._();

  factory _AllPopularPersons.fromJson(Map<String, dynamic> json) =
      _$_AllPopularPersons.fromJson;

  @override
  int? get page;
  @override
  @JsonKey(name: 'total_pages')
  int? get totalPages;
  @override
  @JsonKey(name: 'total_results')
  int? get totalResults;
  @override
  List<PopularPerson>? get results;
  @override
  @JsonKey(ignore: true)
  _$$_AllPopularPersonsCopyWith<_$_AllPopularPersons> get copyWith =>
      throw _privateConstructorUsedError;
}
