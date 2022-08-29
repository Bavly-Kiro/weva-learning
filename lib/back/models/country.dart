class country {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String code;
  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  country({required this.idToEdit, required this.nameAr, required this.nameEN, required this.code
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}



class major {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String countryID;
  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  major({required this.idToEdit, required this.nameAr, required this.nameEN, required this.countryID
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}


class grade {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String countryID;
  final String majorID;

  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  grade({required this.idToEdit, required this.nameAr, required this.nameEN, required this.countryID
    , required this.majorID
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}



class school {

  final String idToEdit;
  final String nameAr;
  final String nameEN;
  final String countryID;
  final String majorID;
  final String gradeID;

  final String userDoneAction;
  final String LastUserDoneAction;
  final String status;




  school({required this.idToEdit, required this.nameAr, required this.nameEN, required this.countryID
    , required this.majorID, required this.gradeID
    , required this.userDoneAction, required this.LastUserDoneAction, required this.status});
}