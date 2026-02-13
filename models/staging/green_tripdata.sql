select *
--                     raw data                 table 
from {{ source('strategic-cacao-484207-e4', 'green_tripdata')}}