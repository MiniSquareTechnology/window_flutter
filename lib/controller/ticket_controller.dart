
import 'package:admin/api/api_urls.dart';
import 'package:admin/api/http_service.dart';
import 'package:admin/model/change_status_model.dart';
import 'package:admin/model/ticket_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketController extends GetxController {
  TicketListModel? ticketListModel;
  ScrollController scrollController = ScrollController();
  bool loading = false;



  searchTicket(search) async {
    loading = false;
    var response = await HttpService().get(
        url: ApiBaseUrl.ticketList,
        hideLoader: true,
        queryParam: {"search": search});
    ticketListModel = TicketListModel.fromJson(response);
    update();
  }

  Future getTicketList() async {
    ticketListModel = null;
    update();
    var response =
    await HttpService().get(url: ApiBaseUrl.ticketList, hideLoader: true);
    ticketListModel = TicketListModel.fromJson(response);
    update();
  }

  Future<TicketChangeStatusModel> changeTicketStatus({required String ticketId}) async {
    var response = await HttpService().post(
        url: ApiBaseUrl.changeTicketStatus, body: {"ticket_id": ticketId});
    TicketChangeStatusModel ticketChangeStatusModel = TicketChangeStatusModel.fromJson(response);
    ticketListModel = TicketListModel.fromJson(response);
    update();
    return ticketChangeStatusModel;
  }

  Future getMoreData()async{
    if (ticketListModel!.data!.currentPage! <
        ticketListModel!.data!.lastPage!) {
      loading = true;
      update();
      var response = await HttpService().get(
          url: ApiBaseUrl.ticketList,
          hideLoader: true,
          queryParam: {
            "page":
            (ticketListModel!.data!.currentPage! + 1).toString()
          });
      TicketListModel model =TicketListModel.fromJson(response);
      ticketListModel!.data!.data!.addAll(model.data!.data!);
      ticketListModel!.data!.currentPage = model.data!.currentPage;
      ticketListModel!.data!.lastPage = model.data!.lastPage;
      loading=false;
      update();
    }
  }

  pagination() {
    scrollController.addListener(() {
      if ((scrollController.offset >
          scrollController.position.maxScrollExtent * .8) &&
          (loading == false)) {
        getMoreData();
      }
    });
  }

  @override
  void onInit() {
    getTicketList();
    pagination();
    // TODO: implement onInit
    super.onInit();
  }
}
