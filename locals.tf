locals{
  mysql_server_name = azurerm_mysql_server.mysqlapps.name
  myregissql_app=[for f in fileset("${path.module}/config", "[^_]*.yaml") : yamldecode(file("${path.module}/config/${f}"))]
  myregissql_app_list = flatten([
    for app in local.myregissql_app : [
      for msqlapps in try(app.listofmsqlapp, []) :{
        name = mysqlapps.name
        os_type = mysqlapps.os_type
        sku_name = mysqlapps.sku_name

      }
    ]
])
}
