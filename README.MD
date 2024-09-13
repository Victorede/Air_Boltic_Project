## Air Boltic Data Modeling and Analysis

# Project Overview
This project involves designing a data model for Air Boltic, a hypothetical marketplace for sharing aeroplane rides. The primary goal is to enable monitoring and self-service analysis of the service, which includes understanding customer behavior, tracking trip data, aeroplane utilization, and revenue generation.

The data model is designed using normalization techniques to ensure scalability, maintainability, and data integrity as the service grows.

### ER Diagram

```mermaid
erDiagram

    %% Entities

    dim_customers {
        int customer_id PK
        string name
        int customer_group_id FK
        string email
        
    }
    
    dim_customer_groups {
        int customer_group_id PK
        string type
        string name
        string registry_number
    }

    dim_aeroplanes {
        int airplane_id PK
        int model_id FK
    }

    dim_aeroplane_models {
        int model_id PK
        string manufacturer
        int max_seats
        int max_weight
        int max_distance
        string engine_type
    }

    dim_trips {
        int trip_id PK
        string origin_city
        string destination_city
        int airplane_id FK
        timestamp start_timestamp
        timestamp end_timestamp
    }

    fact_orders {
        int order_id PK
        int customer_id FK
        int trip_id FK
        double price
        string seat_no
        int status_id FK
    }

    dim_order_status {
        int status_id PK
        string order_status
    }

    %% Relationships

    dim_customer_groups ||--o{ dim_customers : customer_group_id
    dim_aeroplane_models ||--o{ dim_aeroplanes : model_id
    dim_aeroplanes ||--o{ dim_trips : airplane_id
    dim_customers ||--o{ fact_orders : customer_id
    dim_trips ||--o{ fact_orders : trip_id
    dim_order_status ||--o{ fact_orders : status_id

```

## Data Model Design
The data model is structured to support scalable analytics by organizing the data into fact and dimension tables. It uses a normalized design to ensure minimal redundancy and high data integrity.

### Fact and Dimension Tables
#### Fact Table:

fact_orders: Contains transactional data related to orders placed by customers for specific trips.


#### Dimension Tables:

`dim_customers`: Describes customers and their associated customer groups. 

`dim_aeroplanes`: Describes the specific aeroplanes used for trips, linked to the aeroplane models.

`dim_aeroplane_models`: Describes general aeroplane models and their specifications (manufacturer, max seats, etc.).

`dim_order_status`: Describes the status of the orders (booked, finished, cancelled).

`dim_trips`: Contains detailed trip information including origin, destination, and aircraft used.
## Base, Intermediate, and Mart Layers
The models are structured across three layers in the dbt framework:

`Base (Staging) Layer`: Raw data from the source is cleaned and standardized.

#### models: stg_customers, stg_orders, stg_trips, stg_aeroplanes, stg_aeroplane_models.

`Intermediate (Transform) Layer`: Joins and transformations across the base tables to create meaningful relationships and calculations.

#### models:  int_orders.

`Mart (Fact and Dimension) Layer`: Business-ready tables used for reporting and analysis.

#### Fact Tables: fact_orders.
#### Dimension Tables: dim_customers, dim_aeroplanes, dim_aeroplane_models, dim_order_status.

## Key Metrics Supported by the Data Model
#### Daily/Weekly/Monthly Active Users:

`Fact Table`: Can be tracked by querying the Orders Table to see which customers made bookings or completed trips in a given time period. This data can be aggregated to calculate customer activity for any period.

#### Revenue Analysis:

`Fact Table`: The Orders Table includes the price paid by each customer for a trip. Aggregating this data allows for revenue analysis by trip, by customer group, or by time period. For instance, total revenue per month or per trip can be analyzed by joining the Orders and Trips tables.

#### Aeroplane Utilization:

`Dimension + Fact Tables`: The Trips Table contains information about which aeroplanes were used for each trip. Combining this with the Orders Table (to check how many seats were sold per trip) can give insights into aeroplane utilization (e.g., load factor). This provides an understanding of how efficiently each aeroplane is being used.

#### Geographic Trends:

`Dimension Table`: The Trips Table includes origin and destination cities, enabling analysis of which routes are most popular or which regions may need improvement. You can track which routes generate the most revenue or the highest number of bookings.

#### Customer Segmentation:

`Dimension Table`: The Customers Table and Customer Groups Table allow segmentation based on customer type (e.g., private group vs. corporate clients) and performance tracking per customer group. This can be useful for understanding which customer segments are contributing the most revenue or are the most active.

## How This Supports Self-Service Analysis

#### Self-Service Analysis:

This model allows analysts or business users to easily query key performance metrics across various dimensions, such as:

`Customer behavior`: By querying the fact_orders table and joining with dim_customers, analysts can determine which customers are the most active, which customer groups generate the most revenue, or how frequently a customer books trips.

`Geographic trends`: By using the dim_trips table, analysts can easily track which routes or regions are the most profitable or underused. This helps in optimizing route planning and marketing strategies.

`Aircraft utilization`: By joining the dim_trips and dim_aeroplanes tables with the fact_orders table, analysts can track which aeroplanes are being used most efficiently based on the number of bookings per trip and seat availability.

`Revenue metrics`: The fact_orders table allows for detailed revenue analysis, including breakdowns by customer, customer group, or aeroplane. This can be done by aggregating the price field in the Orders Table across various dimensions like time period, trip, or customer group.

`Flexibility`:
This normalized model reduces redundancy and ensures that the dataset can scale as the business grows. It allows users to join different tables (e.g., Orders, Trips, Aeroplanes) to answer complex questions while maintaining data integrity. The separation of dimensions (such as Trips and Customers) from facts (like Orders) provides flexibility in performing various analyses and deriving actionable insights.

