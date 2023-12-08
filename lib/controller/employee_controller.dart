import 'package:admin/api/api_urls.dart';
import 'package:admin/api/http_service.dart';
import 'package:admin/employee_list_screen.dart';
import 'package:admin/model/employee_history_model.dart';
import 'package:admin/model/employee_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class EmployeeController extends GetxController {
  EmployeeListModel? employeeListModel;
  EmployeeHistoryModel? employeeHistoryModel;
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerEmp = ScrollController();
  bool loading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    getEmployeeList();
    pagination();
    // TODO: implement onInit
    super.onInit();
  }
  
  getHistory({required String userId})async{
    employeeHistoryModel = null;
    var response = await HttpService().post(url: ApiBaseUrl.historyList, body: {
      "user_id":userId
    },hideLoader: true);
    employeeHistoryModel = EmployeeHistoryModel.fromJson(response);
    update();
  }

  pagination() {
    scrollController.addListener(() {
      if ((scrollController.offset >
              scrollController.position.maxScrollExtent * .8) &&
          (loading == false)) {
        getMoreDataEmpList();
      }
    });
  }

  getMoreDataEmpList() async {
    if (employeeListModel!.data!.currentPage! <
        employeeListModel!.data!.lastPage! && searchController.value.text.isEmpty) {
      loading = true;
      update();
      var response = await HttpService().get(
          url: ApiBaseUrl.getEmployee,
          hideLoader: true,
          queryParam: {
            "page":
                (employeeListModel!.data!.currentPage! + 1).toString()
          });
      EmployeeListModel model =EmployeeListModel.fromJson(response);
      employeeListModel!.data!.data!.addAll(model.data!.data!);
      employeeListModel!.data!.currentPage = model.data!.currentPage;
      employeeListModel!.data!.lastPage = model.data!.lastPage;
      loading=false;
      update();
    }
  }

  getEmployeeList() async {
    loading = false;
    employeeListModel = null;
    update();
    var response =
        await HttpService().get(url: ApiBaseUrl.getEmployee, hideLoader: true);
    employeeListModel = EmployeeListModel.fromJson(response);
    update();
  }

  searchEmp(search) async {
    loading = false;
    var response = await HttpService().get(
        url: ApiBaseUrl.getEmployee,
        hideLoader: true,
        queryParam: {"search": search});
    employeeListModel = EmployeeListModel.fromJson(response);
    update();
  }

  deleteEmployee({required String empId}) async {
    loading = false;
    var response = await HttpService()
        .post(url: ApiBaseUrl.deleteEmployee, body: {"user_id": empId});
    employeeListModel = EmployeeListModel.fromJson(response);
    update();
  }

  updateEmployee({required EmpData empData, required String password}) async {
    loading = false;
    var response = await HttpService().post(
        url: ApiBaseUrl.updateEmployee,
        body: {
          "user_id": empData.id.toString(),
          "emp_id": empData.employeeId.toString(),
          "full_name": empData.fullName,
          "email": empData.email,
          "username": empData.username,
          "password": password
        },
        alertError: true);
    employeeListModel = EmployeeListModel.fromJson(response);
    update();
  }

  addEmployee(empId, fullName, email, username, password) async {
    loading = false;
    var body = await HttpService().post(
      url: ApiBaseUrl.createEmployee,
      body: {
        "employee_id": empId,
        "full_name": fullName,
        "email": email,
        "username": username,
        "password": password,
      },
      alertError: true,
    );
    employeeListModel = EmployeeListModel.fromJson(body);
    update();
    return body;
  }
}
