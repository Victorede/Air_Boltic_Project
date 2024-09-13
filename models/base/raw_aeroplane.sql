-- Load the JSON data into a table. This table will be created on databricks and used as a source

create or replace table bronze_production.events.raw_aeroplane as
select
'{
  "Boeing": {
    "737-800": {
      "max_seats": 189,
      "max_weight": 79015,
      "max_distance": 2935,
      "engine_type": "CFM56-7B"
    },
    "777-300ER": {
      "max_seats": 396,
      "max_weight": 351535,
      "max_distance": 7930,
      "engine_type": "GE90-115B"
    },
    "787-9": {
      "max_seats": 296,
      "max_weight": 254000,
      "max_distance": 7635,
      "engine_type": "GEnx-1B"
    }
  },
  "Airbus": {
    "A320neo": {
      "max_seats": 194,
      "max_weight": 79000,
      "max_distance": 3700,
      "engine_type": "CFM LEAP-1A"
    },
    "A350-900": {
      "max_seats": 440,
      "max_weight": 280000,
      "max_distance": 8100,
      "engine_type": "Rolls-Royce Trent XWB"
    }
  }
}' as json_data;
