with 
    source as (
        select * from {{ source('adventure_works', 'sales_creditcard') }}
    ),

    renamed as (
        select
            creditcardid as id_cartao,
            cardtype as tipo_cartao
        from source
    )

select *
from renamed