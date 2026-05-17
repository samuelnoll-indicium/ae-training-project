with 
    stg_reason as (
        select * from {{ ref('stg_adventure_works__sales_salesreason') }}
    ),

    transformed as (
        select
            md5(cast(id_motivo_venda as string)) as sk_motivo_venda,
            id_motivo_venda,
            nome_motivo,
            tipo_motivo
        from stg_reason
    )

select *
from transformed