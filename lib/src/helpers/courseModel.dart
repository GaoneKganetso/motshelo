class UserModel {
  String name;
  String email;
  String password;

  UserModel({
    this.name,
    this.email,
    this.password,
  });
}

class CourseList {
  static List<UserModel> list = [
    UserModel(
      name: "Data Science",
      email:
          "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
    ),
    UserModel(
        name: "Machine Learning",
        email:
            "This specialization from leading researchers at university of washington introduce to you to the exciting high-demand field of machine learning ",
        password: "University of washington"),
    UserModel(
      name: "Big Data",
      email:
          "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
      password: "Us San Diego",
    ),
  ];
}
