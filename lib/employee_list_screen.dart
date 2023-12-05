import 'dart:developer';

import 'package:admin/api/api_urls.dart';
import 'package:admin/api/http_service.dart';
import 'package:admin/chat_screen.dart';
import 'package:admin/controller/employee_controller.dart';
import 'package:admin/controller/ticket_controller.dart';
import 'package:admin/employee_details_screen.dart';
import 'package:admin/helping_widgets.dart';
import 'package:admin/main.dart';
import 'package:admin/model/add_employee_model.dart';
import 'package:admin/model/change_status_model.dart';
import 'package:admin/model/employee_list_model.dart';
import 'package:admin/model/ticket_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;


  @override
  void initState() {

    tabController = TabController(length: 2, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final empController = Get.put(EmployeeController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 2,
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary.withOpacity(.2),
        title: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TabBar(
                    onTap: (index) {
                      empController.loading = false;
                      setState(() {});
                    },
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    indicatorColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    tabs: [Text("Employees"), Text("Tickets")]),
              ),
            ),
            Spacer(),
            InkWell(
                onTap: () async {
                  await HttpService().get(url: ApiBaseUrl.logout);
                  Get.offAll(() => MyHomePage(title: ''));
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextField(
                      controller: empController.searchController,
                      onChanged: (value) {
                        if (tabController?.index == 0) {
                          empController.searchEmp(value);
                        }else{
                          final ticketController = Get.put(TicketController());
                          ticketController.searchTicket(value);
                        }
                      },
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 0, bottom: 10, left: 10),
                          hintText: tabController?.index == 0
                              ? "Search employee here..."
                              : "Search ticket here...",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                if (tabController?.index == 0) ...[
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        _addEmployeeDialog();
                      },
                      child: Icon(
                        Icons.add_circle_sharp,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.add_chart,
                    color: Colors.white,
                  ),
                ],
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    if(tabController!.index==0){
                      empController.getEmployeeList();
                    }else{
                      final ticketController = Get.put(TicketController());
                      ticketController.getTicketList();
                    }
                  },
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [_empList(), _ticketList()],
            ),
          ),
        ],
      ),
    );
  }

  _ticketList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                "ID",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Employee",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Created At",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Title",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "Desciption",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
              Expanded(
                  child: Text(
                "",
                style: TextStyle(fontSize: 13, color: Colors.white),
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GetBuilder(
            init: TicketController(),
            builder: (ctx) {
              return Expanded(
                child:ctx.ticketListModel==null?Center(
                  child: SpinKitCubeGrid(
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary,
                  ),
                ): RawScrollbar(
                  thumbColor: Colors.white,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: ctx.scrollController,
                  child: ListView.separated(
                      controller: ctx.scrollController,
                      itemCount: ctx.ticketListModel?.data?.data?.length??0,
                      separatorBuilder: (context, i) => Container(
                        height: 1,
                        color: Colors.grey.withOpacity(.2),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      itemBuilder: (context, i) {
                        TicketData data = ctx.ticketListModel?.data?.data?[i]??TicketData();
                        return InkWell(
                          onTap: () {
                            Get.to(() =>  ChatScreen(ticketId: data.id.toString(),title: data.title??"",))!.then((value){
                              ctx.getTicketList();
                            });
                          },
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "${data.id}",
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                  )),
                              Expanded(
                                  child: Text(
                                    "${data.userInfo?.fullName??""}",
                                    style: const TextStyle(fontSize: 13, color: Colors.white),
                                  )),
                              Expanded(
                                  child: Text(
                                    "${DateFormat("dd-MMM-yyyy HH:mm").format(DateTime.parse(data.createdAt??"").toLocal())}",
                                    style: TextStyle(fontSize: 13, color: Colors.white),
                                  )),
                              Expanded(
                                  child: Text(
                                    "${data.title}",
                                    style: TextStyle(fontSize: 13, color: Colors.white),
                                  )),
                              Expanded(
                                  child: Text(
                                    "${data.description}",
                                    style: TextStyle(fontSize: 13, color: Colors.white),
                                  )),
                              Expanded(
                                  child: Row(
                                    children: [
                                      MaterialButton(
                                        onPressed: ()async {
                                          TicketChangeStatusModel model = await ctx.changeTicketStatus(ticketId: data.id.toString());
                                          if(model.statusCode==200){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                model.message ?? "",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              backgroundColor: Colors.white,
                                            ));
                                          }
                                        },
                                        child: const Text("Marked Done"),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  _empList() {
    return Column(
      children: [
        Container(
          color: Colors.white.withOpacity(.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "ID",
                      style: TextStyle(color: Colors.white),
                    )),
                Expanded(
                    flex: 4,
                    child: Align(
                      child: Text(
                        "Name",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Align(
                      child: Text(
                        "Status",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder(
                init: EmployeeController(),
                builder: (ctx) {
                  if (ctx.employeeListModel == null) {
                    return SpinKitCubeGrid(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: RawScrollbar(
                          thumbColor: Colors.white,
                          thumbVisibility: true,
                          trackVisibility: true,
                          controller: ctx.scrollController,
                          child: ListView.separated(
                            controller: ctx.scrollController,
                              itemCount: ctx.employeeListModel?.data?.data?.length ?? 0,
                              separatorBuilder: (context, i) => Divider(
                                    color: Colors.white.withOpacity(.1),
                                  ),
                              itemBuilder: (context, i) {
                                EmpData data =
                                    ctx.employeeListModel?.data?.data?[i] ?? EmpData();
                                return Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text(
                                          "${data.employeeId}",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Align(
                                          child: Text(
                                            "${data.fullName}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Align(
                                          child: Text(
                                            "${data.email}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Align(
                                          child: Text(
                                            "${data.customStatusTitle??"Not Define"}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => EmployeeDetailScreen(userId: data.id.toString(),));
                                            },
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _editEmployeeDialog(data);
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _deletePop(data.id.toString());
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                      if(ctx.loading)
                        CircularProgressIndicator()
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  _deletePop(empId) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  Text(
                    "ALert",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ))
                ],
              ),
              content: Text(
                "Do you really want to remove this employee",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                          final empController = Get.put(EmployeeController());
                          empController.deleteEmployee(empId: empId);
                        },
                        child: Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("No")),
                  ],
                )
              ],
            ));
  }

  _addEmployeeDialog() {
    final employeeIdController = TextEditingController();
    final fullNameController = TextEditingController();
    final userNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          bool obscure = true;
          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (employeeIdController.value.text.trim().isEmpty) {
                      showError("Employee id is required", alert: true);
                      return;
                    }
                    if (fullNameController.value.text.trim().isEmpty) {
                      showError("Full-name is required", alert: true);

                      return;
                    }
                    if (emailController.value.text.trim().isEmpty) {
                      showError("Email is required", alert: true);

                      return;
                    }
                    if (userNameController.value.text.trim().isEmpty) {
                      showError("Username is required", alert: true);
                      return;
                    }
                    if (passwordController.value.text.trim().isEmpty) {
                      showError("Password id is required", alert: true);
                      return;
                    }
                    final empController = Get.put(EmployeeController());
                  var response = await  empController.addEmployee(
                        employeeIdController.value.text,
                        fullNameController.value.text,
                        emailController.value.text,
                        userNameController.value.text,
                        passwordController.value.text);

                    AddEmployeeModel model = AddEmployeeModel.fromJson(response);
                    if (model.statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          model.message ?? "",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                      ));
                      Get.back();
                    }
                  },
                  child: Text("Add Employee"),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ],
              title: Row(
                children: [
                  Text(
                    "Add Employee Details",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ))
                ],
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              content: SizedBox(
                height: 240,
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: employeeIdController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Enter Employee Id",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: fullNameController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Full Name",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: userNameController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "User Name",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Email",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: passwordController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        obscureText: obscure,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  obscure = !obscure;
                                  dialogSetState(() {});
                                },
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: obscure
                                      ? null
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                )),
                            label: const Text(
                              "Password",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  _editEmployeeDialog(EmpData empData) {
    final employeeIdController =
        TextEditingController(text: (empData.employeeId ?? "").toString());
    final fullNameController =
        TextEditingController(text: (empData.fullName ?? "").toString());
    final userNameController =
        TextEditingController(text: (empData.username ?? "").toString());
    final emailController =
        TextEditingController(text: (empData.email ?? "").toString());
    final passwordController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          bool obscure = true;
          return StatefulBuilder(builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: Colors.black,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                ),
                MaterialButton(
                  onPressed: () {
                    Get.back();
                    final controller = Get.put(EmployeeController());
                    empData.username = userNameController.value.text;
                    empData.fullName = fullNameController.value.text;
                    empData.employeeId =
                        int.parse(employeeIdController.value.text);
                    empData.email = emailController.value.text;
                    controller.updateEmployee(
                        empData: empData,
                        password: passwordController.value.text);
                  },
                  child: Text("Update"),
                  color: Theme.of(context).colorScheme.inversePrimary,
                )
              ],
              title: Row(
                children: [
                  Text(
                    "Edit Employee Details",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                      ))
                ],
              ),
              titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              content: SizedBox(
                height: 240,
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: employeeIdController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Enter Employee Id",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: fullNameController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Full Name",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: userNameController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "User Name",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            label: const Text(
                              "Email",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 35,
                      child: TextFormField(
                        controller: passwordController,
                        style: TextStyle(fontSize: 13, color: Colors.white),
                        obscureText: obscure,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  obscure = !obscure;
                                  dialogSetState(() {});
                                },
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: obscure
                                      ? null
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                )),
                            label: const Text(
                              "Password",
                              style: TextStyle(fontSize: 13),
                            ),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
