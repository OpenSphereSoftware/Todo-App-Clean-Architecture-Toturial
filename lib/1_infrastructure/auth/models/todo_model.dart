import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:todoappv0/2_domain/auth/entities/id.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/2_domain/auth/entities/todo_color.dart';

class TodoModel {
  final String id;
  final String title;
  final String body;
  final int color;
  final bool done;
  final dynamic serverTimeStamp;

  TodoModel(
      {required this.id,
      required this.body,
      required this.color,
      required this.done,
      required this.serverTimeStamp,
      required this.title});

  factory TodoModel.fromDomain(Todo todoItem) {
    return TodoModel(
        done: todoItem.done,
        id: todoItem.id.value,
        title: todoItem.title,
        body: todoItem.body,
        color: todoItem.color.color.value,
        serverTimeStamp: FieldValue.serverTimestamp());
  }

  Todo toDomain() {
    return Todo(
      id: UniqueId.fromUniqueString(id),
      title: title,
      body: body,
      done: done,
      color: TodoColor(color: Color(color).withOpacity(1)),
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      done: json['done'] as bool,
      body: json['body'] as String,
      color: json['color'] as int,
      title: json['title'] as String,
      id: "id",
      serverTimeStamp: json['serverTimeStamp'],
    );
  }

  factory TodoModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel.fromJson(doc.data()).copyWith(id: doc.id);
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? body,
    int? color,
    bool? done,
    dynamic serverTimeStamp,
  }) {
    return TodoModel(
      done: done ?? this.done,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      color: color ?? this.color,
      serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'color': color,
      'done': done,
      'serverTimeStamp': serverTimeStamp,
    };
  }


  String toJson() => json.encode(toMap());


}
