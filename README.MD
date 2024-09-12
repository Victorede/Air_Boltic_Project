## Air Boltic Data Modeling and Analysis

# Project Overview
This project involves designing a data model for Air Boltic, a hypothetical marketplace for sharing aeroplane rides. The primary goal is to enable monitoring and self-service analysis of the service, which includes understanding customer behavior, tracking trip data, aeroplane utilization, and revenue generation.

The data model is designed using normalization techniques to ensure scalability, maintainability, and data integrity as the service grows.


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
        string airplane_model
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

    dim_customer_groups     ||--o{     dim_customers     : customer_group_id
    dim_aeroplane_models    ||--o{     dim_aeroplanes    : model_id
    fact_trips              ||--o{     dim_aeroplanes    : airplane_id
    fact_orders             ||--o{     dim_customers     : customer_id
    fact_orders             ||--o{     fact_trips        : trip_id
    fact_orders             ||--o{     dim_order_status  : status_id

## Data Model Design
The data model is structured to support scalable analytics by organizing the data into fact and dimension tables. It uses a normalized design to ensure minimal redundancy and high data integrity.

Fact and Dimension Tables
Fact Tables:

fact_orders: Contains transactional data related to orders placed by customers for specific trips.
fact_trips: Contains detailed trip information including origin, destination, and aircraft used.
Dimension Tables:

dim_customers: Describes customers and their associated customer groups.
dim_aeroplanes: Describes the specific aeroplanes used for trips, linked to the aeroplane models.
dim_aeroplane_models: Describes general aeroplane models and their specifications (manufacturer, max seats, etc.).
dim_order_status: Describes the status of the orders (booked, finished, cancelled).
