import 'dart:io';

class UploadFileRequestModel{
  String? ownerID;
  String? reasonsRefuseID;
  File? file;
  UploadFileRequestModel({
    this.ownerID,
    this.reasonsRefuseID,
    this.file,
  });
}