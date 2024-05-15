locals{
  myregissql_app=[for f in fileset("${path.module}/configs", "[^_]*.yaml") : yamldecode(file("${path.module}/configs/${f}"))]
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
