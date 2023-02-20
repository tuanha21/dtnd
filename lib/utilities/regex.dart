final RegExp numRegex = RegExp(r'^(-?)(([1-9]+[0-9]*|0)\.)?([0-9]+)$');
final RegExp orderTypeRegex = RegExp(r'^ATO|ATC|MOK|MAK|PLO|MP$');
final specialCharacters = RegExp(r'^[a-zA-Z0-9]+$');
 final RegExp emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

