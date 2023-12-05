class ApiBaseUrl{

  static const baseUrl = "https://windows.minisquaretechnologies.com";

  static const login = "$baseUrl/api/v1/admin/adminLogin";
  static const createEmployee = "$baseUrl/api/v1/admin/createEmploye";
  static const getEmployee = "$baseUrl/api/v1/admin/getEmployeWithSearch";
  static const deleteEmployee = "$baseUrl/api/v1/admin/deleteEmploye";
  static const updateEmployee = "$baseUrl/api/v1/admin/updateProfile";
  static const ticketList = "$baseUrl/api/v1/user/ticketList";
  static const changeTicketStatus = "$baseUrl/api/v1/user/changeTicketStatus";
  static const sendMessage = "$baseUrl/api/v1/user/sendMessage";
  static const getMessages = "$baseUrl/api/v1/user/getMessages";
  static const logout = "$baseUrl/api/v1/user/logout";
  static const historyList = "$baseUrl/api/v1/user/get/history";
}