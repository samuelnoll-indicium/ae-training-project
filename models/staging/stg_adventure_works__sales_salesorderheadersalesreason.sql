with 
    source as (
        select * from {{ source('adventure_works', 'sales_salesorderheadersalesreason') }}
    ),

    renamed as (
        select
            salesorderid as id_pedido,
            salesreasonid as id_motivo_venda
        from source
    )

select *
from renamed