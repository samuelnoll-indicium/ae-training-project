with 
    source as (
        select * from {{ source('adventure_works', 'sales_customer') }}
    ),

    renamed as (
        select
            customerid as id_cliente,
            personid as id_pessoa,
            cast(storeid as int) as id_loja,
            territoryid as id_territorio
        from source
    )

select *
from renamed