import 'package:flutter/material.dart';

sealed class TodoStatus{}

@immutable
final class NotStarted implements TodoStatus{}

@immutable
final class InProgress implements TodoStatus{}

@immutable
final class Finished implements TodoStatus{}
