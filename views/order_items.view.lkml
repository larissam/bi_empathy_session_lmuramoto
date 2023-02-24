view: order_items {
  sql_table_name: `bigquery-public-data.thelook_ecommerce.order_items`
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: number
    sql: ${TABLE}.product_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, inventory_items.id, inventory_items.product_name]
  }

  dimension_group: processing_time {
    type: duration
    intervals: [
      hour,
      day,
      week,
      month,
      quarter,
      year
    ]
    sql_start: ${TABLE}.created_at ;;
    sql_end: ${TABLE}.shipped_at;;
  }

  measure: avg_processing_time {
    type: average
    sql: ${hours_processing_time};; # this was hard. "hours" is a bit magical
  }

  # this was the answer but it isn't DB agnostic
  measure: avg_processing_time_answer {
    type:  average
    sql:  TIMESTAMP_DIFF(${TABLE}.shipped_at, ${TABLE}.created_at, HOUR) ;;
  }

  dimension_group: shipping_time {
    type:  duration
    intervals: [ hour ]
    sql_start:  ${TABLE}.shipped_at ;;
    sql_end:  ${TABLE}.delivered_at ;;
  }

  measure: avg_shipping_time {
    type:  average
    sql:  ${hours_shipping_time} ;;
  }


}
