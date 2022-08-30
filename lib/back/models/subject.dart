class subject {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String countryID;
  final String majorID;
  final String gradeID;
  final String typeOfSchoolID;
  final String teacherID;
  final String chaptersPerLevel;
  final String imageURL;


  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  subject({required this.idToEdit, required this.nameAr, required this.nameEN, required this.countryID
    , required this.majorID, required this.gradeID, required this.typeOfSchoolID
    , required this.teacherID, required this.chaptersPerLevel, required this.imageURL
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}


class chapter {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String subjectID;
  final String mrID;
  final int chNum;


  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  chapter({required this.idToEdit, required this.nameAr, required this.nameEN, required this.subjectID
    , required this.mrID, required this.chNum
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}


class lesson {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String subjectID;
  final String chapterID;
  final String mrID;
  final int lessNum;


  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  lesson({required this.idToEdit, required this.nameAr, required this.nameEN, required this.subjectID
    , required this.chapterID, required this.mrID, required this.lessNum
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}


class video {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String URL;
  final String subjectID;
  final String chapterID;
  final String lessonID;
  final String mrID;
  final int vidNum;
  final String imgURL;
  final String documentURL;


  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  video({required this.idToEdit, required this.nameAr, required this.nameEN, required this.URL,
    required this.subjectID, required this.chapterID, required this.lessonID, required this.mrID,
    required this.vidNum, required this.imgURL, required this.documentURL
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}


class question {

  final String idToEdit;
  final String questionText;
  final String ansOne;
  final String ansTwo;
  final String ansThree;
  final String ansFour;
  final int correctAns;
  final String subjectID;
  final String chOrVidID;
  final int qNum;


  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  question({required this.idToEdit, required this.questionText, required this.ansOne, required this.ansTwo
    , required this.ansThree, required this.ansFour, required this.correctAns, required this.subjectID
    , required this.chOrVidID, required this.qNum
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}