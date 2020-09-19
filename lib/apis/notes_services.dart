//import 'dart:convert';
//import 'package:acm1/models/cart_listing.dart';
//import 'package:acm1/models/note_insert.dart';
import 'package:acm1/alerts/api_response.dart';
import 'package:http/http.dart' as http;

class NotesService {
  static const API = 'http://api.notes.programmingaddict.com/notes';
  static const headers = {
    'apiKey': '046e8c63-8dda-4a11-a396-0f5a74ef2f7c',
    'Content-Type': 'application/json'
  };

  /* Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API , headers: headers).then((dat) {
      if (dat.statusCode == 200) {
        final jsonData = json.decode(dat.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An Error efklmkfln Occurred');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An Error cjjc  Occurred'));
  } 

  Future<APIResponse<bool>> createNote(NoteInsert item) {
    return http
        .post(API, headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An Error  4uihrfu Occurred');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'An Error  t3fiedwyk Occurred'));
  } */

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(API + noteID, headers: headers).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An Error  4uihrfu Occurred');
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An Error  t3fiedwyk Occurred'));
  }

/*
   Future<APIResponse<bool>> updateNote(String noteID, NoteInsert item) {
    return http
        .put(API + '/notes/' + noteID,
            headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An Error  4uihrfu Occurred');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'An Error  t3fiedwyk Occurred'));
  } 

Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An Error Occurred');
    }).catchError((_) =>
        APIResponse<Note>(error: true, errorMessage: 'An Error Occurred'));
  }
*/
}
