with 
    stg_produtos as (
        select * from {{ ref('stg_adventure_works__production_product') }}
    ),

    transformed as (
        select
            md5(cast(id_produto as string)) as sk_produto,
            id_produto,
            codigo_produto,
            nome_produto
        from stg_produtos
    )

select *
from transformed