with 
    stg_cartoes as (
        select * from {{ ref('stg_adventure_works__sales_creditcard') }}
    ),

    transformed as (
        select
            md5(cast(id_cartao as string)) as sk_cartao,
            id_cartao,
            tipo_cartao
        from stg_cartoes
    )

select *
from transformed