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
        string phone_number
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

    fact_trips {
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
        string status
    }

    %% Relationships

    dim_customer_groups ||--o{ dim_customers : customer_group_id
    dim_aeroplane_models ||--o{ dim_aeroplanes : model_id
    dim_aeroplanes ||--o{ fact_trips : airplane_id
    dim_customers ||--o{ fact_orders : customer_id
    fact_trips ||--o{ fact_orders : trip_id
    dim_order_status ||--o{ fact_orders : status_id

```

## Data Model Design
The data model is structured to support scalable analytics by organizing the data into fact and dimension tables. It uses a normalized design to ensure minimal redundancy and high data integrity.

### Fact and Dimension Tables
#### Fact Tables:

fact_orders: Contains transactional data related to orders placed by customers for specific trips.
fact_trips: Contains detailed trip information including origin, destination, and aircraft used.

#### Dimension Tables:

`dim_customers`: Describes customers and their associated customer groups. 

`dim_aeroplanes`: Describes the specific aeroplanes used for trips, linked to the aeroplane models.

`dim_aeroplane_models`: Describes general aeroplane models and their specifications (manufacturer, max seats, etc.).

`dim_order_status`: Describes the status of the orders (booked, finished, cancelled).

## Base, Intermediate, and Mart Layers
The models are structured across three layers in the dbt framework:

`Base (Staging) Layer`: Raw data from the source is cleaned and standardized.

#### models: stg_customers, stg_orders, stg_trips, stg_aeroplanes, stg_aeroplane_models.

`Intermediate (Transform) Layer`: Joins and transformations across the base tables to create meaningful relationships and calculations.

#### models: int_customers_with_groups, int_trips_with_planes, int_orders_with_status.

`Mart (Fact and Dimension) Layer`: Business-ready tables used for reporting and analysis.

#### Fact Tables: fact_orders, fact_trips.
#### Dimension Tables: dim_customers, dim_aeroplanes, dim_aeroplane_models, dim_order_status.