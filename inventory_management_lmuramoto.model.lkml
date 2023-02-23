connection: "cloud-bi-empathy-session"

include: "/views/distribution_centers.view.lkml"                # include all views in the views/ folder in this project
include: "/views/inventory_items.view.lkml"                # include all views in the views/ folder in this project
include: "/views/order_items.view.lkml"                # include all views in the views/ folder in this project


# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: order_items {
  join: inventory_items {
    relationship: many_to_one
    sql_on: ${order_items.product_id} = ${inventory_items.product_id} ;;
  }

  join: distribution_centers {
    relationship: many_to_many
    sql_on:  ${inventory_items.product_distribution_center_id} = ${distribution_centers.id} ;;
  }
}
