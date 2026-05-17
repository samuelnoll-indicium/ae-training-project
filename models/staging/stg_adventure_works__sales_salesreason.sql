with 
    source as (
        select * from {{ source('adventure_works', 'sales_salesreason') }}
    ),

    renamed as (
        select
            salesreasonid as id_motivo_venda,
            name as nome_motivo,
            reasontype as tipo_motivo
        from source
    )

select *
from renamed