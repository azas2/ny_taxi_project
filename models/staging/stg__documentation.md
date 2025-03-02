{% docs stg_greentable %}

| Column Name      | Data Type | Description                                                 |
| ---------------- | --------- | ----------------------------------------------------------- |
| unique_row_id    | STRING    | A unique identifier for each trip record.                   |
| vendor_id        | STRING    | The ID of the provider that reported the trip.              |
| pickup_datetime  | TIMESTAMP | The date and time when the trip started.                    |
| dropoff_datetime | TIMESTAMP | The date and time when the trip ended.                      |
| passenger_count  | INTEGER   | The number of passengers in the vehicle.                    |
| trip_distance    | FLOAT     | The distance of the trip in miles.                          |
| fare_amount      | FLOAT     | The total fare amount for the trip.                         |
| tip_amount       | FLOAT     | The tip amount given to the driver.                         |
| total_amount     | FLOAT     | The total amount paid, including fare, tip, and surcharges. |
| payment_type     | INTEGER   | The payment method used for the trip.                       |

{% enddocs %}
